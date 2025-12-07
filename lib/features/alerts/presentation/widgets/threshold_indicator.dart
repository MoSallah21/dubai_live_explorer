// features/alerts/presentation/widgets/threshold_indicator.dart

import 'package:flutter/material.dart';

class ThresholdIndicator extends StatelessWidget {
  final String severity;
  final bool showLabel;

  const ThresholdIndicator({
    super.key,
    required this.severity,
    this.showLabel = false,
  });

  // ============================================================================
  // HELPER METHODS - Color & Styling
  // ============================================================================

  /// Returns the primary color for the severity level
  Color _getSeverityColor() {
    switch (severity.toLowerCase()) {
      case 'high':
        return const Color(0xFFE53E3E); // Modern red
      case 'medium':
        return const Color(0xFFED8936); // Warm orange
      case 'low':
        return const Color(0xFF48BB78); // Fresh green
      default:
        return const Color(0xFF718096); // Neutral grey
    }
  }

  /// Returns a secondary/darker shade for gradient effects
  Color _getSeverityDarkColor() {
    switch (severity.toLowerCase()) {
      case 'high':
        return const Color(0xFFC53030); // Darker red
      case 'medium':
        return const Color(0xFFDD6B20); // Darker orange
      case 'low':
        return const Color(0xFF38A169); // Darker green
      default:
        return const Color(0xFF4A5568); // Dark grey
    }
  }

  /// Returns gradient colors for the severity background
  List<Color> _getSeverityGradient() {
    final baseColor = _getSeverityColor();
    final darkColor = _getSeverityDarkColor();

    return [
      darkColor,
      baseColor,
    ];
  }

  /// Returns the display label text
  String _getSeverityLabel() {
    switch (severity.toLowerCase()) {
      case 'high':
        return 'High';
      case 'medium':
        return 'Medium';
      case 'low':
        return 'Low';
      default:
        return 'Unknown';
    }
  }

  /// Returns animation duration based on severity (for pulse effect)
  Duration _getPulseDuration() {
    switch (severity.toLowerCase()) {
      case 'high':
        return const Duration(milliseconds: 1200); // Faster pulse
      case 'medium':
        return const Duration(milliseconds: 1800); // Medium pulse
      case 'low':
        return const Duration(milliseconds: 2500); // Slower pulse
      default:
        return const Duration(milliseconds: 2000);
    }
  }

  /// Returns pulse intensity multiplier
  double _getPulseIntensity() {
    switch (severity.toLowerCase()) {
      case 'high':
        return 1.5; // Strong pulse
      case 'medium':
        return 1.2; // Medium pulse
      case 'low':
        return 1.0; // Gentle pulse
      default:
        return 0.8;
    }
  }

  // ============================================================================
  // BUILD METHODS
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _getSeverityLabel(),
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack,
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: 0.3 + (value * 0.7),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: showLabel ? _buildLabelMode() : _buildDotMode(),
      ),
    );
  }

  /// Builds the label mode (pill-style capsule with text)
  Widget _buildLabelMode() {
    final color = _getSeverityColor();
    final gradient = _getSeverityGradient();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradient[0].withOpacity(0.15),
            gradient[1].withOpacity(0.12),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: color.withOpacity(0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.6),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Glowing dot indicator
          _buildGlowingDot(size: 9.0, showPulse: false),
          const SizedBox(width: 8),
          // Label text
          Text(
            _getSeverityLabel(),
            style: TextStyle(
              color: gradient[0],
              fontWeight: FontWeight.w700,
              fontSize: 12.5,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the dot mode (animated pulsing indicator)
  Widget _buildDotMode() {
    return TweenAnimationBuilder<double>(
      duration: _getPulseDuration(),
      curve: Curves.easeInOut,
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        // Create a smooth pulse effect using sine wave
        final pulseValue = (value * 2 * 3.14159);
        final pulse = (1 + (0.3 * _getPulseIntensity() *
            (0.5 + 0.5 * (pulseValue % (2 * 3.14159) / (2 * 3.14159)))));

        return _buildGlowingDot(
          size: 14.0,
          showPulse: true,
          pulseScale: pulse,
        );
      },
      onEnd: () {
        // This creates a continuous loop by rebuilding when animation completes
        // In production, consider using AnimationController for better control
      },
    );
  }

  /// Builds a glowing dot with optional pulse effect
  Widget _buildGlowingDot({
    required double size,
    required bool showPulse,
    double pulseScale = 1.0,
  }) {
    final color = _getSeverityColor();
    final gradient = _getSeverityGradient();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.white.withOpacity(0.9),
            gradient[1],
            gradient[0],
          ],
          stops: const [0.0, 0.4, 1.0],
        ),
        boxShadow: [
          // Inner glow
          BoxShadow(
            color: Colors.white.withOpacity(0.8),
            blurRadius: 2,
            spreadRadius: -1,
          ),
          // Main glow
          BoxShadow(
            color: color.withOpacity(0.6 * (showPulse ? pulseScale : 1.0)),
            blurRadius: showPulse ? 8 * pulseScale : 6,
            spreadRadius: showPulse ? 2 * pulseScale : 1.5,
          ),
          // Outer glow
          BoxShadow(
            color: color.withOpacity(0.3 * (showPulse ? pulseScale : 1.0)),
            blurRadius: showPulse ? 12 * pulseScale : 8,
            spreadRadius: showPulse ? 3 * pulseScale : 2,
          ),
        ],
      ),
    );
  }
}