<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
>>>>>>> Stashed changes
// features/insights/presentation/screens/insights_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/insights_provider.dart';
import '../widgets/insights_card.dart';

<<<<<<< Updated upstream
class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.lightGreen;
    if (score >= 40) return Colors.orange;
    if (score >= 20) return Colors.deepOrange;
    return Colors.red;
=======
class InsightsScreen extends ConsumerStatefulWidget {
  const InsightsScreen({super.key});

  @override
  ConsumerState<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends ConsumerState<InsightsScreen>
    with TickerProviderStateMixin {
  late AnimationController _scoreController;
  late AnimationController _cardsController;
  late Animation<double> _scoreAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation for circular progress indicator
    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scoreAnimation = CurvedAnimation(
      parent: _scoreController,
      curve: Curves.easeOutCubic,
    );

    // Animation for cards fade-in
    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _cardsController,
      curve: Curves.easeIn,
    );

    _scoreController.forward();
    _cardsController.forward();
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _cardsController.dispose();
    super.dispose();
  }

  // ===== Helper Methods =====

  Color _getScoreColor(int score) {
    if (score >= 80) return const Color(0xFF4CAF50); // Green
    if (score >= 60) return const Color(0xFF8BC34A); // Light green
    if (score >= 40) return const Color(0xFFFF9800); // Orange
    if (score >= 20) return const Color(0xFFFF5722); // Deep orange
    return const Color(0xFFF44336); // Red
  }

  List<Color> _getScoreGradient(int score) {
    if (score >= 80) {
      return [const Color(0xFF66BB6A), const Color(0xFF4CAF50)];
    }
    if (score >= 60) {
      return [const Color(0xFF9CCC65), const Color(0xFF8BC34A)];
    }
    if (score >= 40) {
      return [const Color(0xFFFFB74D), const Color(0xFFFF9800)];
    }
    if (score >= 20) {
      return [const Color(0xFFFF7043), const Color(0xFFFF5722)];
    }
    return [const Color(0xFFEF5350), const Color(0xFFF44336)];
>>>>>>> Stashed changes
  }

  String _getScoreLabel(int score) {
    if (score >= 80) return 'Excellent';
    if (score >= 60) return 'Good';
    if (score >= 40) return 'Moderate';
    if (score >= 20) return 'Poor';
    return 'Very Poor';
  }

<<<<<<< Updated upstream
=======
  IconData _getScoreIcon(int score) {
    if (score >= 80) return Icons.sentiment_very_satisfied_rounded;
    if (score >= 60) return Icons.sentiment_satisfied_rounded;
    if (score >= 40) return Icons.sentiment_neutral_rounded;
    if (score >= 20) return Icons.sentiment_dissatisfied_rounded;
    return Icons.sentiment_very_dissatisfied_rounded;
  }

