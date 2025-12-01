import '../../domain/entities/air_entity.dart';
import '../../domain/repositories/air_repository.dart';
import '../datasources/air_api_service.dart';

class AirRepoImpl implements AirRepository {
  final AirApiService apiService;

  AirRepoImpl({required this.apiService});

  @override
  Future<AirEntity> getAirQuality() async {
    try {
      final model = await apiService.fetchAirQuality();
      return model;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}