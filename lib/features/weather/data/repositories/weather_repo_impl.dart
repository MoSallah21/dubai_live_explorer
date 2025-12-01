// features/weather/data/repositories/weather_repo_impl.dart

import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_api_service.dart';

class WeatherRepoImpl implements WeatherRepository {
  final WeatherApiService apiService;

  WeatherRepoImpl({required this.apiService});

  @override
  Future<WeatherEntity> getWeather() async {
    try {
      final model = await apiService.fetchWeather();
      return model;
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}