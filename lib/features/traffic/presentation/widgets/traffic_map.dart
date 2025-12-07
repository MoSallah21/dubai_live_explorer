<<<<<<< Updated upstream
=======
// features/traffic/presentation/widgets/traffic_map.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class TrafficMap extends StatefulWidget {
  final List<LatLng> coordinates;
  final String congestionLevel;

  const TrafficMap({
    super.key,
    required this.coordinates,
    required this.congestionLevel,
  });

  @override
  State<TrafficMap> createState() => _TrafficMapState();
}

class _TrafficMapState extends State<TrafficMap> with TickerProviderStateMixin {
  GoogleMapController? _mapController;
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};

  late AnimationController _pulseController;
  late AnimationController _fadeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  Timer? _dashAnimationTimer;
  int _dashOffset = 0;

  @override
  void initState() {
    super.initState();

    // Pulse animation for high congestion indicator
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Fade animation for overlays
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();
    _setupMapElements();
    _startDashAnimation();
  }

  @override
  void didUpdateWidget(TrafficMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.coordinates != widget.coordinates ||
        oldWidget.congestionLevel != widget.congestionLevel) {
      _fadeController.reset();
      _fadeController.forward();
      _setupMapElements();

      // Smooth camera animation when coordinates change
      if (widget.coordinates.isNotEmpty && _mapController != null) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _fitBounds();
        });
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fadeController.dispose();
    _dashAnimationTimer?.cancel();
    _mapController?.dispose();
    super.dispose();
  }

  // ===== Map Setup Methods =====

  void _setupMapElements() {
    if (widget.coordinates.isEmpty) return;

    // Create animated polyline based on congestion level
    final polyline = Polyline(
      polylineId: const PolylineId('traffic_route'),
      points: widget.coordinates,
      color: _getPolylineColor(),
      width: 7,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
      // Dashed pattern for high congestion
      patterns: widget.congestionLevel.toLowerCase() == 'high'
          ? [PatternItem.dash(25), PatternItem.gap(15)]
          : [],
    );

    // Create custom markers for start and end points
    _createCustomMarkers();

    setState(() {
      _polylines = {polyline};
    });
  }

  Future<void> _createCustomMarkers() async {
    if (widget.coordinates.isEmpty) return;

    // Start marker with custom icon
    final startMarker = Marker(
      markerId: const MarkerId('start'),
      position: widget.coordinates.first,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: const InfoWindow(
        title: '🚦 Start Point',
        snippet: 'Route beginning',
      ),
      alpha: 0.95,
    );

    // End marker with custom icon
    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: widget.coordinates.last,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(
        title: '🎯 End Point',
        snippet: 'Route destination',
      ),
      alpha: 0.95,
    );

    setState(() {
      _markers = {startMarker, endMarker};
    });
  }

  void _startDashAnimation() {
    if (widget.congestionLevel.toLowerCase() == 'high') {
      _dashAnimationTimer = Timer.periodic(
        const Duration(milliseconds: 100),
            (timer) {
          setState(() {
            _dashOffset = (_dashOffset + 1) % 40;
          });
        },
      );
    }
  }

  // ===== Map Control Methods =====

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    // Apply dark mode styling if needed
    // _mapController?.setMapStyle(darkModeStyle);

    // Fit bounds to show all coordinates with smooth animation
    if (widget.coordinates.length > 1) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _fitBounds();
      });
    }
  }

  void _fitBounds() {
    if (_mapController == null || widget.coordinates.isEmpty) return;

    double minLat = widget.coordinates.first.latitude;
    double maxLat = widget.coordinates.first.latitude;
    double minLng = widget.coordinates.first.longitude;
    double maxLng = widget.coordinates.first.longitude;

    for (var coord in widget.coordinates) {
      if (coord.latitude < minLat) minLat = coord.latitude;
      if (coord.latitude > maxLat) maxLat = coord.latitude;
      if (coord.longitude < minLng) minLng = coord.longitude;
      if (coord.longitude > maxLng) maxLng = coord.longitude;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    // Smooth camera animation with padding
    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 80),
    );
  }

  // ===== Helper Methods =====

  Color _getPolylineColor() {
    switch (widget.congestionLevel.toLowerCase()) {
      case 'low':
        return const Color(0xFF4CAF50); // Green
      case 'moderate':
        return const Color(0xFFFF9800); // Orange
      case 'high':
        return const Color(0xFFF44336); // Red
      default:
        return const Color(0xFF2196F3); // Blue
    }
  }

  LatLng _getCenterPosition() {
    if (widget.coordinates.isEmpty) {
      return const LatLng(25.2048, 55.2708); // Default Dubai coordinates
    }

    double totalLat = 0;
    double totalLng = 0;

    for (var coord in widget.coordinates) {
      totalLat += coord.latitude;
      totalLng += coord.longitude;
    }

    return LatLng(
      totalLat / widget.coordinates.length,
      totalLng / widget.coordinates.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final congestionColor = _getPolylineColor();
    final isHighCongestion = widget.congestionLevel.toLowerCase() == 'high';

    return Stack(
      children: [
        // ===== Google Map =====
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _getCenterPosition(),
            zoom: 13.5,
          ),
          polylines: _polylines,
          markers: _markers,
          trafficEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          mapType: MapType.normal,
          padding: const EdgeInsets.only(
            top: 80,
            bottom: 80,
            left: 16,
            right: 16,
          ),
          gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
            Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
            ),
          },
        ),

        // ===== Traffic Legend Overlay (Top Right) =====
        Positioned(
          top: 16,
          right: 16,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: _buildTrafficLegend(),
          ),
        ),

        // ===== Current Status Indicator (Bottom Left) =====
        Positioned(
          bottom: 16,
          left: 16,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: _buildStatusIndicator(
              congestionColor,
              isHighCongestion,
            ),
          ),
        ),

        // ===== Custom Zoom Controls (Bottom Right) =====
        Positioned(
          bottom: 16,
          right: 16,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: _buildZoomControls(),
          ),
        ),
      ],
    );
  }

  // ===== Widget Builder Methods =====

  /// Build modern traffic legend with semi-transparent background
  Widget _buildTrafficLegend() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.info_outline_rounded,
                  size: 16,
                  color: Color(0xFF1976D2),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Traffic Legend',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF1976D2),
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildLegendItem(const Color(0xFF4CAF50), 'Low', 'Smooth flow'),
          const SizedBox(height: 8),
          _buildLegendItem(const Color(0xFFFF9800), 'Moderate', 'Some delays'),
          const SizedBox(height: 8),
          _buildLegendItem(const Color(0xFFF44336), 'High', 'Heavy traffic'),
        ],
      ),
    );
  }

  /// Build individual legend item with tooltip
  Widget _buildLegendItem(Color color, String label, String tooltip) {
    final isActive = widget.congestionLevel.toLowerCase() == label.toLowerCase();

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$label traffic: $tooltip'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(16),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? color.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: isActive
              ? Border.all(color: color.withOpacity(0.3), width: 1.5)
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
                boxShadow: isActive
                    ? [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 6,
                    spreadRadius: 1,
                  ),
                ]
                    : null,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? color : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build animated status indicator with gradient background
  Widget _buildStatusIndicator(Color color, bool isHighCongestion) {
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.95),
                color.withOpacity(0.85),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: isHighCongestion
                    ? color.withOpacity(0.5 * _pulseAnimation.value)
                    : Colors.black.withOpacity(0.15),
                blurRadius: isHighCongestion ? 16 : 12,
                spreadRadius: isHighCongestion ? 2 : 0,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isHighCongestion
                      ? Icons.warning_rounded
                      : Icons.traffic_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Traffic Status',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.congestionLevel,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build custom zoom controls
  Widget _buildZoomControls() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Zoom In
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _mapController?.animateCamera(CameraUpdate.zoomIn());
              },
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.add_rounded,
                  size: 20,
                  color: Color(0xFF1976D2),
                ),
              ),
            ),
          ),

          // Divider
          Container(
            height: 1,
            width: 44,
            color: Colors.grey[300],
          ),

          // Zoom Out
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _mapController?.animateCamera(CameraUpdate.zoomOut());
              },
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Container(
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.remove_rounded,
                  size: 20,
                  color: Color(0xFF1976D2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
>>>>>>> Stashed changes
