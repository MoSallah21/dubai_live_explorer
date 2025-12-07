// features/weather/presentation/widgets/weather_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/weather_entity.dart';

<<<<<<< Updated upstream
class WeatherChart extends StatelessWidget {
=======
<<<<<<< Updated upstream
class WeatherChart extends StatelessWidget {
=======
class WeatherChart extends StatefulWidget {
>>>>>>> Stashed changes
>>>>>>> Stashed changes
  final List<DailyForecast> dailyForecast;

  const WeatherChart({
    super.key,
    required this.dailyForecast,
  });

  @override
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
  Widget build(BuildContext context) {
    if (dailyForecast.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text('No forecast data available'),
<<<<<<< Updated upstream
=======
=======
  State<WeatherChart> createState() => _WeatherChartState();
}

class _WeatherChartState extends State<WeatherChart> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize animation controller for smooth line drawing effect
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ===== Handle Empty Data State =====
    if (widget.dailyForecast.isEmpty) {
      return SizedBox(
        height: 280,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 12),
              Text(
                'No forecast data available',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
>>>>>>> Stashed changes
>>>>>>> Stashed changes
        ),
      );
    }

<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < dailyForecast.length) {
                    final date = dailyForecast[value.toInt()].date;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _getDayLabel(date, value.toInt()),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '${value.toInt()}°C',
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(color: Colors.grey.withOpacity(0.5)),
              left: BorderSide(color: Colors.grey.withOpacity(0.5)),
            ),
          ),
          minX: 0,
          maxX: (dailyForecast.length - 1).toDouble(),
          minY: _getMinTemp() - 5,
          maxY: _getMaxTemp() + 5,
          lineBarsData: [
            // Max temperature line
            LineChartBarData(
              spots: _getMaxTempSpots(),
              isCurved: true,
              color: Colors.red,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.red,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.red.withOpacity(0.1),
              ),
            ),
            // Min temperature line
            LineChartBarData(
              spots: _getMinTempSpots(),
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: Colors.blue,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blue.withOpacity(0.1),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final isMaxTemp = spot.barIndex == 0;
                  final label = isMaxTemp ? 'Max' : 'Min';
                  return LineTooltipItem(
                    '$label: ${spot.y.toStringAsFixed(1)}°C',
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  List<FlSpot> _getMaxTempSpots() {
    return List.generate(
      dailyForecast.length,
          (index) => FlSpot(
        index.toDouble(),
        dailyForecast[index].maxTemperature,
<<<<<<< Updated upstream
=======
=======
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: 280,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: LineChart(
            LineChartData(
              // ===== Grid Configuration =====
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 5,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.withOpacity(0.15 * _animation.value),
                    strokeWidth: 1,
                    dashArray: [5, 5], // Dotted line pattern
                  );
                },
              ),

              // ===== Axes Configuration =====
              titlesData: FlTitlesData(
                show: true,

                // Bottom axis: Day labels
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 35,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      if (value.toInt() >= 0 && value.toInt() < widget.dailyForecast.length) {
                        final date = widget.dailyForecast[value.toInt()].date;
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            _getDayLabel(date, value.toInt()),
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                              letterSpacing: 0.3,
                            ),
                          ),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),

                // Left axis: Temperature labels
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 45,
                    interval: 5,
                    getTitlesWidget: (value, meta) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          '${value.toInt()}°C',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Hide top and right axes
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),

              // ===== Border Configuration =====
              borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1.5,
                  ),
                  left: BorderSide(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
              ),

              // ===== Chart Boundaries =====
              minX: 0,
              maxX: (widget.dailyForecast.length - 1).toDouble(),
              minY: _getMinTemp() - 5,
              maxY: _getMaxTemp() + 5,

              // ===== Line Data with Gradients and Animation =====
              lineBarsData: [
                // Max Temperature Line (Red/Orange)
                LineChartBarData(
                  spots: _getAnimatedSpots(_getMaxTempSpots()),
                  isCurved: true,
                  curveSmoothness: 0.4,
                  preventCurveOverShooting: true,

                  // Gradient from orange to red
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF6B6B), // Light red
                      Color(0xFFEE5A6F), // Medium red
                      Color(0xFFC93D3D), // Dark red
                    ],
                  ),

                  barWidth: 4,
                  isStrokeCapRound: true,

