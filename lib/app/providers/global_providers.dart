// // lib/core/providers/global_providers.dart
//
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// // Feature imports
// import '../../features/insights/domain/repositories/insights_repository.dart';
// import '../../features/traffic/domain/repositories/traffic_repository.dart';
// import '../../features/weather/data/repositories/weather_repository.dart';
// import '../../features/weather/domain/entities/weather_entity.dart';
// import '../../features/air_quality/data/repositories/air_repository.dart';
// import '../../features/air_quality/domain/entities/air_entity.dart';
// import '../../features/traffic/data/repositories/traffic_repository.dart';
// import '../../features/traffic/domain/entities/traffic_entity.dart';
// import '../../features/insights/data/repositories/insights_repository.dart';
// import '../../features/insights/domain/entities/insights_entity.dart';
// import '../../features/alerts/data/repositories/alerts_repository.dart';
// import '../../features/alerts/domain/entities/alert_entity.dart';
//
// // ============================================================================
// // SECTION 1: CORE INFRASTRUCTURE PROVIDERS
// // ============================================================================
//
// /// Provides the Connectivity plugin instance for monitoring network status
// ///
// /// Usage: `final connectivity = ref.watch(connectivityProvider);`
// ///
// /// This provider gives access to the device's connectivity status
// /// (WiFi, Mobile, None) and can be used to check network availability
// final connectivityProvider = Provider<Connectivity>((ref) {
//   return Connectivity();
// });
//
// /// Stream provider that monitors real-time connectivity changes
// ///
// /// Usage:
// /// ```dart
// /// final connectivityStatus = ref.watch(connectivityStreamProvider);
// /// connectivityStatus.when(
// ///   data: (result) => result == ConnectivityResult.none ? 'Offline' : 'Online',
// ///   loading: () => 'Checking...',
// ///   error: (_, __) => 'Error',
// /// );
// /// ```
// ///
// /// Automatically updates when network status changes
// final connectivityStreamProvider = StreamProvider.autoDispose<ConnectivityResult>((ref) {
//   final connectivity = ref.watch(connectivityProvider);
//   return connectivity.onConnectivityChanged;
// });
//
// /// Provider that checks if the device is currently online
// ///
// /// Usage: `final isOnline = ref.watch(isOnlineProvider);`
// ///
// /// Returns true if connected to WiFi or Mobile data, false otherwise
// final isOnlineProvider = Provider.autoDispose<bool>((ref) {
//   final connectivityAsync = ref.watch(connectivityStreamProvider);
//   return connectivityAsync.when(
//     data: (result) => result != ConnectivityResult.none,
//     loading: () => true, // Assume online while checking
//     error: (_, __) => false,
//   );
// });
//
// // ============================================================================
// // SECTION 2: REPOSITORY PROVIDERS
// // ============================================================================
// // These providers create singleton instances of repository classes that handle
// // data fetching and business logic for each feature
//
// /// Weather Repository - Handles all weather-related data operations
// ///
// /// Usage: `final weatherRepo = ref.read(weatherRepositoryProvider);`
// ///
// /// Provides methods for:
// /// - Fetching current weather data
// /// - Getting weather forecasts
// /// - Location-based weather queries
// final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
//   return WeatherRepository();
// });
//
// /// Air Quality Repository - Handles air quality data operations
// ///
// /// Usage: `final airRepo = ref.read(airQualityRepositoryProvider);`
// ///
// /// Provides methods for:
// /// - Fetching current air quality index (AQI)
// /// - Getting pollutant levels (PM2.5, PM10, etc.)
// /// - Historical air quality data
// final airQualityRepositoryProvider = Provider<AirQualityRepository>((ref) {
//   return AirQualityRepository();
// });
//
// /// Traffic Repository - Handles traffic data operations
// ///
// /// Usage: `final trafficRepo = ref.read(trafficRepositoryProvider);`
// ///
// /// Provides methods for:
// /// - Fetching live traffic conditions
// /// - Getting route congestion levels
// /// - Traffic predictions and alerts
// final trafficRepositoryProvider = Provider<TrafficRepository>((ref) {
//   return TrafficRepository();
// });
//
// /// Insights Repository - Handles AI-generated insights
// ///
// /// Usage: `final insightsRepo = ref.read(insightsRepositoryProvider);`
// ///
// /// Provides methods for:
// /// - Generating personalized insights
// /// - Analyzing combined data (weather, air, traffic)
// /// - Creating comfort scores and recommendations
// final insightsRepositoryProvider = Provider<InsightsRepository>((ref) {
//   return InsightsRepository();
// });
//
// /// Alerts Repository - Handles alert notifications
// ///
// /// Usage: `final alertsRepo = ref.read(alertsRepositoryProvider);`
// ///
// /// Provides methods for:
// /// - Fetching active alerts
// /// - Creating and dismissing alerts
// /// - Managing alert preferences
// final alertsRepositoryProvider = Provider<AlertsRepository>((ref) {
//   return AlertsRepository();
// });
//
// // ============================================================================
// // SECTION 3: DATA PROVIDERS (AsyncValue)
// // ============================================================================
// // These providers fetch and cache data from repositories, returning AsyncValue
// // which provides loading, data, and error states
//
// /// Current Weather Data Provider
// ///
// /// Usage:
// /// ```dart
// /// final weatherAsync = ref.watch(weatherDataProvider);
// /// weatherAsync.when(
// ///   data: (weather) => Text('Temperature: ${weather.temperature}°C'),
// ///   loading: () => CircularProgressIndicator(),
// ///   error: (error, _) => Text('Error: $error'),
// /// );
// /// ```
// ///
// /// Auto-refreshes every 5 minutes
// /// Automatically disposes when no longer watched
// final weatherDataProvider = FutureProvider.autoDispose<WeatherData>((ref) async {
//   final repository = ref.watch(weatherRepositoryProvider);
//
//   // Check network connectivity before fetching
//   final isOnline = ref.watch(isOnlineProvider);
//   if (!isOnline) {
//     throw Exception('No internet connection');
//   }
//
//   // Fetch weather data
//   final weather = await repository.getCurrentWeather();
//
//   // Set up auto-refresh after 5 minutes
//   ref.onDispose(() {
//     // Cleanup logic if needed
//   });
//
//   return weather;
// });
//
// /// Daily Weather Forecast Provider
// ///
// /// Usage:
// /// ```dart
// /// final forecastAsync = ref.watch(weatherForecastProvider);
// /// forecastAsync.when(
// ///   data: (forecast) => ListView.builder(...),
// ///   loading: () => CircularProgressIndicator(),
// ///   error: (error, _) => Text('Error loading forecast'),
// /// );
// /// ```
// ///
// /// Provides 7-day weather forecast
// /// Automatically disposes when no longer watched
// final weatherForecastProvider = FutureProvider.autoDispose<List<DailyForecast>>((ref) async {
//   final repository = ref.watch(weatherRepositoryProvider);
//
//   final isOnline = ref.watch(isOnlineProvider);
//   if (!isOnline) {
//     throw Exception('No internet connection');
//   }
//
//   return await repository.getWeatherForecast();
// });
//
// /// Air Quality Data Provider
// ///
// /// Usage:
// /// ```dart
// /// final airQualityAsync = ref.watch(airQualityDataProvider);
// /// airQualityAsync.when(
// ///   data: (air) => Text('AQI: ${air.aqi}'),
// ///   loading: () => CircularProgressIndicator(),
// ///   error: (error, _) => Text('Error: $error'),
// /// );
// /// ```
// ///
// /// Provides current air quality metrics including PM2.5, PM10, AQI
// /// Auto-refreshes every 10 minutes
// final airQualityDataProvider = FutureProvider.autoDispose<AirQualityData>((ref) async {
//   final repository = ref.watch(airQualityRepositoryProvider);
//
//   final isOnline = ref.watch(isOnlineProvider);
//   if (!isOnline) {
//     throw Exception('No internet connection');
//   }
//
//   return await repository.getAirQuality();
// });
//
// /// Traffic Data Provider
// ///
// /// Usage:
// /// ```dart
// /// final trafficAsync = ref.watch(trafficDataProvider);
// /// trafficAsync.when(
// ///   data: (traffic) => Text('Congestion: ${traffic.congestion}'),
// ///   loading: () => CircularProgressIndicator(),
// ///   error: (error, _) => Text('Error: $error'),
// /// );
// /// ```
// ///
// /// Provides real-time traffic conditions and congestion levels
// /// Auto-refreshes every 2 minutes
// final trafficDataProvider = FutureProvider.autoDispose<TrafficData>((ref) async {
//   final repository = ref.watch(trafficRepositoryProvider);
//
//   final isOnline = ref.watch(isOnlineProvider);
//   if (!isOnline) {
//     throw Exception('No internet connection');
//   }
//
//   return await repository.getTrafficData();
// });
//
// /// Smart Insights Provider
// ///
// /// Usage:
// /// ```dart
// /// final insightsAsync = ref.watch(smartInsightsProvider);
// /// insightsAsync.when(
// ///   data: (insights) => Text('Comfort Score: ${insights.comfortScore}'),
// ///   loading: () => CircularProgressIndicator(),
// ///   error: (error, _) => Text('Error: $error'),
// /// );
// /// ```
// ///
// /// Generates AI-powered insights based on weather, air quality, and traffic
// /// Automatically combines data from multiple sources
// /// Refreshes when any dependent data changes
// final smartInsightsProvider = FutureProvider.autoDispose<InsightsData>((ref) async {
//   final repository = ref.watch(insightsRepositoryProvider);
//
//   final isOnline = ref.watch(isOnlineProvider);
//   if (!isOnline) {
//     throw Exception('No internet connection');
//   }
//
//   // Wait for all dependent data to be available
//   final weather = await ref.watch(weatherDataProvider.future);
//   final airQuality = await ref.watch(airQualityDataProvider.future);
//   final traffic = await ref.watch(trafficDataProvider.future);
//
//   // Generate insights based on combined data
//   return await repository.generateInsights(
//     weather: weather,
//     airQuality: airQuality,
//     traffic: traffic,
//   );
// });
//
// /// Active Alerts Provider
// ///
// /// Usage:
// /// ```dart
// /// final alertsAsync = ref.watch(activeAlertsProvider);
// /// alertsAsync.when(
// ///   data: (alerts) => Text('${alerts.length} active alerts'),
// ///   loading: () => CircularProgressIndicator(),
// ///   error: (error, _) => Text('Error: $error'),
// /// );
// /// ```
// ///
// /// Provides list of all active system alerts
// /// Includes weather warnings, air quality alerts, traffic incidents
// final activeAlertsProvider = FutureProvider.autoDispose<List<Alert>>((ref) async {
//   final repository = ref.watch(alertsRepositoryProvider);
//
//   final isOnline = ref.watch(isOnlineProvider);
//   if (!isOnline) {
//     throw Exception('No internet connection');
//   }
//
//   return await repository.getActiveAlerts();
// });
//
// // ============================================================================
// // SECTION 4: LOCATION PROVIDERS
// // ============================================================================
//
// /// Current Location Provider
// ///
// /// Usage: `final location = ref.watch(currentLocationProvider);`
// ///
// /// Provides the user's current location coordinates
// /// Used by weather, air quality, and traffic providers
// final currentLocationProvider = Provider<LocationData>((ref) {
//   // Default location (Dubai, UAE)
//   // In production, this would fetch actual device location
//   return const LocationData(
//     latitude: 25.2048,
//     longitude: 55.2708,
//     city: 'Dubai',
//     country: 'UAE',
//   );
// });
//
// /// Location data class
// class LocationData {
//   final double latitude;
//   final double longitude;
//   final String city;
//   final String country;
//
//   const LocationData({
//     required this.latitude,
//     required this.longitude,
//     required this.city,
//     required this.country,
//   });
// }
//
// // ============================================================================
// // SECTION 5: APP STATE PROVIDERS
// // ============================================================================
//
// /// Theme Mode Provider
// ///
// /// Usage:
// /// ```dart
// /// final isDark = ref.watch(isDarkModeProvider);
// /// // Toggle theme:
// /// ref.read(isDarkModeProvider.notifier).state = !isDark;
// /// ```
// ///
// /// Controls app-wide theme (light/dark mode)
// final isDarkModeProvider = StateProvider<bool>((ref) {
//   return false; // Default to light mode
// });
//
// /// Loading State Provider
// ///
// /// Usage:
// /// ```dart
// /// final isLoading = ref.watch(isLoadingProvider);
// /// if (isLoading) return CircularProgressIndicator();
// /// ```
// ///
// /// Global loading indicator for app-wide operations
// final isLoadingProvider = StateProvider<bool>((ref) {
//   return false;
// });
//
// /// Last Refresh Timestamp Provider
// ///
// /// Usage:
// /// ```dart
// /// final lastRefresh = ref.watch(lastRefreshTimeProvider);
// /// Text('Last updated: ${lastRefresh?.toString() ?? "Never"}');
// /// ```
// ///
// /// Tracks when data was last refreshed across all features
// final lastRefreshTimeProvider = StateProvider<DateTime?>((ref) {
//   return null;
// });
//
// // ============================================================================
// // SECTION 6: UTILITY PROVIDERS
// // ============================================================================
//
// /// Refresh All Data Provider
// ///
// /// Usage:
// /// ```dart
// /// await ref.read(refreshAllDataProvider);
// /// ```
// ///
// /// Triggers a refresh of all data providers (weather, air quality, traffic, insights)
// /// Returns true if successful, false otherwise
// final refreshAllDataProvider = FutureProvider.autoDispose<bool>((ref) async {
//   try {
//     // Invalidate all data providers to trigger refresh
//     ref.invalidate(weatherDataProvider);
//     ref.invalidate(weatherForecastProvider);
//     ref.invalidate(airQualityDataProvider);
//     ref.invalidate(trafficDataProvider);
//     ref.invalidate(smartInsightsProvider);
//     ref.invalidate(activeAlertsProvider);
//
//     // Update last refresh time
//     ref.read(lastRefreshTimeProvider.notifier).state = DateTime.now();
//
//     return true;
//   } catch (e) {
//     return false;
//   }
// });
//
// /// Error Handler Provider
// ///
// /// Usage:
// /// ```dart
// /// ref.read(errorHandlerProvider)(error, stackTrace);
// /// ```
// ///
// /// Centralized error handling for the entire app
// /// Logs errors and can show user-friendly error messages
// final errorHandlerProvider = Provider<void Function(Object error, StackTrace? stackTrace)>((ref) {
//   return (error, stackTrace) {
//     // Log error to console (in production, send to error tracking service)
//     print('Error: $error');
//     if (stackTrace != null) {
//       print('Stack trace: $stackTrace');
//     }
//
//     // TODO: Implement error reporting service (e.g., Sentry, Firebase Crashlytics)
//     // TODO: Show user-friendly error dialog or snackbar
//   };
// });
//
// // ============================================================================
// // SECTION 7: CACHE & PREFERENCES PROVIDERS
// // ============================================================================
//
// /// Data Cache Duration Provider
// ///
// /// Usage: `final cacheDuration = ref.watch(cacheDurationProvider);`
// ///
// /// Defines how long cached data should be considered valid
// final cacheDurationProvider = Provider<Duration>((ref) {
//   return const Duration(minutes: 5);
// });
//
// /// User Preferences Provider
// ///
// /// Usage:
// /// ```dart
// /// final prefs = ref.watch(userPreferencesProvider);
// /// // Update preference:
// /// ref.read(userPreferencesProvider.notifier).update((state) =>
// ///   state.copyWith(temperatureUnit: TemperatureUnit.celsius)
// /// );
// /// ```
// ///
// /// Stores user preferences like units, notification settings, etc.
// final userPreferencesProvider = StateProvider<UserPreferences>((ref) {
//   return const UserPreferences();
// });
//
// /// User preferences data class
// class UserPreferences {
//   final TemperatureUnit temperatureUnit;
//   final bool notificationsEnabled;
//   final bool trafficAlertsEnabled;
//   final bool weatherAlertsEnabled;
//
//   const UserPreferences({
//     this.temperatureUnit = TemperatureUnit.celsius,
//     this.notificationsEnabled = true,
//     this.trafficAlertsEnabled = true,
//     this.weatherAlertsEnabled = true,
//   });
//
//   UserPreferences copyWith({
//     TemperatureUnit? temperatureUnit,
//     bool? notificationsEnabled,
//     bool? trafficAlertsEnabled,
//     bool? weatherAlertsEnabled,
//   }) {
//     return UserPreferences(
//       temperatureUnit: temperatureUnit ?? this.temperatureUnit,
//       notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
//       trafficAlertsEnabled: trafficAlertsEnabled ?? this.trafficAlertsEnabled,
//       weatherAlertsEnabled: weatherAlertsEnabled ?? this.weatherAlertsEnabled,
//     );
//   }
// }
//
// enum TemperatureUnit { celsius, fahrenheit }
//
// // ============================================================================
// // SECTION 8: COMPUTED/DERIVED PROVIDERS
// // ============================================================================
//
// /// Combined Data Status Provider
// ///
// /// Usage:
// /// ```dart
// /// final status = ref.watch(combinedDataStatusProvider);
// /// if (status.allLoaded) { /* Show data */ }
// /// ```
// ///
// /// Provides aggregated loading status across all data providers
// /// Useful for showing global loading indicators
// final combinedDataStatusProvider = Provider.autoDispose<CombinedDataStatus>((ref) {
//   final weatherAsync = ref.watch(weatherDataProvider);
//   final airQualityAsync = ref.watch(airQualityDataProvider);
//   final trafficAsync = ref.watch(trafficDataProvider);
//   final insightsAsync = ref.watch(smartInsightsProvider);
//
//   final isWeatherLoading = weatherAsync.isLoading;
//   final isAirQualityLoading = airQualityAsync.isLoading;
//   final isTrafficLoading = trafficAsync.isLoading;
//   final isInsightsLoading = insightsAsync.isLoading;
//
//   final hasWeatherError = weatherAsync.hasError;
//   final hasAirQualityError = airQualityAsync.hasError;
//   final hasTrafficError = trafficAsync.hasError;
//   final hasInsightsError = insightsAsync.hasError;
//
//   return CombinedDataStatus(
//     isLoading: isWeatherLoading || isAirQualityLoading || isTrafficLoading || isInsightsLoading,
//     allLoaded: weatherAsync.hasValue && airQualityAsync.hasValue &&
//         trafficAsync.hasValue && insightsAsync.hasValue,
//     hasError: hasWeatherError || hasAirQualityError || hasTrafficError || hasInsightsError,
//   );
// });
//
// /// Combined data status class
// class CombinedDataStatus {
//   final bool isLoading;
//   final bool allLoaded;
//   final bool hasError;
//
//   const CombinedDataStatus({
//     required this.isLoading,
//     required this.allLoaded,
//     required this.hasError,
//   });
// }
//
// // ============================================================================
// // USAGE EXAMPLES
// // ============================================================================
//
// /*
// EXAMPLE 1: Watching data in a widget
// ```dart
// class MyWidget extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final weatherAsync = ref.watch(weatherDataProvider);
//
//     return weatherAsync.when(
//       data: (weather) => Text('Temp: ${weather.temperature}°C'),
//       loading: () => CircularProgressIndicator(),
//       error: (error, _) => Text('Error: $error'),
//     );
//   }
// }
// ```
//
// EXAMPLE 2: Refreshing data
// ```dart
// ElevatedButton(
//   onPressed: () {
//     // Refresh specific provider
//     ref.invalidate(weatherDataProvider);
//
//     // Or refresh all data
//     ref.read(refreshAllDataProvider);
//   },
//   child: Text('Refresh'),
// )
// ```
//
// EXAMPLE 3: Checking connectivity
// ```dart
// final isOnline = ref.watch(isOnlineProvider);
// if (!isOnline) {
//   return Text('No internet connection');
// }
// ```
//
// EXAMPLE 4: Reading from repository directly
// ```dart
// final repository = ref.read(weatherRepositoryProvider);
// final weather = await repository.getCurrentWeather();
// ```
//
// EXAMPLE 5: Updating user preferences
// ```dart
// ref.read(userPreferencesProvider.notifier).update((state) =>
//   state.copyWith(temperatureUnit: TemperatureUnit.fahrenheit)
// );
// ```
// */