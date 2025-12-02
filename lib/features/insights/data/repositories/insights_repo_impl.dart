// features/insights/data/repositories/insights_repo_impl.dart

import '../../../air_quality/domain/entities/air_entity.dart';
import '../../../traffic/domain/entities/traffic_entity.dart';
import '../../../weather/domain/entities/weather_entity.dart';
import '../../domain/entities/insights_entity.dart';
import '../../domain/repositories/insights_repository.dart';
import '../datasources/insights_service.dart';

class InsightsRepoImpl implements InsightsRepository {
  final InsightsService service;

  InsightsRepoImpl({required this.service});

  @override
  Future<InsightsEntity> generateInsights({
    required WeatherEntity weather,
    required AirEntity air,
    required TrafficEntity traffic,
  }) async {
    try {
      // Process insights using the service
      final insights = service.processInsights(
        weather: weather,
        air: air,
        traffic: traffic,
      );

      return insights;
    } catch (e) {
      throw Exception('Failed to generate insights: $e');
    }
  }
}