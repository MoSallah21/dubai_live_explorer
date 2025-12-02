// features/alerts/presentation/providers/alerts_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../air_quality/presentation/providers/air_providers.dart';
import '../../../traffic/presentation/providers/traffic_providers.dart';
import '../../../weather/presentation/providers/weather_providers.dart';
import '../../data/datasources/alerts_service.dart';
import '../../data/repositories/alerts_repo_impl.dart';
import '../../domain/entities/alert_entity.dart';
import '../../domain/repositories/alerts_repository.dart';
import '../../domain/usecases/generate_alerts.dart';

// Service Provider
final alertsServiceProvider = Provider<AlertsService>((ref) {
  return AlertsService();
});

// Repository Provider
final alertsRepoProvider = Provider<AlertsRepository>((ref) {
  final service = ref.watch(alertsServiceProvider);
  return AlertsRepoImpl(service: service);
});

// UseCase Provider
final generateAlertsUseCaseProvider = Provider<GenerateAlerts>((ref) {
  final repository = ref.watch(alertsRepoProvider);
  return GenerateAlerts(repository: repository);
});

// Alerts Provider (FutureProvider)
final alertsProvider = FutureProvider<List<AlertEntity>>((ref) async {
  // Watch all three data providers
  final weatherAsync = ref.watch(weatherProvider);
  final airQualityAsync = ref.watch(airQualityProvider);
  final trafficAsync = ref.watch(trafficProvider);

  // Wait for all data to be available
  final weather = await weatherAsync.when(
    data: (data) => data,
    loading: () => throw Exception('Weather data is loading'),
    error: (error, stack) => throw Exception('Weather data error: $error'),
  );

  final air = await airQualityAsync.when(
    data: (data) => data,
    loading: () => throw Exception('Air quality data is loading'),
    error: (error, stack) => throw Exception('Air quality data error: $error'),
  );

  final traffic = await trafficAsync.when(
    data: (data) => data,
    loading: () => throw Exception('Traffic data is loading'),
    error: (error, stack) => throw Exception('Traffic data error: $error'),
  );

  // Generate alerts using the use case
  final useCase = ref.watch(generateAlertsUseCaseProvider);
  return await useCase.call(
    weather: weather,
    air: air,
    traffic: traffic,
  );
});