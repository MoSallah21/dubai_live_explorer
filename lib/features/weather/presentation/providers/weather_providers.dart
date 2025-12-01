// features/weather/presentation/providers/weather_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/weather_api_service.dart';
import '../../data/repositories/weather_repo_impl.dart';
import '../../domain/entities/weather_entity.dart';
import '../../domain/repositories/weather_repository.dart';
import '../../domain/usecases/get_weather.dart';

// HTTP Client Provider
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

// API Service Provider
final weatherApiServiceProvider = Provider<WeatherApiService>((ref) {
  final client = ref.watch(httpClientProvider);
  return WeatherApiService(client: client);
});

// Repository Provider
final weatherRepoProvider = Provider<WeatherRepository>((ref) {
  final apiService = ref.watch(weatherApiServiceProvider);
  return WeatherRepoImpl(apiService: apiService);
});

// UseCase Provider
final getWeatherUseCaseProvider = Provider<GetWeather>((ref) {
  final repository = ref.watch(weatherRepoProvider);
  return GetWeather(repository: repository);
});

// Weather Data Provider (FutureProvider)
final weatherProvider = FutureProvider<WeatherEntity>((ref) async {
  final useCase = ref.watch(getWeatherUseCaseProvider);
  return await useCase.call();
});