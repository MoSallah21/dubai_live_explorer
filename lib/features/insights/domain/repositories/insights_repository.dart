// features/insights/domain/repositories/insights_repository.dart

import '../../../air_quality/domain/entities/air_entity.dart';
import '../../../traffic/domain/entities/traffic_entity.dart';
import '../../../weather/domain/entities/weather_entity.dart';
import '../entities/insights_entity.dart';

abstract class InsightsRepository {
  Future<InsightsEntity> generateInsights({
    required WeatherEntity weather,
    required AirEntity air,
    required TrafficEntity traffic,
  });
}