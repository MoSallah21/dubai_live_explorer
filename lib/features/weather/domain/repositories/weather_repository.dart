// features/weather/domain/repositories/weather_repository.dart

import '../entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<WeatherEntity> getWeather();
}