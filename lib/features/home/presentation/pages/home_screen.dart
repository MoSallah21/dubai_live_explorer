import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../air_quality/presentation/screens/air_screen.dart';
import '../../../alerts/presentation/providers/alerts_providers.dart';
import '../../../alerts/presentation/screens/alerts_screen.dart';
import '../../../insights/presentation/screens/insights_screen.dart';
import '../../../traffic/presentation/screens/traffic_screen.dart';
import '../../../weather/presentation/screens/weather_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late PageController _pageController;
  late List<AnimationController> _iconAnimationControllers;
  late List<Animation<double>> _iconScaleAnimations;

  // Screen configuration with metadata
  final List<_ScreenConfig> _screenConfigs = const [
    _ScreenConfig(
      screen: InsightsScreen(),
      icon: Icons.analytics_rounded,
      label: 'Insights',
      tooltip: 'View smart insights',
      color: Color(0xFF7C4DFF),
      gradient: [Color(0xFF7C4DFF), Color(0xFF9C27B0)],
    ),
    _ScreenConfig(
      screen: WeatherScreen(),
      icon: Icons.wb_sunny_rounded,
      label: 'Weather',
      tooltip: 'Weather forecast',
      color: Color(0xFF2196F3),
      gradient: [Color(0xFF2196F3), Color(0xFF1976D2)],
    ),
    _ScreenConfig(
      screen: AirScreen(),
      icon: Icons.air_rounded,
      label: 'Air Quality',
      tooltip: 'Air quality monitoring',
      color: Color(0xFF4CAF50),
      gradient: [Color(0xFF4CAF50), Color(0xFF388E3C)],
    ),
    _ScreenConfig(
      screen: TrafficScreen(),
      icon: Icons.traffic_rounded,
      label: 'Traffic',
      tooltip: 'Live traffic updates',
      color: Color(0xFFFF9800),
      gradient: [Color(0xFFFF9800), Color(0xFFF57C00)],
    ),
    _ScreenConfig(
      screen: AlertsScreen(),
      icon: Icons.notifications_active_rounded,
      label: 'Alerts',
      tooltip: 'Active alerts',
      color: Color(0xFFF44336),
      gradient: [Color(0xFFF44336), Color(0xFFD32F2F)],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Initialize animation controllers for each navigation item
    _iconAnimationControllers = List.generate(
      _screenConfigs.length,
          (index) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );

    // Initialize scale animations
    _iconScaleAnimations = _iconAnimationControllers.map((controller) {
      return Tween<double>(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    // Animate the first icon
    _iconAnimationControllers[0].forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _iconAnimationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onNavigationTap(int index) {
    if (_currentIndex == index) return;

    setState(() {
      _currentIndex = index;
    });

    // Animate page transition
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );

    // Animate icons
    for (int i = 0; i < _iconAnimationControllers.length; i++) {
      if (i == index) {
        _iconAnimationControllers[i].forward();
      } else {
        _iconAnimationControllers[i].reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch alerts provider for badge count
    final alertsAsync = ref.watch(alertsProvider);
    final alertCount = alertsAsync.when(
      data: (alerts) => alerts.length,
      loading: () => 0,
      error: (_, __) => 0,
    );

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
          for (int i = 0; i < _iconAnimationControllers.length; i++) {
            if (i == index) {
              _iconAnimationControllers[i].forward();
            } else {
              _iconAnimationControllers[i].reverse();
            }
          }
        },
        itemCount: _screenConfigs.length,
        itemBuilder: (context, index) {
          return _screenConfigs[index].screen;
        },
      ),
      extendBody: true,
      bottomNavigationBar: _ModernBottomNavBar(
        currentIndex: _currentIndex,
        screenConfigs: _screenConfigs,
        iconScaleAnimations: _iconScaleAnimations,
        onTap: _onNavigationTap,
        alertCount: alertCount,
      ),
    );
  }
}

/// Screen configuration data class
class _ScreenConfig {
  final Widget screen;
  final IconData icon;
  final String label;
  final String tooltip;
  final Color color;
  final List<Color> gradient;

  const _ScreenConfig({
    required this.screen,
    required this.icon,
    required this.label,
    required this.tooltip,
    required this.color,
    required this.gradient,
  });
}

/// Modern bottom navigation bar with glassmorphism effect
class _ModernBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<_ScreenConfig> screenConfigs;
  final List<Animation<double>> iconScaleAnimations;
  final Function(int) onTap;
  final int alertCount;

  const _ModernBottomNavBar({
    required this.currentIndex,
    required this.screenConfigs,
    required this.iconScaleAnimations,
    required this.onTap,
    required this.alertCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final isDark = brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withOpacity(0.6)
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.1)
                    : Colors.black.withOpacity(0.05),
                width: 1.5,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                screenConfigs.length,
                    (index) => _NavItem(
                  config: screenConfigs[index],
                  isSelected: currentIndex == index,
                  scaleAnimation: iconScaleAnimations[index],
                  onTap: () => onTap(index),
                  showBadge: index == 4 && alertCount > 0,
                  badgeCount: alertCount,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Individual navigation item with animations
class _NavItem extends StatelessWidget {
  final _ScreenConfig config;
  final bool isSelected;
  final Animation<double> scaleAnimation;
  final VoidCallback onTap;
  final bool showBadge;
  final int badgeCount;

  const _NavItem({
    required this.config,
    required this.isSelected,
    required this.scaleAnimation,
    required this.onTap,
    this.showBadge = false,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Icon with animation and badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                          colors: config.gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : null,
                        color: isSelected ? null : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color: config.color.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                            : null,
                      ),
                      child: ScaleTransition(
                        scale: scaleAnimation,
                        child: Icon(
                          config.icon,
                          color: isSelected ? Colors.white : Colors.grey,
                          size: 26,
                        ),
                      ),
                    ),
                    // Badge for alerts
                    if (showBadge && badgeCount > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Center(
                            child: Text(
                              badgeCount > 9 ? '9+' : badgeCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                // Label with color transition
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 300),
                  style: TextStyle(
                    color: isSelected ? config.color : Colors.grey,
                    fontSize: isSelected ? 12 : 11,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  child: Text(
                    config.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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