// features/traffic/domain/repositories/traffic_repository.dart

import '../entities/traffic_entity.dart';

abstract class TrafficRepository {
  Future<TrafficEntity> getLiveTraffic();
}