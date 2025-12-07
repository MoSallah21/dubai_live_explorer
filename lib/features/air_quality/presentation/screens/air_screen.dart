<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
=======
>>>>>>> Stashed changes
// features/air_quality/presentation/screens/air_screen.dart

>>>>>>> Stashed changes
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/air_providers.dart';
import '../widgets/air_chart.dart';

<<<<<<< Updated upstream
class AirScreen extends ConsumerWidget {
  const AirScreen({super.key});

=======
<<<<<<< Updated upstream
class AirScreen extends ConsumerWidget {
  const AirScreen({super.key});

=======
class AirScreen extends ConsumerStatefulWidget {
  const AirScreen({super.key});

  @override
  ConsumerState<AirScreen> createState() => _AirScreenState();
}

class _AirScreenState extends ConsumerState<AirScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

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

    // Initialize slide animation for pollutants
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

    // Initialize scale animation for AQI circle
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

>>>>>>> Stashed changes
>>>>>>> Stashed changes
  String _getAirQualityCategory(int? aqi) {
    if (aqi == null) return 'Unknown';
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
<<<<<<< Updated upstream
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
=======
<<<<<<< Updated upstream
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
=======
    if (aqi <= 150) return 'Unhealthy for Sensitive';
>>>>>>> Stashed changes
>>>>>>> Stashed changes
    if (aqi <= 200) return 'Unhealthy';
    if (aqi <= 300) return 'Very Unhealthy';
    return 'Hazardous';
  }

  Color _getAirQualityColor(int? aqi) {
    if (aqi == null) return Colors.grey;
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    if (aqi <= 300) return Colors.purple;
    return Colors.brown;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final airQualityAsync = ref.watch(airQualityProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Air Quality Monitor'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(airQualityProvider);
            },
          ),
        ],
      ),
      body: airQualityAsync.when(
        data: (airData) {
          final aqiColor = _getAirQualityColor(airData.aqi);
          final aqiCategory = _getAirQualityCategory(airData.aqi);
<<<<<<< Updated upstream
=======
=======
    if (aqi <= 50) return const Color(0xFF4CAF50);
    if (aqi <= 100) return const Color(0xFFFFEB3B);
    if (aqi <= 150) return const Color(0xFFFF9800);
    if (aqi <= 200) return const Color(0xFFF44336);
    if (aqi <= 300) return const Color(0xFF9C27B0);
    return const Color(0xFF795548);
  }

  List<Color> _getAirQualityGradient(int? aqi) {
    if (aqi == null) return [Colors.grey, Colors.grey.shade700];
    if (aqi <= 50) {
      return [const Color(0xFF4CAF50), const Color(0xFF388E3C)];
    } else if (aqi <= 100) {
      return [const Color(0xFFFFEB3B), const Color(0xFFFBC02D)];
    } else if (aqi <= 150) {
      return [const Color(0xFFFF9800), const Color(0xFFF57C00)];
    } else if (aqi <= 200) {
      return [const Color(0xFFF44336), const Color(0xFFD32F2F)];
    } else if (aqi <= 300) {
      return [const Color(0xFF9C27B0), const Color(0xFF7B1FA2)];
    }
    return [const Color(0xFF795548), const Color(0xFF5D4037)];
  }

  IconData _getAirQualityIcon(int? aqi) {
    if (aqi == null) return Icons.help_outline_rounded;
    if (aqi <= 50) return Icons.sentiment_very_satisfied_rounded;
    if (aqi <= 100) return Icons.sentiment_satisfied_rounded;
    if (aqi <= 150) return Icons.sentiment_neutral_rounded;
    if (aqi <= 200) return Icons.sentiment_dissatisfied_rounded;
    if (aqi <= 300) return Icons.sentiment_very_dissatisfied_rounded;
    return Icons.warning_rounded;
  }

  String _getHealthAdvice(int? aqi) {
    if (aqi == null) return 'Air quality data unavailable';
    if (aqi <= 50) return 'Air quality is excellent. Ideal for outdoor activities!';
    if (aqi <= 100) return 'Air quality is acceptable for most people.';
    if (aqi <= 150) return 'Sensitive individuals should limit outdoor activities.';
    if (aqi <= 200) return 'Everyone should reduce prolonged outdoor exertion.';
    if (aqi <= 300) return 'Health alert! Avoid outdoor activities.';
    return 'Health warning! Stay indoors and use air purifiers.';
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final airQualityAsync = ref.watch(airQualityProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildModernAppBar(context, ref, airQualityAsync),
      body: airQualityAsync.when(
        data: (airData) {
          final aqiColor = _getAirQualityColor(airData.aqi);
          final aqiGradient = _getAirQualityGradient(airData.aqi);
          final aqiCategory = _getAirQualityCategory(airData.aqi);
          final aqiIcon = _getAirQualityIcon(airData.aqi);
          final healthAdvice = _getHealthAdvice(airData.aqi);
>>>>>>> Stashed changes
>>>>>>> Stashed changes

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(airQualityProvider);
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
                              Icon(Icons.location_on, color: Colors.blue),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  airData.locationName,
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
                            'Last updated: ${_formatTimestamp(airData.timestamp)}',
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

                  // AQI Card
                  Card(
                    elevation: 4,
                    color: aqiColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const Text(
                            'Air Quality Index',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: aqiColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              airData.aqi?.toString() ?? 'N/A',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            aqiCategory,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: aqiColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Pollutants Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pollutant Levels',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildPollutantRow(
                            'PM2.5',
                            airData.pm25,
                            airData.unit ?? 'µg/m³',
                            Icons.blur_on,
                          ),
                          const Divider(height: 24),
                          _buildPollutantRow(
                            'PM10',
                            airData.pm10,
                            airData.unit ?? 'µg/m³',
                            Icons.blur_circular,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Chart
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pollutant Chart',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          AirChart(
                            pm25: airData.pm25 ?? 0,
                            pm10: airData.pm10 ?? 0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
<<<<<<< Updated upstream
=======
=======
              _fadeController.reset();
              _slideController.reset();
              _scaleController.reset();
              await Future.delayed(const Duration(milliseconds: 100));
              _fadeController.forward();
              _slideController.forward();
              _scaleController.forward();
            },
            color: aqiColor,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    aqiGradient[0].withOpacity(0.1),
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
                        // Hero AQI Card
                        _buildHeroAQICard(
                          airData.aqi,
                          aqiCategory,
                          aqiIcon,
                          aqiColor,
                          aqiGradient,
                        ),
                        const SizedBox(height: 20),

                        // Health Advice Card
                        _buildHealthAdviceCard(healthAdvice, aqiColor),
                        const SizedBox(height: 20),

                        // Location Info
                        _buildLocationCard(
                          airData.locationName,
                          airData.timestamp,
                          aqiColor,
                        ),
                        const SizedBox(height: 24),

                        // Pollutants Section
                        _buildPollutantsSection(
                          airData.pm25,
                          airData.pm10,
                          airData.unit ?? 'µg/m³',
                          aqiColor,
                        ),
                        const SizedBox(height: 24),

                        // Chart Section
                        _buildChartSection(
                          airData.pm25 ?? 0,
                          airData.pm10 ?? 0,
                          aqiColor,
                        ),
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
              Text('Loading air quality data...'),
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
                Text(
                  'Error loading data',
                  style: const TextStyle(
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
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(airQualityProvider);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
<<<<<<< Updated upstream
=======
=======
        loading: () => _buildLoadingState(),
        error: (error, stackTrace) => _buildErrorState(error, ref),
      ),
    );
  }

  /// Modern gradient AppBar
  PreferredSizeWidget _buildModernAppBar(
      BuildContext context,
      WidgetRef ref,
      AsyncValue airAsync,
      ) {
    final hasData = airAsync.hasValue;
    final aqi = hasData ? airAsync.value!.aqi : 50;
    final gradient = _getAirQualityGradient(aqi);

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
>>>>>>> Stashed changes
>>>>>>> Stashed changes
              ],
            ),
          ),
        ),
      ),
<<<<<<< Updated upstream
    );
  }

