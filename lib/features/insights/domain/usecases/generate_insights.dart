// features/insights/domain/usecases/generate_insights.dart

import '../../../air_quality/domain/entities/air_entity.dart';
import '../../../traffic/domain/entities/traffic_entity.dart';
import '../../../weather/domain/entities/weather_entity.dart';
import '../entities/insights_entity.dart';
import '../repositories/insights_repository.dart';

class GenerateInsights {
  final InsightsRepository repository;

  GenerateInsights({required this.repository});

  Future<InsightsEntity> call({
    required WeatherEntity weather,
    required AirEntity air,
    required TrafficEntity traffic,
  }) async {
    return await repository.generateInsights(
      weather: weather,
      air: air,
      traffic: traffic,
    );
  }
}