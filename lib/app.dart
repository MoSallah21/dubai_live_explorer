// lib/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import feature screens
import 'features/weather/presentation/screens/weather_screen.dart';
import 'features/air_quality/presentation/screens/air_screen.dart';
import 'features/traffic/presentation/screens/traffic_screen.dart';
import 'features/insights/presentation/screens/insights_screen.dart';
import 'features/alerts/presentation/screens/alerts_screen.dart';

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

/// Home screen with bottom navigation to access all features
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

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
    ),
  ];

  @override
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
      ),
    );
  }
}