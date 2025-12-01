import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/air_quality_model.dart';

class AirApiService {
  final http.Client client;
  static const String baseUrl = 'https://api.openaq.org/v2';

  AirApiService({required this.client});

  Future<AirQualityModel> fetchAirQuality({String city = 'Dubai'}) async {
    try {
      final uri = Uri.parse('$baseUrl/latest?city=$city&limit=1');

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        final results = jsonData['results'] as List<dynamic>?;

        if (results != null && results.isNotEmpty) {
          final firstResult = results.first as Map<String, dynamic>;
          return AirQualityModel.fromJson(firstResult);
        } else {
          throw Exception('No air quality data available for $city');
        }
      } else {
        throw Exception(
          'Failed to load air quality data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching air quality data: $e');
    }
  }
}