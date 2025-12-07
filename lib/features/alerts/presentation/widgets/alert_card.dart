// features/alerts/presentation/widgets/alert_card.dart

import 'package:flutter/material.dart';
import '../../domain/entities/alert_entity.dart';
import 'threshold_indicator.dart';

class AlertCard extends StatefulWidget {
  final AlertEntity alert;

  const AlertCard({
    super.key,
    required this.alert,
  });

  @override
  State<AlertCard> createState() => _AlertCardState();
}

class _AlertCardState extends State<AlertCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _isExpanded = false;
  static const int _messagePreviewLength = 120;

  @override
  void initState() {
    super.initState();
    // Initialize pulse animation for high severity alerts
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    if (widget.alert.severity.toLowerCase() == 'high') {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Returns the primary color based on alert severity
  Color _getSeverityColor() {
    switch (widget.alert.severity.toLowerCase()) {
      case 'high':
        return const Color(0xFFE53E3E); // Modern red
      case 'medium':
        return const Color(0xFFED8936); // Warm orange
      case 'low':
        return const Color(0xFF48BB78); // Cool green
      default:
        return const Color(0xFF718096); // Neutral grey
    }
  }

  /// Returns gradient colors for card background based on severity
  List<Color> _getSeverityGradient() {
    final baseColor = _getSeverityColor();
    switch (widget.alert.severity.toLowerCase()) {
      case 'high':
        return [
          baseColor.withOpacity(0.08),
          const Color(0xFFFFF5F5),
          Colors.white,
        ];
      case 'medium':
        return [
          baseColor.withOpacity(0.06),
          const Color(0xFFFFFAF0),
          Colors.white,
        ];
      case 'low':
        return [
          baseColor.withOpacity(0.06),
          const Color(0xFFF0FFF4),
          Colors.white,
        ];
      default:
        return [
          Colors.grey.withOpacity(0.03),
          Colors.white,
        ];
    }
  }

  /// Returns the appropriate icon based on alert source
  IconData _getSourceIcon() {
    switch (widget.alert.source.toLowerCase()) {
      case 'air':
        return Icons.air;
      case 'weather':
        return Icons.wb_sunny;
      case 'traffic':
        return Icons.traffic;
      default:
        return Icons.notifications;
    }
  }

  /// Formats timestamp into human-readable relative time
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 30) {
      return 'Just now';
    } else if (difference.inMinutes < 1) {
      return 'A moment ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  /// Returns the full formatted timestamp for tooltip
  String _getFullTimestamp(DateTime timestamp) {
    return '${timestamp.day}/${timestamp.month}/${timestamp.year} at ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }

  /// Checks if message should show "Show more" button
  bool _shouldTruncateMessage() {
    return widget.alert.message.length > _messagePreviewLength;
  }

  /// Returns the display message (truncated or full)
  String _getDisplayMessage() {
    if (!_isExpanded && _shouldTruncateMessage()) {
      return '${widget.alert.message.substring(0, _messagePreviewLength)}...';
    }
    return widget.alert.message;
  }

  // ============================================================================
  // BUILD METHODS
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    final severityColor = _getSeverityColor();

    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: _buildCardContent(severityColor),
    );
  }

  /// Builds the main card content with all styling
  Widget _buildCardContent(Color severityColor) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final pulseValue = _pulseController.value;
        final glowOpacity = widget.alert.severity.toLowerCase() == 'high'
            ? 0.15 + (pulseValue * 0.15)
            : 0.2;

        return Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: severityColor.withOpacity(glowOpacity),
                blurRadius: 12 + (pulseValue * 4),
                spreadRadius: 0,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Card(
            elevation: 0,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(
                color: severityColor.withOpacity(0.25),
                width: 1.5,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: _getSeverityGradient(),
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Stack(
                  children: [
                    // Subtle glass effect overlay
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.4),
                              Colors.white.withOpacity(0.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Main content
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(severityColor),
                          const SizedBox(height: 14),
                          _buildMessageSection(),
                          const SizedBox(height: 14),
                          _buildDivider(),
                          const SizedBox(height: 12),
                          _buildFooter(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Builds the header row with icon, title, source, and severity indicator
  Widget _buildHeader(Color severityColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Source icon with modern neumorphic-style container
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: severityColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: severityColor.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.8),
                blurRadius: 8,
                offset: const Offset(-2, -2),
              ),
            ],
          ),
          child: Icon(
            _getSourceIcon(),
            color: severityColor,
            size: 26,
          ),
        ),
        const SizedBox(width: 14),
        // Title and source badge
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.alert.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 6),
              // Source badge with chip-style design
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: severityColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: severityColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  widget.alert.source.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: severityColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Severity indicator
        ThresholdIndicator(
          severity: widget.alert.severity,
          showLabel: true,
        ),
      ],
    );
  }

  /// Builds the message section with optional expand/collapse
  Widget _buildMessageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: Text(
            _getDisplayMessage(),
            style: TextStyle(
              fontSize: 14.5,
              color: Colors.grey[800],
              height: 1.6,
              letterSpacing: 0.1,
            ),
          ),
          secondChild: Text(
            _getDisplayMessage(),
            style: TextStyle(
              fontSize: 14.5,
              color: Colors.grey[800],
              height: 1.6,
              letterSpacing: 0.1,
            ),
          ),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        if (_shouldTruncateMessage()) ...[
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(6.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 2.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? 'Show less' : 'Show more',
                    style: TextStyle(
                      fontSize: 13,
                      color: _getSeverityColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 16,
                    color: _getSeverityColor(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Builds a subtle divider
  Widget _buildDivider() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.grey.withOpacity(0.2),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  /// Builds the footer with timestamp
  Widget _buildFooter() {
    return Tooltip(
      message: _getFullTimestamp(widget.alert.timestamp),
      child: Row(
        children: [
          Icon(
            Icons.schedule_rounded,
            size: 15,
            color: Colors.grey[500],
          ),
          const SizedBox(width: 6),
          Text(
            _formatTimestamp(widget.alert.timestamp),
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}