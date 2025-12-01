// features/weather/domain/usecases/get_weather.dart

import '../entities/weather_entity.dart';
import '../repositories/weather_repository.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather({required this.repository});

  Future<WeatherEntity> call() async {
    return await repository.getWeather();
  }
}