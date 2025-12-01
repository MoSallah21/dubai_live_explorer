// features/weather/data/datasources/weather_api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherApiService {
  final http.Client client;
  static const String baseUrl = 'https://api.open-meteo.com/v1';

  WeatherApiService({required this.client});

  Future<WeatherModel> fetchWeather({
    double latitude = 25.2048,
    double longitude = 55.2708,
  }) async {
    try {
      // Build query parameters for Open-Meteo API
      final queryParams = {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': 'temperature_2m,relative_humidity_2m,wind_speed_10m',
        'hourly': 'temperature_2m',
        'daily': 'temperature_2m_max,temperature_2m_min',
        'timezone': 'auto',
        'forecast_days': '7',
      };

      final uri = Uri.parse('$baseUrl/forecast').replace(
        queryParameters: queryParams,
      );

      final response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return WeatherModel.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load weather data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }

  // Method to fetch weather for specific location
  Future<WeatherModel> fetchWeatherForLocation({
    required String locationName,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final model = await fetchWeather(
        latitude: latitude,
        longitude: longitude,
      );

      // Return model with updated location name
      return WeatherModel(
        currentTemperature: model.currentTemperature,
        humidity: model.humidity,
        windSpeed: model.windSpeed,
        hourlyForecast: model.hourlyForecast,
        dailyForecast: model.dailyForecast,
        timestamp: model.timestamp,
        locationName: locationName,
      );
    } catch (e) {
      throw Exception('Error fetching weather for location: $e');
    }
  }
}