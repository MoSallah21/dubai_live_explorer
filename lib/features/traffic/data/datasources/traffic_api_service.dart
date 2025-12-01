// features/traffic/data/datasources/traffic_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/traffic_model.dart';

class TrafficApiService {
  final http.Client client;

  // Using a mock API endpoint for demonstration
  // In production, replace with actual traffic API
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  TrafficApiService({required this.client});

  Future<TrafficModel> fetchLiveTraffic() async {
    try {
      // Simulating API call - in real scenario, use actual traffic data endpoint
      // For demonstration, we'll create a dummy response
      final uri = Uri.parse('$baseUrl/todos/1');

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Since we're using a mock endpoint, create dummy traffic data
        // In production, parse actual API response
        return _createDummyTrafficData();
      } else {
        throw Exception(
          'Failed to load traffic data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // If API fails, return dummy data for demonstration
      // In production, properly handle errors
      return _createDummyTrafficData();
    }
  }

  // Helper method to create realistic dummy traffic data
  TrafficModel _createDummyTrafficData() {
    // Simulate realistic traffic data for Dubai/UAE
    final now = DateTime.now();
    final hour = now.hour;

    // Determine congestion based on time of day
    String congestion;
    double speed;

    if (hour >= 7 && hour <= 9 || hour >= 17 && hour <= 19) {
      // Rush hours
      congestion = 'High';
      speed = 25.0 + (hour % 3) * 5.0; // 25-35 km/h
    } else if (hour >= 10 && hour <= 16) {
      // Mid-day
      congestion = 'Moderate';
      speed = 45.0 + (hour % 4) * 5.0; // 45-60 km/h
    } else {
      // Night time
      congestion = 'Low';
      speed = 65.0 + (hour % 5) * 5.0; // 65-85 km/h
    }

    // Create a dummy JSON structure
    final dummyJson = {
      'congestion_level': congestion,
      'speed_average': speed,
      'timestamp': now.toIso8601String(),
      'road_name': 'Sheikh Zayed Road',
      'coordinates': [
        {'latitude': 25.2048, 'longitude': 55.2708},
        {'latitude': 25.2098, 'longitude': 55.2758},
        {'latitude': 25.2148, 'longitude': 55.2808},
        {'latitude': 25.2198, 'longitude': 55.2858},
        {'latitude': 25.2248, 'longitude': 55.2908},
        {'latitude': 25.2298, 'longitude': 55.2958},
        {'latitude': 25.2348, 'longitude': 55.3008},
      ],
    };

    return TrafficModel.fromJson(dummyJson);
  }

  // Alternative method for real API integration
  Future<TrafficModel> fetchFromRealApi(String apiUrl) async {
    try {
      final uri = Uri.parse(apiUrl);

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          // Add any required API keys or auth headers
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;

        // Handle different API response structures
        if (jsonData.containsKey('data')) {
          final data = jsonData['data'];
          if (data is List && data.isNotEmpty) {
            return TrafficModel.fromJson(data.first as Map<String, dynamic>);
          } else if (data is Map<String, dynamic>) {
            return TrafficModel.fromJson(data);
          }
        }

        return TrafficModel.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load traffic data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching traffic data: $e');
    }
  }
}