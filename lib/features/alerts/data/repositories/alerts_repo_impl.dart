// features/alerts/data/repositories/alerts_repo_impl.dart

import '../../../air_quality/domain/entities/air_entity.dart';
import '../../../traffic/domain/entities/traffic_entity.dart';
import '../../../weather/domain/entities/weather_entity.dart';
import '../../domain/entities/alert_entity.dart';
import '../../domain/repositories/alerts_repository.dart';
import '../datasources/alerts_service.dart';

class AlertsRepoImpl implements AlertsRepository {
  final AlertsService service;

  AlertsRepoImpl({required this.service});

  @override
  Future<List<AlertEntity>> generateAlerts({
    required WeatherEntity weather,
    required AirEntity air,
    required TrafficEntity traffic,
  }) async {
    try {
      // Process alerts using the service
      final alerts = service.processAlerts(
        weather: weather,
        air: air,
        traffic: traffic,
      );

      return alerts;
    } catch (e) {
      throw Exception('Failed to generate alerts: $e');
    }
  }
}