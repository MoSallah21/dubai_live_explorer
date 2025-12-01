// features/weather/presentation/widgets/weather_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/weather_entity.dart';

class WeatherChart extends StatelessWidget {
  final List<DailyForecast> dailyForecast;

  const WeatherChart({
    super.key,
    required this.dailyForecast,
  });

  @override
  Widget build(BuildContext context) {
    if (dailyForecast.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text('No forecast data available'),
        ),
      );
    }

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
      ),
    );
  }

  List<FlSpot> _getMinTempSpots() {
    return List.generate(
      dailyForecast.length,
          (index) => FlSpot(
        index.toDouble(),
        dailyForecast[index].minTemperature,
      ),
    );
  }

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