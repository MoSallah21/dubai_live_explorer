// features/alerts/domain/usecases/generate_alerts.dart

import '../../../air_quality/domain/entities/air_entity.dart';
import '../../../traffic/domain/entities/traffic_entity.dart';
import '../../../weather/domain/entities/weather_entity.dart';
import '../entities/alert_entity.dart';
import '../repositories/alerts_repository.dart';

class GenerateAlerts {
  final AlertsRepository repository;

  GenerateAlerts({required this.repository});

  Future<List<AlertEntity>> call({
    required WeatherEntity weather,
    required AirEntity air,
    required TrafficEntity traffic,
  }) async {
    return await repository.generateAlerts(
      weather: weather,
      air: air,
      traffic: traffic,
    );
  }
}