<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
>>>>>>> Stashed changes
// features/weather/presentation/screens/weather_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
import '../providers/weather_providers.dart';
import '../widgets/weather_chart.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

<<<<<<< Updated upstream
=======
=======
import '../../../../app.dart';
import '../../domain/entities/weather_entity.dart';
import '../providers/weather_providers.dart';
import '../widgets/weather_chart.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize fade animation for cards
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Initialize slide animation for list items
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

>>>>>>> Stashed changes
>>>>>>> Stashed changes
  String _getWeatherCondition(double temperature) {
    if (temperature < 10) return 'Cold';
    if (temperature < 20) return 'Cool';
    if (temperature < 30) return 'Warm';
    return 'Hot';
  }

  IconData _getWeatherIcon(double temperature) {
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
    if (temperature < 10) return Icons.ac_unit;
    if (temperature < 20) return Icons.cloud;
    if (temperature < 30) return Icons.wb_sunny;
    return Icons.wb_sunny;
  }

  Color _getTemperatureColor(double temperature) {
    if (temperature < 10) return Colors.blue;
    if (temperature < 20) return Colors.lightBlue;
    if (temperature < 30) return Colors.orange;
    return Colors.red;
<<<<<<< Updated upstream
=======
=======
    if (temperature < 10) return Icons.ac_unit_rounded;
    if (temperature < 20) return Icons.cloud_rounded;
    if (temperature < 30) return Icons.wb_sunny_rounded;
    return Icons.wb_sunny_rounded;
  }

  Color _getTemperatureColor(double temperature) {
    if (temperature < 10) return const Color(0xFF2196F3);
    if (temperature < 20) return const Color(0xFF03A9F4);
    if (temperature < 30) return const Color(0xFFFF9800);
    return const Color(0xFFF44336);
  }

  List<Color> _getTemperatureGradient(double temperature) {
    if (temperature < 10) {
      return [const Color(0xFF2196F3), const Color(0xFF1976D2)];
    } else if (temperature < 20) {
      return [const Color(0xFF03A9F4), const Color(0xFF0288D1)];
    } else if (temperature < 30) {
      return [const Color(0xFFFF9800), const Color(0xFFF57C00)];
    }
    return [const Color(0xFFF44336), const Color(0xFFD32F2F)];
>>>>>>> Stashed changes
>>>>>>> Stashed changes
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(weatherProvider);
            },
          ),
        ],
      ),
      body: weatherAsync.when(
        data: (weatherData) {
          final tempColor = _getTemperatureColor(weatherData.currentTemperature);
<<<<<<< Updated upstream
=======
=======
  Widget build(BuildContext context) {
    final weatherAsync = ref.watch(weatherProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassmorphicAppBar(
        title: 'Weather',
        icon: Icons.wb_sunny_rounded,
        gradient: [Color(0xFF2196F3), Color(0xFF1976D2)],
        onRefresh: () => ref.invalidate(weatherProvider),
      ),      body: weatherAsync.when(
        data: (weatherData) {
          final tempColor = _getTemperatureColor(weatherData.currentTemperature);
          final tempGradient = _getTemperatureGradient(weatherData.currentTemperature);
>>>>>>> Stashed changes
>>>>>>> Stashed changes
          final weatherIcon = _getWeatherIcon(weatherData.currentTemperature);
          final weatherCondition = _getWeatherCondition(weatherData.currentTemperature);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(weatherProvider);
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Location Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  weatherData.locationName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Updated: ${_formatTimestamp(weatherData.timestamp)}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Current Temperature Card
                  Card(
                    elevation: 4,
                    color: tempColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Icon(
                            weatherIcon,
                            size: 80,
                            color: tempColor,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                weatherData.currentTemperature.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 64,
                                  fontWeight: FontWeight.bold,
                                  color: tempColor,
                                ),
                              ),
                              Text(
                                '°C',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  color: tempColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            weatherCondition,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: tempColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Weather Details Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Weather Details',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _buildDetailItem(
                                  icon: Icons.water_drop,
                                  label: 'Humidity',
                                  value: '${weatherData.humidity.toStringAsFixed(0)}%',
                                  color: Colors.blue,
                                ),
                              ),
                              Expanded(
                                child: _buildDetailItem(
                                  icon: Icons.air,
                                  label: 'Wind Speed',
                                  value: '${weatherData.windSpeed.toStringAsFixed(1)} km/h',
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 7-Day Forecast Card
                  if (weatherData.dailyForecast.isNotEmpty) ...[
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '7-Day Forecast',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            WeatherChart(
                              dailyForecast: weatherData.dailyForecast,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Daily Forecast List
                  if (weatherData.dailyForecast.isNotEmpty) ...[
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Daily Forecast',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ...weatherData.dailyForecast.map((day) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: _buildDayForecast(day),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
<<<<<<< Updated upstream
=======
=======
              _fadeController.reset();
              _slideController.reset();
              await Future.delayed(const Duration(milliseconds: 100));
              _fadeController.forward();
              _slideController.forward();
            },
            color: tempColor,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    tempGradient[0].withOpacity(0.1),
                    Colors.white,
                  ],
                  stops: const [0.0, 0.4],
                ),
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero temperature card
                        _buildHeroTemperatureCard(
                          weatherData.currentTemperature,
                          weatherCondition,
                          weatherIcon,
                          tempColor,
                          tempGradient,
                        ),
                        const SizedBox(height: 20),

                        // Location info
                        _buildLocationCard(weatherData.locationName,
                            weatherData.timestamp, tempColor),
                        const SizedBox(height: 20),

                        // Weather details grid
                        _buildWeatherDetailsGrid(
                          weatherData.humidity,
                          weatherData.windSpeed,
                          tempColor,
                        ),
                        const SizedBox(height: 24),

                        // 7-Day forecast chart
                        if (weatherData.dailyForecast.isNotEmpty) ...[
                          _buildForecastChartCard(
                            weatherData.dailyForecast,
                            tempColor,
                          ),
                          const SizedBox(height: 24),
                        ],

                        // Daily forecast list
                        if (weatherData.dailyForecast.isNotEmpty) ...[
                          _buildDailyForecastSection(
                            weatherData.dailyForecast,
                            tempColor,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
>>>>>>> Stashed changes
>>>>>>> Stashed changes
              ),
            ),
          );
        },
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Loading weather data...'),
            ],
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Error loading weather data',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 24),
<<<<<<< Updated upstream
=======
=======
        loading: () => _buildLoadingState(),
        error: (error, stackTrace) => _buildErrorState(error, ref),
      ),
    );
  }

  /// Modern gradient AppBar with glass effect
  PreferredSizeWidget _buildModernAppBar(
      BuildContext context,
      WidgetRef ref,
      AsyncValue weatherAsync,
      ) {
    final hasData = weatherAsync.hasValue;
    final temp = hasData ? weatherAsync.value!.currentTemperature : 25.0;
    final gradient = _getTemperatureGradient(temp);

    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.1),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wb_sunny_rounded,
            color: Colors.white.withOpacity(0.9),
            size: 24,
          ),
          const SizedBox(width: 8),
          const Text(
            'Weather',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: () {
              ref.invalidate(weatherProvider);
            },
            tooltip: 'Refresh',
          ),
        ),
      ],
    );
  }

  /// Hero temperature card with gradient background
  Widget _buildHeroTemperatureCard(
      double temperature,
      String condition,
      IconData icon,
      Color color,
      List<Color> gradient,
      ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.transparent,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        child: Column(
          children: [
            // Animated weather icon
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Icon(
                    icon,
                    size: 100,
                    color: Colors.white.withOpacity(0.9),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Temperature display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  temperature.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    '°C',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Weather condition
            Text(
              condition,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Location card with glass effect
  Widget _buildLocationCard(String location, DateTime timestamp, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.location_on_rounded,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatTimestamp(timestamp),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Weather details grid with icons
  Widget _buildWeatherDetailsGrid(
      double humidity,
      double windSpeed,
      Color color,
      ) {
    return Row(
      children: [
        Expanded(
          child: _buildDetailCard(
            icon: Icons.water_drop_rounded,
            label: 'Humidity',
            value: '${humidity.toStringAsFixed(0)}%',
            color: const Color(0xFF2196F3),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDetailCard(
            icon: Icons.air_rounded,
            label: 'Wind Speed',
            value: '${windSpeed.toStringAsFixed(1)} km/h',
            color: const Color(0xFF4CAF50),
          ),
        ),
      ],
    );
  }

  /// Individual detail card
  Widget _buildDetailCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }

  /// 7-day forecast chart card
  Widget _buildForecastChartCard(List<DailyForecast> dailyForecast, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.show_chart_rounded,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                '7-Day Forecast',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: WeatherChart(dailyForecast: dailyForecast),
          ),
        ],
      ),
    );
  }

  /// Daily forecast section with animated list
  Widget _buildDailyForecastSection(List dailyForecast, Color color) {
    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.calendar_today_rounded,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Daily Forecast',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...dailyForecast.asMap().entries.map((entry) {
              final index = entry.key;
              final day = entry.value;
              return TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(milliseconds: 400 + (index * 100)),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildDayForecast(day, color),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// Individual day forecast item
  Widget _buildDayForecast(dynamic day, Color accentColor) {
    final date = day.date as DateTime;
    final maxTemp = day.maxTemperature as double;
    final minTemp = day.minTemperature as double;
    final dayName = _getDayName(date);
    final dateStr = '${date.day}/${date.month}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Day info
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dateStr,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Temperature range with icon
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.thermostat_rounded,
                  size: 18,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 6),
                Text(
                  '${maxTemp.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                Text(
                  ' / ',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  '${minTemp.toStringAsFixed(0)}°',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Loading state with animated indicator
  Widget _buildLoadingState() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF2196F3).withOpacity(0.1),
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: 0.8 + (value * 0.2),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2196F3).withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Loading weather data...',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please wait a moment',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Error state with retry button
  Widget _buildErrorState(Object error, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFF44336).withOpacity(0.1),
            Colors.white,
          ],
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF44336).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.cloud_off_rounded,
                    size: 64,
                    color: Color(0xFFF44336),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Unable to load weather',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 28),
>>>>>>> Stashed changes
>>>>>>> Stashed changes
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(weatherProvider);
                  },
<<<<<<< Updated upstream
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
=======
<<<<<<< Updated upstream
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
=======
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
>>>>>>> Stashed changes
>>>>>>> Stashed changes
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 40, color: color),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDayForecast(dynamic day) {
    final date = day.date as DateTime;
    final maxTemp = day.maxTemperature as double;
    final minTemp = day.minTemperature as double;

    final dayName = _getDayName(date);
    final dateStr = '${date.day}/${date.month}';

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dayName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                dateStr,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${maxTemp.toStringAsFixed(0)}°',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${minTemp.toStringAsFixed(0)}°',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

<<<<<<< Updated upstream
=======
=======
>>>>>>> Stashed changes
>>>>>>> Stashed changes
  String _getDayName(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final compareDate = DateTime(date.year, date.month, date.day);

    if (compareDate == today) {
      return 'Today';
    } else if (compareDate == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    }

<<<<<<< Updated upstream
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}
=======
<<<<<<< Updated upstream
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}
=======
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[date.weekday - 1];
  }
}
>>>>>>> Stashed changes
>>>>>>> Stashed changes
>>>>>>> Stashed changes
>>>>>>> Stashed changes
