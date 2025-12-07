// lib/app.dart

<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
import 'dart:ui';

>>>>>>> Stashed changes
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import feature screens
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
=======
import 'features/alerts/presentation/providers/alerts_providers.dart';
>>>>>>> Stashed changes
>>>>>>> Stashed changes
import 'features/weather/presentation/screens/weather_screen.dart';
import 'features/air_quality/presentation/screens/air_screen.dart';
import 'features/traffic/presentation/screens/traffic_screen.dart';
import 'features/insights/presentation/screens/insights_screen.dart';
import 'features/alerts/presentation/screens/alerts_screen.dart';
<<<<<<< Updated upstream

=======
<<<<<<< Updated upstream

=======
import 'package:flutter/material.dart';
import 'dart:ui';

class DynamicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback? onRefresh;
  final List<Widget>? additionalActions;
  final bool showBackButton;

  const DynamicAppBar({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    this.onRefresh,
    this.additionalActions,
    this.showBackButton = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: showBackButton,
      leading: showBackButton
          ? Container(
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      )
          : null,
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
                Colors.black.withOpacity(0.15),
                Colors.transparent,
              ],
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(20 * (1 - value), 0),
                  child: child,
                ),
              );
            },
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 22,
                letterSpacing: 0.5,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        if (additionalActions != null) ...additionalActions!,
        if (onRefresh != null)
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Colors.white),
              onPressed: onRefresh,
              tooltip: 'Refresh',
            ),
          ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class AppBarConfig {
  static const insights = AppBarStyle(
    title: 'Smart Insights',
    icon: Icons.analytics_rounded,
    gradient: [Color(0xFF9C27B0), Color(0xFF7B1FA2)],
  );

  static const weather = AppBarStyle(
    title: 'Weather',
    icon: Icons.wb_sunny_rounded,
    gradient: [Color(0xFF2196F3), Color(0xFF1976D2)],
  );

  static const air = AppBarStyle(
    title: 'Air Quality',
    icon: Icons.air_rounded,
    gradient: [Color(0xFF4CAF50), Color(0xFF388E3C)],
  );

  static const traffic = AppBarStyle(
    title: 'Live Traffic',
    icon: Icons.traffic_rounded,
    gradient: [Color(0xFFFF9800), Color(0xFFF57C00)],
  );

  static const alerts = AppBarStyle(
    title: 'Active Alerts',
    icon: Icons.notifications_active_rounded,
    gradient: [Color(0xFFF44336), Color(0xFFD32F2F)],
  );
}

class AppBarStyle {
  final String title;
  final IconData icon;
  final List<Color> gradient;

  const AppBarStyle({
    required this.title,
    required this.icon,
    required this.gradient,
  });
}

class AnimatedAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback? onRefresh;
  final List<Widget>? additionalActions;
  final bool showBackButton;
  final bool showSearch;

  const AnimatedAppBar({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    this.onRefresh,
    this.additionalActions,
    this.showBackButton = false,
    this.showSearch = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<AnimatedAppBar> createState() => _AnimatedAppBarState();
}

class _AnimatedAppBarState extends State<AnimatedAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: widget.showBackButton,
      leading: widget.showBackButton
          ? Container(
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      )
          : null,
      flexibleSpace: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.gradient,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topRight,
                    radius: 1.5 * _pulseAnimation.value,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Positioned(
            right: -50,
            top: -50,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * 3.14159,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.icon,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 14),
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                Colors.white,
                Colors.white.withOpacity(0.9),
              ],
            ).createShader(bounds),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 23,
                letterSpacing: 0.8,
                shadows: [
                  Shadow(
                    color: Colors.black38,
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        if (widget.showSearch)
          Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.search_rounded, color: Colors.white),
              onPressed: () {},
              tooltip: 'Search',
            ),
          ),
        if (widget.additionalActions != null) ...widget.additionalActions!,
        if (widget.onRefresh != null)
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded, color: Colors.white),
              onPressed: widget.onRefresh,
              tooltip: 'Refresh',
            ),
          ),
        const SizedBox(width: 4),
      ],
    );
  }
}

class GlassmorphicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData icon;
  final List<Color> gradient;
  final VoidCallback? onRefresh;
  final List<Widget>? additionalActions;

  const GlassmorphicAppBar({
    super.key,
    required this.title,
    required this.icon,
    required this.gradient,
    this.onRefresh,
    this.additionalActions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white.withOpacity(0.1),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            centerTitle: true,
            actions: [
              if (additionalActions != null) ...additionalActions!,
              if (onRefresh != null)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                    onPressed: onRefresh,
                  ),
                ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }
}
>>>>>>> Stashed changes
>>>>>>> Stashed changes
/// Main application widget with Riverpod integration
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // App configuration
      title: 'Smart City Dashboard',
      debugShowCheckedModeBanner: false,

      // Theme configuration
      theme: ThemeData(
        // Color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,

        // App bar theme
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),

        // Card theme - CORRECTED
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Input decoration theme
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),

        // Button themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      // Initial route - start with insights screen
      initialRoute: '/',

      // Route definitions
      routes: {
        '/': (context) => const HomeScreen(),
        '/weather': (context) => const WeatherScreen(),
        '/air_quality': (context) => const AirScreen(),
        '/traffic': (context) => const TrafficScreen(),
        '/insights': (context) => const InsightsScreen(),
        '/alerts': (context) => const AlertsScreen(),
      },

      // Fallback route for unknown routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      },
    );
  }
}

<<<<<<< Updated upstream
/// Home screen with bottom navigation to access all features
=======
<<<<<<< Updated upstream
/// Home screen with bottom navigation to access all features
=======

/// Modern home screen with premium bottom navigation
>>>>>>> Stashed changes
>>>>>>> Stashed changes
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  // List of screens corresponding to bottom navigation items
  final List<Widget> _screens = const [
    InsightsScreen(),
    WeatherScreen(),
    AirScreen(),
    TrafficScreen(),
    AlertsScreen(),
  ];

  // Bottom navigation configuration
  final List<BottomNavigationBarItem> _navItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.analytics),
      label: 'Insights',
      tooltip: 'View smart insights',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.wb_sunny),
      label: 'Weather',
      tooltip: 'Weather forecast',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.air),
      label: 'Air Quality',
      tooltip: 'Air quality monitoring',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.traffic),
      label: 'Traffic',
      tooltip: 'Live traffic updates',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.notifications_active),
      label: 'Alerts',
      tooltip: 'Active alerts',
<<<<<<< Updated upstream
=======
=======
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
>>>>>>> Stashed changes
>>>>>>> Stashed changes
    ),
  ];

  @override
<<<<<<< Updated upstream
=======
<<<<<<< Updated upstream
>>>>>>> Stashed changes
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navItems,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        showUnselectedLabels: true,
        elevation: 8,
<<<<<<< Updated upstream
=======
=======
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
>>>>>>> Stashed changes
>>>>>>> Stashed changes
      ),
    );
  }
}