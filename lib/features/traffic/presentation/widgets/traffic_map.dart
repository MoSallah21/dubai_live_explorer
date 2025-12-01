// features/traffic/presentation/widgets/traffic_map.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class _TrafficMapState extends State<TrafficMap> {
  GoogleMapController? _mapController;
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _setupMapElements();
  }

  @override
  void didUpdateWidget(TrafficMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.coordinates != widget.coordinates ||
        oldWidget.congestionLevel != widget.congestionLevel) {
      _setupMapElements();
    }
  }

  void _setupMapElements() {
    if (widget.coordinates.isEmpty) return;

    // Create polyline based on coordinates
    final polyline = Polyline(
      polylineId: const PolylineId('traffic_route'),
      points: widget.coordinates,
      color: _getPolylineColor(),
      width: 6,
      patterns: widget.congestionLevel.toLowerCase() == 'high'
          ? [PatternItem.dash(20), PatternItem.gap(10)]
          : [],
    );

    // Create markers for start and end points
    final startMarker = Marker(
      markerId: const MarkerId('start'),
      position: widget.coordinates.first,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow: const InfoWindow(
        title: 'Start',
        snippet: 'Route starting point',
      ),
    );

    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: widget.coordinates.last,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: const InfoWindow(
        title: 'End',
        snippet: 'Route ending point',
      ),
    );

    setState(() {
      _polylines = {polyline};
      _markers = {startMarker, endMarker};
    });
  }

  Color _getPolylineColor() {
    switch (widget.congestionLevel.toLowerCase()) {
      case 'low':
        return Colors.green;
      case 'moderate':
        return Colors.orange;
      case 'high':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  LatLng _getCenterPosition() {
    if (widget.coordinates.isEmpty) {
      return const LatLng(25.2048, 55.2708); // Default Dubai coordinates
    }

    // Calculate center of all coordinates
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

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    // Fit bounds to show all coordinates
    if (widget.coordinates.length > 1) {
      _fitBounds();
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

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _getCenterPosition(),
            zoom: 13.0,
          ),
          polylines: _polylines,
          markers: _markers,
          trafficEnabled: true, // Enable traffic layer
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          zoomControlsEnabled: true,
          mapToolbarEnabled: true,
          mapType: MapType.normal,
        ),

        // Traffic Legend Overlay
        Positioned(
          top: 16,
          right: 16,
          child: Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Traffic Legend',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildLegendItem(Colors.green, 'Low'),
                  const SizedBox(height: 4),
                  _buildLegendItem(Colors.orange, 'Moderate'),
                  const SizedBox(height: 4),
                  _buildLegendItem(Colors.red, 'High'),
                ],
              ),
            ),
          ),
        ),

        // Current Status Indicator
        Positioned(
          bottom: 16,
          left: 16,
          child: Card(
            elevation: 4,
            color: _getPolylineColor().withOpacity(0.9),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.traffic,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${widget.congestionLevel} Traffic',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 11),
        ),
      ],
    );
  }
}