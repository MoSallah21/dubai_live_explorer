// lib/core/routing/app_router.dart

import 'package:flutter/material.dart';

// Import all feature screens
import '../../features/weather/presentation/screens/weather_screen.dart';
import '../../features/air_quality/presentation/screens/air_screen.dart';
import '../../features/traffic/presentation/screens/traffic_screen.dart';
import '../../features/insights/presentation/screens/insights_screen.dart';
import '../../features/alerts/presentation/screens/alerts_screen.dart';
import '../../app.dart'; // HomeScreen

/// Global router configuration using Navigator 2.0
///
/// This class provides a centralized routing system using the Router widget
/// and Navigator 2.0 API. It defines all routes, page configurations, and
/// navigation logic.
///
/// Usage in main.dart:
/// ```dart
/// MaterialApp.router(
///   routerDelegate: AppRouter.routerDelegate,
///   routeInformationParser: AppRouter.routeInformationParser,
///   backButtonDispatcher: AppRouter.backButtonDispatcher,
/// );
/// ```
class AppRouter {
  /// Private constructor to prevent instantiation
  AppRouter._();

  // ============================================================================
  // ROUTE PATHS - Define all route paths as constants
  // ============================================================================

  static const String home = '/';
  static const String weather = '/weather';
  static const String airQuality = '/air-quality';
  static const String traffic = '/traffic';
  static const String insights = '/insights';
  static const String alerts = '/alerts';
  static const String settings = '/settings';
  static const String weatherDetails = '/weather-details';

  // ============================================================================
  // NAVIGATOR 2.0 COMPONENTS
  // ============================================================================

  static final AppRouterDelegate routerDelegate = AppRouterDelegate();
  static final AppRouteInformationParser routeInformationParser =
  AppRouteInformationParser();
  static final RootBackButtonDispatcher backButtonDispatcher =
  RootBackButtonDispatcher();

  // ============================================================================
  // NAVIGATION HELPERS - Type-safe navigation methods
  // ============================================================================

  /// Navigate to home screen
  static void goToHome(BuildContext context) {
    routerDelegate.setNewRoutePath(RouteConfiguration(home));
  }

  /// Navigate to weather screen
  static void goToWeather(BuildContext context) {
    routerDelegate.setNewRoutePath(RouteConfiguration(weather));
  }

  /// Navigate to weather details with city ID
  static void goToWeatherDetails(BuildContext context, String cityId) {
    routerDelegate.setNewRoutePath(
      RouteConfiguration(weatherDetails, parameters: {'cityId': cityId}),
    );
  }

  /// Navigate to air quality screen
  static void goToAirQuality(BuildContext context) {
    routerDelegate.setNewRoutePath(RouteConfiguration(airQuality));
  }

  /// Navigate to traffic screen
  static void goToTraffic(BuildContext context) {
    routerDelegate.setNewRoutePath(RouteConfiguration(traffic));
  }

  /// Navigate to insights screen
  static void goToInsights(BuildContext context) {
    routerDelegate.setNewRoutePath(RouteConfiguration(insights));
  }

  /// Navigate to alerts screen
  static void goToAlerts(BuildContext context) {
    routerDelegate.setNewRoutePath(RouteConfiguration(alerts));
  }

  /// Go back to previous screen
  static void goBack(BuildContext context) {
    routerDelegate.popRoute();
  }

  /// Push a new screen (stack navigation)
  static void push(BuildContext context, String path, {Map<String, dynamic>? parameters}) {
    routerDelegate.push(RouteConfiguration(path, parameters: parameters));
  }

  /// Replace current screen
  static void replace(BuildContext context, String path, {Map<String, dynamic>? parameters}) {
    routerDelegate.replace(RouteConfiguration(path, parameters: parameters));
  }
}

// ==============================================================================
// ROUTE CONFIGURATION - Represents a single route with parameters
// ==============================================================================

/// Configuration for a single route
class RouteConfiguration {
  final String path;
  final Map<String, dynamic>? parameters;
  final Map<String, String>? queryParameters;

  RouteConfiguration(
      this.path, {
        this.parameters,
        this.queryParameters,
      });

  /// Parse URI to RouteConfiguration
  factory RouteConfiguration.fromUri(Uri uri) {
    return RouteConfiguration(
      uri.path,
      queryParameters: uri.queryParameters,
    );
  }

