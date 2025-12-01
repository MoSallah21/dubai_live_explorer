import '../entities/air_entity.dart';

abstract class AirRepository {
  Future<AirEntity> getAirQuality();
}