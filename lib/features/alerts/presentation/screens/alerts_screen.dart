// features/alerts/presentation/screens/alerts_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/alerts_providers.dart';
import '../widgets/alert_card.dart';

class AlertsScreen extends ConsumerStatefulWidget {
  const AlertsScreen({super.key});

  @override
  ConsumerState<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends ConsumerState<AlertsScreen>
    with TickerProviderStateMixin {
  late AnimationController _bannerController;
  late AnimationController _cardsController;
  late Animation<double> _bannerAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation for summary banner
    _bannerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _bannerAnimation = CurvedAnimation(
      parent: _bannerController,
      curve: Curves.easeOutCubic,
    );

    // Animation for alert cards
    _cardsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _cardsController,
      curve: Curves.easeIn,
    );

    _bannerController.forward();
    _cardsController.forward();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    _cardsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final alertsAsync = ref.watch(alertsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Active Alerts',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFFF44336),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              _bannerController.reset();
              _cardsController.reset();
              _bannerController.forward();
              _cardsController.forward();
              ref.invalidate(alertsProvider);
            },
            tooltip: 'Refresh alerts',
          ),
        ],
      ),
      body: alertsAsync.when(
        data: (alerts) {
          // Filter alerts by severity for statistics
          final highAlerts = alerts.where((a) => a.severity == 'high').length;
          final mediumAlerts = alerts.where((a) => a.severity == 'medium').length;
          final lowAlerts = alerts.where((a) => a.severity == 'low').length;

          // ===== Empty State =====
          if (alerts.isEmpty) {
            return _buildEmptyState();
          }

          // ===== Alerts Display =====
          return RefreshIndicator(
            onRefresh: () async {
              _bannerController.reset();
              _cardsController.reset();
              _bannerController.forward();
              _cardsController.forward();
              ref.invalidate(alertsProvider);
            },
            color: const Color(0xFFF44336),
            child: Column(
              children: [
                // ===== Summary Statistics Banner =====
                _buildSummaryBanner(
                  highAlerts: highAlerts,
                  mediumAlerts: mediumAlerts,
                  lowAlerts: lowAlerts,
                  totalAlerts: alerts.length,
                ),

                // ===== Alerts List =====
                Expanded(
                  child: _buildAlertsList(alerts),
                ),
              ],
            ),
          );
        },
        loading: () => _buildLoadingState(),
        error: (error, stackTrace) => _buildErrorState(error),
      ),
    );
  }

  // ============================================================================
  // SUMMARY BANNER - Statistics Cards
  // ============================================================================

  Widget _buildSummaryBanner({
    required int highAlerts,
    required int mediumAlerts,
    required int lowAlerts,
    required int totalAlerts,
  }) {
    return FadeTransition(
      opacity: _bannerAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -0.5),
          end: Offset.zero,
        ).animate(_bannerAnimation),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey[50]!,
                Colors.grey[100]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Header
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 12),
                child: Text(
                  'Alert Summary',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700],
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              // Statistics Grid
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      count: highAlerts,
                      label: 'High',
                      color: const Color(0xFFF44336),
                      icon: Icons.error_rounded,
                      delay: 0,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      count: mediumAlerts,
                      label: 'Medium',
                      color: const Color(0xFFFF9800),
                      icon: Icons.warning_rounded,
                      delay: 100,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      count: lowAlerts,
                      label: 'Low',
                      color: const Color(0xFF4CAF50),
                      icon: Icons.info_rounded,
                      delay: 200,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      count: totalAlerts,
                      label: 'Total',
                      color: const Color(0xFF2196F3),
                      icon: Icons.notifications_active_rounded,
                      delay: 300,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build individual statistic card
  Widget _buildStatCard({
    required int count,
    required String label,
    required Color color,
    required IconData icon,
    required int delay,
  }) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _bannerController,
          curve: Interval(
            delay / 400,
            (delay + 200) / 400,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                    height: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================================
  // ALERTS LIST - Display alert cards with staggered animation
  // ============================================================================

  Widget _buildAlertsList(List alerts) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: alerts.length,
        itemBuilder: (context, index) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(
                parent: _cardsController,
                curve: Interval(
                  (index * 0.1).clamp(0.0, 0.5),
                  ((index * 0.1) + 0.3).clamp(0.3, 1.0),
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
                    (index * 0.1).clamp(0.0, 0.5),
                    ((index * 0.1) + 0.3).clamp(0.3, 1.0),
                    curve: Curves.easeOut,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AlertCard(alert: alerts[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================================
  // EMPTY STATE - No alerts available
  // ============================================================================

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(alertsProvider);
      },
      color: const Color(0xFF4CAF50),
      child: ListView(
        padding: const EdgeInsets.all(32.0),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Hero Icon
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  const Color(0xFF4CAF50).withOpacity(0.2),
                                  const Color(0xFF81C784).withOpacity(0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4CAF50).withOpacity(0.2),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.check_circle_outline_rounded,
                              size: 100,
                              color: Color(0xFF4CAF50),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // Title
                    const Text(
                      'All Clear!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4CAF50),
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    Text(
                      'No Active Alerts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'All conditions are within normal thresholds.\nYour environment is safe and stable.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                          height: 1.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Refresh Button
                    ElevatedButton.icon(
                      onPressed: () {
                        ref.invalidate(alertsProvider);
                      },
                      icon: const Icon(Icons.refresh_rounded, size: 20),
                      label: const Text(
                        'Check Again',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
                        elevation: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // LOADING STATE - Animated loading indicator
  // ============================================================================

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: CircularProgressIndicator(
              strokeWidth: 5,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFF44336),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Checking for alerts...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Analyzing current conditions',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // ERROR STATE - Clean error display with retry
  // ============================================================================

  Widget _buildErrorState(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon with gradient background
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.withOpacity(0.15),
                    Colors.red.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 80,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 32),

            // Error Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.red.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Unable to Load Alerts',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Retry Button
            ElevatedButton.icon(
              onPressed: () {
                ref.invalidate(alertsProvider);
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
                backgroundColor: const Color(0xFFF44336),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}