  /// Convert to URI
  Uri toUri() {
    return Uri(path: path, queryParameters: queryParameters);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is RouteConfiguration &&
              runtimeType == other.runtimeType &&
              path == other.path;

  @override
  int get hashCode => path.hashCode;
}

// ==============================================================================
// ROUTE INFORMATION PARSER - Converts URLs to RouteConfiguration
// ==============================================================================

/// Parses route information from URLs
class AppRouteInformationParser extends RouteInformationParser<RouteConfiguration> {
  @override
  Future<RouteConfiguration> parseRouteInformation(
      RouteInformation routeInformation,
      ) async {
    final uri = routeInformation.uri;

    // Handle home route
    if (uri.pathSegments.isEmpty) {
      return RouteConfiguration(AppRouter.home);
    }

    // Parse other routes
    return RouteConfiguration.fromUri(uri);
  }

  @override
  RouteInformation? restoreRouteInformation(RouteConfiguration configuration) {
    return RouteInformation(uri: configuration.toUri());
  }
}

// ==============================================================================
// ROUTER DELEGATE - Manages the navigation stack
// ==============================================================================

/// Manages the app's navigation stack
class AppRouterDelegate extends RouterDelegate<RouteConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteConfiguration> {

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Navigation stack
  final List<RouteConfiguration> _routeStack = [
    RouteConfiguration(AppRouter.home)
  ];

  // Get current route configuration
  RouteConfiguration get currentConfiguration => _routeStack.last;

  // ============================================================================
  // NAVIGATION METHODS
  // ============================================================================

  /// Set a new route (replaces current route)
  @override
  Future<void> setNewRoutePath(RouteConfiguration configuration) async {
    _routeStack
      ..clear()
      ..add(configuration);
    notifyListeners();
  }

  /// Push a new route onto the stack
  void push(RouteConfiguration configuration) {
    _routeStack.add(configuration);
    notifyListeners();
  }

  /// Replace the current route
  void replace(RouteConfiguration configuration) {
    if (_routeStack.isNotEmpty) {
      _routeStack.removeLast();
    }
    _routeStack.add(configuration);
    notifyListeners();
  }

  /// Pop the current route
  @override
  Future<bool> popRoute() async {
    if (_routeStack.length > 1) {
      _routeStack.removeLast();
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Clear stack and go to home
  void goHome() {
    _routeStack
      ..clear()
      ..add(RouteConfiguration(AppRouter.home));
    notifyListeners();
  }

  // ============================================================================
  // BUILD METHOD - Constructs the Navigator widget
  // ============================================================================

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _routeStack.map((config) => _createPage(config)).toList(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        if (_routeStack.length > 1) {
          _routeStack.removeLast();
          notifyListeners();
        }
        return true;
      },
    );
  }

  /// Create a page for the given route configuration
  Page _createPage(RouteConfiguration config) {
    Widget child;
    String name;

    // Match route path to screen
    switch (config.path) {
      case AppRouter.home:
        child = const HomeScreen();
        name = 'Home';
        break;

      case AppRouter.weather:
        child = const WeatherScreen();
        name = 'Weather';
        break;

      case AppRouter.airQuality:
        child = const AirScreen();
        name = 'Air Quality';
        break;

      case AppRouter.traffic:
        child = const TrafficScreen();
        name = 'Traffic';
        break;

      case AppRouter.insights:
        child = const InsightsScreen();
        name = 'Insights';
        break;

      case AppRouter.alerts:
        child = const AlertsScreen();
        name = 'Alerts';
        break;

      case AppRouter.weatherDetails:
        final cityId = config.parameters?['cityId'] as String? ?? 'unknown';
        child = WeatherDetailsScreen(cityId: cityId);
        name = 'Weather Details';
        break;

      default:
        child = const ErrorScreen();
        name = 'Error';
    }

    // Return page with custom transition
    return _AppPage(
      key: ValueKey(config.path),
      child: child,
      name: name,
    );
  }
}

// ==============================================================================
// CUSTOM PAGE - Page with custom transitions
// ==============================================================================

/// Custom page with fade transition
class _AppPage extends Page {
  final Widget child;
  final String name;