=======
<<<<<<< Updated upstream
    );
  }

=======
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.air_rounded,
            color: Colors.white.withOpacity(0.9),
            size: 24,
          ),
          const SizedBox(width: 8),
          const Text(
            'Air Quality',
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
              ref.invalidate(airQualityProvider);
            },
            tooltip: 'Refresh',
          ),
        ),
      ],
    );
  }

  /// Hero AQI card with animated circle
  Widget _buildHeroAQICard(
      int? aqi,
      String category,
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
            // AQI Title
            const Text(
              'Air Quality Index',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 24),

            // Animated AQI Circle
            ScaleTransition(
              scale: _scaleAnimation,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow circle
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  // Main circle
                  Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          icon,
                          size: 40,
                          color: color,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          aqi?.toString() ?? 'N/A',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: color,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Category Label
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Health advice card
  Widget _buildHealthAdviceCard(String advice, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
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
              Icons.health_and_safety_rounded,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              advice,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Location card
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

  /// Pollutants section with animated cards
  Widget _buildPollutantsSection(
      double? pm25,
      double? pm10,
      String unit,
      Color accentColor,
      ) {
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
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.grain_rounded,
                    color: accentColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Pollutant Levels',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildPollutantRow(
              'PM2.5',
              pm25,
              unit,
              Icons.blur_on_rounded,
              const Color(0xFF2196F3),
            ),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[200], thickness: 1),
            const SizedBox(height: 16),
            _buildPollutantRow(
              'PM10',
              pm10,
              unit,
              Icons.blur_circular_rounded,
              const Color(0xFFFF9800),
            ),
          ],
        ),
      ),
    );
  }

  /// Individual pollutant row
>>>>>>> Stashed changes
>>>>>>> Stashed changes
  Widget _buildPollutantRow(
      String name,
      double? value,
      String unit,
      IconData icon,
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
      ) {
    return Row(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
<<<<<<< Updated upstream
=======
=======
      Color color,
      ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 28, color: color),
        ),
>>>>>>> Stashed changes
>>>>>>> Stashed changes
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
                  color: Color(0xFF2C3E50),
>>>>>>> Stashed changes
>>>>>>> Stashed changes
                ),
              ),
              const SizedBox(height: 4),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
        Text(
          value?.toStringAsFixed(1) ?? 'N/A',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
<<<<<<< Updated upstream
=======
=======
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            value?.toStringAsFixed(1) ?? 'N/A',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
>>>>>>> Stashed changes
>>>>>>> Stashed changes
          ),
        ),
      ],
    );
  }

<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }
<<<<<<< Updated upstream
}
=======
}
=======
  /// Chart section
  Widget _buildChartSection(double pm25, double pm10, Color color) {
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
                  Icons.bar_chart_rounded,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Pollutant Comparison',
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
            height: 200,
            child: AirChart(pm25: pm25, pm10: pm10),
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
            const Color(0xFF4CAF50).withOpacity(0.1),
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
                          color: const Color(0xFF4CAF50).withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF4CAF50),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text(
              'Analyzing air quality...',
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
                    Icons.air_rounded,
                    size: 64,
                    color: Color(0xFFF44336),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Unable to load air quality',
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
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(airQualityProvider);
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
>>>>>>> Stashed changes
>>>>>>> Stashed changes
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
>>>>>>> Stashed changes
