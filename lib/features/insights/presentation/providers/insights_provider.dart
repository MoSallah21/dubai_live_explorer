// features/insights/presentation/providers/insights_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../air_quality/presentation/providers/air_providers.dart';
import '../../../traffic/presentation/providers/traffic_providers.dart';
import '../../../weather/presentation/providers/weather_providers.dart';
import '../../data/datasources/insights_service.dart';
import '../../data/repositories/insights_repo_impl.dart';
import '../../domain/entities/insights_entity.dart';
import '../../domain/repositories/insights_repository.dart';
import '../../domain/usecases/generate_insights.dart';

// Service Provider
final insightsServiceProvider = Provider<InsightsService>((ref) {
  return InsightsService();
});

// Repository Provider
final insightsRepoProvider = Provider<InsightsRepository>((ref) {
  final service = ref.watch(insightsServiceProvider);
  return InsightsRepoImpl(service: service);
});

// UseCase Provider
final generateInsightsUseCaseProvider = Provider<GenerateInsights>((ref) {
  final repository = ref.watch(insightsRepoProvider);
  return GenerateInsights(repository: repository);
});

// Insights Provider (FutureProvider)
final insightsProvider = FutureProvider<InsightsEntity>((ref) async {
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

  // Generate insights using the use case
  final useCase = ref.watch(generateInsightsUseCaseProvider);
  return await useCase.call(
    weather: weather,
    air: air,
    traffic: traffic,
  );
});