  const _AppPage({
    required LocalKey key,
    required this.child,
    required this.name,
  }) : super(key: key, name: name);

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Fade + Scale transition
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}

// ==============================================================================
// ERROR SCREEN - Fallback for unknown routes
// ==============================================================================

/// Error screen displayed when navigating to unknown routes
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 100,
                color: Colors.red[300],
              ),
              const SizedBox(height: 24),
              const Text(
                'Page Not Found',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'The page you are looking for does not exist.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () => AppRouter.goToHome(context),
                icon: const Icon(Icons.home_rounded),
                label: const Text('Go to Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==============================================================================
// PLACEHOLDER SCREEN - For weather details example
// ==============================================================================

/// Placeholder screen for weather details
class WeatherDetailsScreen extends StatelessWidget {
  final String cityId;

  const WeatherDetailsScreen({
    super.key,
    required this.cityId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Details - City $cityId'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => AppRouter.goBack(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'City ID: $cityId',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => AppRouter.goBack(context),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==============================================================================
// USAGE EXAMPLES
// ==============================================================================

/*
EXAMPLE 1: Navigate using AppRouter helper methods
```dart
// Type-safe navigation
ElevatedButton(
  onPressed: () => AppRouter.goToWeather(context),
  child: Text('Go to Weather'),
)
```

EXAMPLE 2: Navigate with parameters
```dart
// Pass parameters in the route
AppRouter.goToWeatherDetails(context, 'dubai-123');

// Or using push with parameters map
AppRouter.push(
  context,
  AppRouter.weatherDetails,
  parameters: {'cityId': 'dubai-123'},
);
```

EXAMPLE 3: Push vs Replace navigation
```dart
// Replace current screen (no back button)
AppRouter.replace(context, AppRouter.home);

// Push new screen (keeps back button)
AppRouter.push(context, AppRouter.weather);

// Go back
AppRouter.goBack(context);
```

EXAMPLE 4: Access router delegate directly
```dart
// For advanced operations
final delegate = AppRouter.routerDelegate;
delegate.goHome(); // Clear stack and go home
```

EXAMPLE 5: Check navigation stack
```dart
final delegate = AppRouter.routerDelegate;
final currentRoute = delegate.currentConfiguration;
print('Current path: ${currentRoute.path}');
```

EXAMPLE 6: Adding a new route
```dart
// 1. Add route path constant in AppRouter class
static const String newFeature = '/new-feature';

// 2. Add case in _createPage method in AppRouterDelegate
case AppRouter.newFeature:
  child = const NewFeatureScreen();
  name = 'New Feature';
  break;

// 3. Add navigation helper method in AppRouter class
static void goToNewFeature(BuildContext context) {
  routerDelegate.setNewRoutePath(RouteConfiguration(newFeature));
}

// 4. Use it anywhere
AppRouter.goToNewFeature(context);
```

EXAMPLE 7: Custom transitions (modify _AppPage)
```dart
// Change transitionsBuilder in _AppPage.createRoute()
transitionsBuilder: (context, animation, secondaryAnimation, child) {
  // Slide transition
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  final tween = Tween(begin: begin, end: end);
  final offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
},
```

EXAMPLE 8: Route with query parameters
```dart
// Create route with query parameters
final route = RouteConfiguration(
  '/settings',
  queryParameters: {'section': 'notifications', 'theme': 'dark'},
);
AppRouter.routerDelegate.setNewRoutePath(route);

// Access in screen
final queryParams = routeConfiguration.queryParameters;
final section = queryParams?['section'] ?? 'general';
```

EXAMPLE 9: Programmatic navigation from anywhere
```dart
// Get navigator key from router delegate
final navigatorKey = AppRouter.routerDelegate.navigatorKey;

// Use it to navigate without context
navigatorKey.currentState?.push(
  MaterialPageRoute(builder: (_) => SomeScreen()),
);
```

EXAMPLE 10: Handle back button on Android
```dart
// The RootBackButtonDispatcher automatically handles this
// But you can override behavior in AppRouterDelegate:

@override
Future<bool> popRoute() async {
  if (_routeStack.length > 1) {
    // Custom logic before popping
    final shouldPop = await showExitDialog();
    if (shouldPop) {
      _routeStack.removeLast();
      notifyListeners();
      return true;
    }
    return false;
  }
  return false;
}
```

EXAMPLE 11: Setup in main.dart
```dart
import 'core/routing/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Smart City Dashboard',
      debugShowCheckedModeBanner: false,

      // Navigator 2.0 configuration
      routerDelegate: AppRouter.routerDelegate,
      routeInformationParser: AppRouter.routeInformationParser,
      backButtonDispatcher: AppRouter.backButtonDispatcher,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}
```

EXAMPLE 12: Deep linking support
```dart
// The RouteInformationParser automatically handles deep links
// URLs like myapp://weather or https://myapp.com/weather
// will be parsed and routed correctly

// To test deep links:
// 1. Configure app for deep linking in AndroidManifest.xml / Info.plist
// 2. Open URL: adb shell am start -W -a android.intent.action.VIEW \
//    -d "myapp://weather" com.example.app
```
*/