>>>>>>> Stashed changes
  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inSeconds < 30) {
      return 'Just now';
    } else if (difference.inMinutes < 1) {
      return 'A moment ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else {
      return '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }

<<<<<<< Updated upstream
  @override
  Widget build(BuildContext context, WidgetRef ref) {
=======
  void _showInfoDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF9C27B0).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.info_outline_rounded,
                color: Color(0xFF9C27B0),
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Got it',
              style: TextStyle(
                color: Color(0xFF9C27B0),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
>>>>>>> Stashed changes
    final insightsAsync = ref.watch(insightsProvider);

    return Scaffold(
      appBar: AppBar(
<<<<<<< Updated upstream
        title: const Text('Smart Insights'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(insightsProvider);
            },
=======
        title: const Text(
          'Smart Insights',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF9C27B0),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              _scoreController.reset();
              _cardsController.reset();
              _scoreController.forward();
              _cardsController.forward();
              ref.invalidate(insightsProvider);
            },
            tooltip: 'Refresh insights',
>>>>>>> Stashed changes
          ),
        ],
      ),
      body: insightsAsync.when(
        data: (insights) {
          final scoreColor = _getScoreColor(insights.comfortScore);
<<<<<<< Updated upstream
          final scoreLabel = _getScoreLabel(insights.comfortScore);

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(insightsProvider);
            },
=======
          final scoreGradient = _getScoreGradient(insights.comfortScore);
          final scoreLabel = _getScoreLabel(insights.comfortScore);
          final scoreIcon = _getScoreIcon(insights.comfortScore);

          return RefreshIndicator(
            onRefresh: () async {
              _scoreController.reset();
              _cardsController.reset();
              _scoreController.forward();
              _cardsController.forward();
              ref.invalidate(insightsProvider);
            },
            color: const Color(0xFF9C27B0),
>>>>>>> Stashed changes
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
<<<<<<< Updated upstream
                  // Comfort Score Card
                  Card(
                    elevation: 6,
                    color: scoreColor.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          const Text(
                            'Comfort Score',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 140,
                                height: 140,
                                child: CircularProgressIndicator(
                                  value: insights.comfortScore / 100,
                                  strokeWidth: 12,
                                  backgroundColor: Colors.grey[300],
                                  color: scoreColor,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    '${insights.comfortScore}',
                                    style: TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                      color: scoreColor,
                                    ),
                                  ),
                                  Text(
                                    scoreLabel,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: scoreColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Updated ${_formatTimestamp(insights.generatedAt)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Combined Summary Card
                  InsightsCard(
                    title: 'Overall Summary',
                    content: insights.combinedSummary,
                    icon: Icons.analytics,
                    color: Colors.purple,
                  ),

                  // Best Time to Go Out Card
                  InsightsCard(
                    title: 'Best Time to Go Out',
                    content: insights.bestTimeToGoOut,
                    icon: Icons.access_time,
                    color: Colors.blue,
                  ),

                  // Temperature Hint Card
                  InsightsCard(
                    title: 'Temperature Insights',
                    content: insights.temperatureHint,
                    icon: Icons.thermostat,
                    color: Colors.orange,
                  ),

                  // Air Quality Hint Card
                  InsightsCard(
                    title: 'Air Quality Insights',
                    content: insights.airQualityHint,
                    icon: Icons.air,
                    color: Colors.green,
                  ),

                  // Traffic Hint Card
                  InsightsCard(
                    title: 'Traffic Insights',
                    content: insights.trafficHint,
                    icon: Icons.traffic,
                    color: Colors.red,
                  ),

                  const SizedBox(height: 16),

                  // Info Footer
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
=======
                  // ===== Comfort Score Card =====
                  _buildComfortScoreCard(
                    insights.comfortScore,
                    scoreColor,
                    scoreGradient,
                    scoreLabel,
                    scoreIcon,
                    insights.generatedAt,
                  ),
                  const SizedBox(height: 24),

                  // ===== Section Header =====
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF9C27B0),
                                const Color(0xFFBA68C8),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Detailed Insights',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF9C27B0),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== Insights Cards with Staggered Animation =====
                  _buildAnimatedCard(
                    delay: 0,
                    child: _buildModernInsightsCard(
                      title: 'Overall Summary',
                      content: insights.combinedSummary,
                      icon: Icons.analytics_rounded,
                      color: const Color(0xFF9C27B0),
                      onInfoTap: () => _showInfoDialog(
                        context,
                        'Overall Summary',
                        'A comprehensive overview of current conditions based on weather, air quality, and traffic data.',
                      ),
                    ),
                  ),

                  _buildAnimatedCard(
                    delay: 100,
                    child: _buildModernInsightsCard(
                      title: 'Best Time to Go Out',
                      content: insights.bestTimeToGoOut,
                      icon: Icons.access_time_rounded,
                      color: const Color(0xFF2196F3),
                      onInfoTap: () => _showInfoDialog(
                        context,
                        'Best Time to Go Out',
                        'Recommended time periods based on optimal weather conditions, air quality, and traffic flow.',
                      ),
                    ),
                  ),

                  _buildAnimatedCard(
                    delay: 200,
                    child: _buildModernInsightsCard(
                      title: 'Temperature Insights',
                      content: insights.temperatureHint,
                      icon: Icons.thermostat_rounded,
                      color: const Color(0xFFFF9800),
                      onInfoTap: () => _showInfoDialog(
                        context,
                        'Temperature Insights',
                        'Analysis of current temperature trends and comfort levels throughout the day.',
                      ),
                    ),
                  ),

                  _buildAnimatedCard(
                    delay: 300,
                    child: _buildModernInsightsCard(
                      title: 'Air Quality Insights',
                      content: insights.airQualityHint,
                      icon: Icons.air_rounded,
                      color: const Color(0xFF4CAF50),
                      onInfoTap: () => _showInfoDialog(
                        context,
                        'Air Quality Insights',
                        'Information about current air pollution levels and health recommendations.',
                      ),
                    ),
                  ),

                  _buildAnimatedCard(
                    delay: 400,
                    child: _buildModernInsightsCard(
                      title: 'Traffic Insights',
                      content: insights.trafficHint,
                      icon: Icons.traffic_rounded,
                      color: const Color(0xFFF44336),
                      onInfoTap: () => _showInfoDialog(
                        context,
                        'Traffic Insights',
                        'Current traffic conditions and recommended routes to avoid congestion.',
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===== Info Footer =====
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF9C27B0).withOpacity(0.1),
                            const Color(0xFFBA68C8).withOpacity(0.05),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF9C27B0).withOpacity(0.2),
                          width: 1,
                        ),
>>>>>>> Stashed changes
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
<<<<<<< Updated upstream
                            Icons.info_outline,
                            size: 16,
                            color: Colors.grey[700],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Insights based on current weather, air quality, and traffic',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
=======
                            Icons.info_outline_rounded,
                            size: 18,
                            color: const Color(0xFF9C27B0),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              'Insights based on current weather, air quality, and traffic',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
>>>>>>> Stashed changes
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
<<<<<<< Updated upstream
=======
                  const SizedBox(height: 8),
>>>>>>> Stashed changes
                ],
              ),
            ),
          );
        },
