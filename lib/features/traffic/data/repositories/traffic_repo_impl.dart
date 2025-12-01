// features/traffic/data/repositories/traffic_repo_impl.dart

import '../../domain/entities/traffic_entity.dart';
import '../../domain/repositories/traffic_repository.dart';
import '../datasources/traffic_api_service.dart';

class TrafficRepoImpl implements TrafficRepository {
  final TrafficApiService apiService;

  TrafficRepoImpl({required this.apiService});

  @override
  Future<TrafficEntity> getLiveTraffic() async {
    try {
      final model = await apiService.fetchLiveTraffic();
      return model;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}