                  // Animated dots with glow effect
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 5 * _animation.value,
                        color: const Color(0xFFFF6B6B),
                        strokeWidth: 2.5,
                        strokeColor: Colors.white,
                      );
                    },
                  ),

                  // Gradient fill under the line
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFF6B6B).withOpacity(0.3 * _animation.value),
                        const Color(0xFFFF6B6B).withOpacity(0.05 * _animation.value),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),

                  // Subtle shadow/glow effect
                  shadow: Shadow(
                    color: const Color(0xFFFF6B6B).withOpacity(0.4),
                    blurRadius: 8,
                  ),
                ),

                // Min Temperature Line (Blue)
                LineChartBarData(
                  spots: _getAnimatedSpots(_getMinTempSpots()),
                  isCurved: true,
                  curveSmoothness: 0.4,
                  preventCurveOverShooting: true,

                  // Gradient from light to dark blue
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4FC3F7), // Light blue
                      Color(0xFF29B6F6), // Medium blue
                      Color(0xFF0288D1), // Dark blue
                    ],
                  ),

                  barWidth: 4,
                  isStrokeCapRound: true,

                  // Animated dots with glow effect
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      return FlDotCirclePainter(
                        radius: 5 * _animation.value,
                        color: const Color(0xFF29B6F6),
                        strokeWidth: 2.5,
                        strokeColor: Colors.white,
                      );
                    },
                  ),

                  // Gradient fill under the line
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF29B6F6).withOpacity(0.3 * _animation.value),
                        const Color(0xFF29B6F6).withOpacity(0.05 * _animation.value),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),

                  // Subtle shadow/glow effect
                  shadow: Shadow(
                    color: const Color(0xFF29B6F6).withOpacity(0.4),
                    blurRadius: 8,
                  ),
                ),
              ],

              // ===== Interactive Tooltips =====
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  tooltipMargin: 10,

                  // Custom tooltip content
                  getTooltipItems: (touchedSpots) {
                    return touchedSpots.map((spot) {
                      final isMaxTemp = spot.barIndex == 0;
                      final label = isMaxTemp ? 'Max' : 'Min';
                      final icon = isMaxTemp ? '🔴' : '🔵';

                      return LineTooltipItem(
                        '$icon $label\n${spot.y.toStringAsFixed(1)}°C',
                        TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      );
                    }).toList();
                  },
                ),

                // Touch response configuration
                handleBuiltInTouches: true,
                getTouchLineStart: (data, index) => 0,
                getTouchLineEnd: (data, index) => 0,
              ),
            ),
          ),
        );
      },
    );
  }

  // ===== Helper Methods =====

  /// Get max temperature data points
  List<FlSpot> _getMaxTempSpots() {
    return List.generate(
      widget.dailyForecast.length,
          (index) => FlSpot(
        index.toDouble(),
        widget.dailyForecast[index].maxTemperature,
>>>>>>> Stashed changes
>>>>>>> Stashed changes
      ),
    );
  }

<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
  List<FlSpot> _getMinTempSpots() {
    return List.generate(
      dailyForecast.length,
          (index) => FlSpot(
        index.toDouble(),
        dailyForecast[index].minTemperature,
<<<<<<< Updated upstream
=======
=======
  /// Get min temperature data points
  List<FlSpot> _getMinTempSpots() {
    return List.generate(
      widget.dailyForecast.length,
          (index) => FlSpot(
        index.toDouble(),
        widget.dailyForecast[index].minTemperature,
>>>>>>> Stashed changes
>>>>>>> Stashed changes
      ),
    );
  }

<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
  double _getMaxTemp() {
    return dailyForecast.map((d) => d.maxTemperature).reduce(
          (a, b) => a > b ? a : b,
    );
  }

  double _getMinTemp() {
    return dailyForecast.map((d) => d.minTemperature).reduce(
          (a, b) => a < b ? a : b,
    );
  }

<<<<<<< Updated upstream
=======
=======
  /// Animate data points for drawing effect
  List<FlSpot> _getAnimatedSpots(List<FlSpot> spots) {
    if (_animation.value == 1.0) return spots;

    final animatedLength = (spots.length * _animation.value).ceil();
    final animatedSpots = spots.take(animatedLength).toList();

    // Smooth interpolation for the last point
    if (animatedSpots.length < spots.length && animatedSpots.isNotEmpty) {
      final nextSpot = spots[animatedSpots.length];
      final lastSpot = animatedSpots.last;
      final progress = (spots.length * _animation.value) - (animatedLength - 1);

      animatedSpots[animatedSpots.length - 1] = FlSpot(
        lastSpot.x + (nextSpot.x - lastSpot.x) * progress,
        lastSpot.y + (nextSpot.y - lastSpot.y) * progress,
      );
    }

    return animatedSpots;
  }

  /// Calculate maximum temperature across all days
  double _getMaxTemp() {
    return widget.dailyForecast
        .map((d) => d.maxTemperature)
        .reduce((a, b) => a > b ? a : b);
  }

  /// Calculate minimum temperature across all days
  double _getMinTemp() {
    return widget.dailyForecast
        .map((d) => d.minTemperature)
        .reduce((a, b) => a < b ? a : b);
  }

  /// Get formatted day label for X-axis
>>>>>>> Stashed changes
>>>>>>> Stashed changes
  String _getDayLabel(DateTime date, int index) {
    if (index == 0) {
      return 'Today';
    } else if (index == 1) {
      return 'Tmrw';
    }

    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}