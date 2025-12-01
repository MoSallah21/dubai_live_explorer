// features/traffic/presentation/providers/traffic_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/traffic_api_service.dart';
import '../../data/repositories/traffic_repo_impl.dart';
import '../../domain/entities/traffic_entity.dart';
import '../../domain/repositories/traffic_repository.dart';
import '../../domain/usecases/get_live_traffic.dart';

// HTTP Client Provider
final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});

// API Service Provider
final trafficApiServiceProvider = Provider<TrafficApiService>((ref) {
  final client = ref.watch(httpClientProvider);
  return TrafficApiService(client: client);
});

// Repository Provider
final trafficRepositoryProvider = Provider<TrafficRepository>((ref) {
  final apiService = ref.watch(trafficApiServiceProvider);
  return TrafficRepoImpl(apiService: apiService);
});

// UseCase Provider
final getLiveTrafficUseCaseProvider = Provider<GetLiveTraffic>((ref) {
  final repository = ref.watch(trafficRepositoryProvider);
  return GetLiveTraffic(repository: repository);
});

// Traffic Data Provider (FutureProvider)
final trafficProvider = FutureProvider<TrafficEntity>((ref) async {
  final useCase = ref.watch(getLiveTrafficUseCaseProvider);
  return await useCase.call();
});