// features/traffic/domain/usecases/get_live_traffic.dart

import '../entities/traffic_entity.dart';
import '../repositories/traffic_repository.dart';

class GetLiveTraffic {
  final TrafficRepository repository;

  GetLiveTraffic({required this.repository});

  Future<TrafficEntity> call() async {
    return await repository.getLiveTraffic();
  }
}