<<<<<<< Updated upstream
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Analyzing data and generating insights...'),
=======
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFF9C27B0),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Analyzing data...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Generating personalized insights',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
>>>>>>> Stashed changes
            ],
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Padding(
<<<<<<< Updated upstream
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
                  'Error generating insights',
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
                ElevatedButton.icon(
                  onPressed: () {
                    ref.invalidate(insightsProvider);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
=======
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    size: 72,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Unable to generate insights',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
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
                const SizedBox(height: 36),
                ElevatedButton.icon(
                  onPressed: () {
                    _scoreController.reset();
                    _cardsController.reset();
                    _scoreController.forward();
                    _cardsController.forward();
                    ref.invalidate(insightsProvider);
                  },
                  icon: const Icon(Icons.refresh_rounded, size: 20),
                  label: const Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C27B0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
>>>>>>> Stashed changes
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
<<<<<<< Updated upstream
}
=======

  // ===== Widget Builder Methods =====

  /// Build animated comfort score card with gradient and glow
  Widget _buildComfortScoreCard(
      int score,
      Color color,
      List<Color> gradient,
      String label,
      IconData icon,
      DateTime timestamp,
      ) {
    return AnimatedBuilder(
      animation: _scoreAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.15),
                color.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Comfort Score',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _showInfoDialog(
                      context,
                      'Comfort Score',
                      'A comprehensive score (0-100) indicating overall comfort based on weather conditions, air quality, and traffic situation.',
                    ),
                    icon: Icon(
                      Icons.help_outline_rounded,
                      color: Colors.grey[600],
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Animated circular progress
                  SizedBox(
                    width: 160,
                    height: 160,
                    child: CircularProgressIndicator(
                      value: (score / 100) * _scoreAnimation.value,
                      strokeWidth: 14,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(color),
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                  // Score and label
                  Column(
                    children: [
                      Icon(
                        icon,
                        size: 36,
                        color: color,
                      ),
                      const SizedBox(height: 8),
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: gradient,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds),
                        child: Text(
                          '$score',
                          style: const TextStyle(
                            fontSize: 56,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: color,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: Colors.grey[700],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Updated ${_formatTimestamp(timestamp)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Build modern insights card with animation
  Widget _buildModernInsightsCard({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
    required VoidCallback onInfoTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with gradient
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.15),
                    color.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onInfoTap,
                    icon: Icon(
                      Icons.info_outline_rounded,
                      color: Colors.grey[600],
                      size: 20,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                  height: 1.6,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build animated card with staggered delay
  Widget _buildAnimatedCard({
    required int delay,
    required Widget child,
  }) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _cardsController,
          curve: Interval(
            delay / 500,
            (delay + 200) / 500,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _cardsController,
            curve: Interval(
              delay / 500,
              (delay + 200) / 500,
              curve: Curves.easeOut,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
}
>>>>>>> Stashed changes
>>>>>>> Stashed changes
