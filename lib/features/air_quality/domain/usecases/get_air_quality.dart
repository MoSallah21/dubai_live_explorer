import '../entities/air_entity.dart';
import '../repositories/air_repository.dart';

class GetAirQuality {
  final AirRepository repository;

  GetAirQuality({required this.repository});

  Future<AirEntity> call() async {
    return await repository.getAirQuality();
  }
}