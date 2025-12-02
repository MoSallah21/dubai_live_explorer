// features/alerts/domain/repositories/alerts_repository.dart

import '../../../air_quality/domain/entities/air_entity.dart';
import '../../../traffic/domain/entities/traffic_entity.dart';
import '../../../weather/domain/entities/weather_entity.dart';
import '../entities/alert_entity.dart';

abstract class AlertsRepository {
  Future<List<AlertEntity>> generateAlerts({
    required WeatherEntity weather,
    required AirEntity air,
    required TrafficEntity traffic,
  });
}