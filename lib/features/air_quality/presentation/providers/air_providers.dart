import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/air_api_service.dart';
import '../../data/repositories/air_repo_impl.dart';
import '../../domain/entities/air_entity.dart';
import '../../domain/repositories/air_repository.dart';
import '../../domain/usecases/get_air_quality.dart';

// HTTP Client Provider
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

// API Service Provider
final airApiServiceProvider = Provider<AirApiService>((ref) {
  final client = ref.watch(httpClientProvider);
  return AirApiService(client: client);
});

// Repository Provider
final airRepoProvider = Provider<AirRepository>((ref) {
  final apiService = ref.watch(airApiServiceProvider);
  return AirRepoImpl(apiService: apiService);
});

// UseCase Provider
final getAirQualityUseCaseProvider = Provider<GetAirQuality>((ref) {
  final repository = ref.watch(airRepoProvider);
  return GetAirQuality(repository: repository);
});

// Air Quality Data Provider (FutureProvider)
final airQualityProvider = FutureProvider<AirEntity>((ref) async {
  final useCase = ref.watch(getAirQualityUseCaseProvider);
  return await useCase.call();
});