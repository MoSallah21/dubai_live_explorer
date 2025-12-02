// features/insights/data/datasources/insights_service.dart

import '../../../air_quality/domain/entities/air_entity.dart';
import '../../../traffic/domain/entities/traffic_entity.dart';
import '../../../weather/domain/entities/weather_entity.dart';
import '../../domain/entities/insights_entity.dart';

class InsightsService {
  InsightsEntity processInsights({
    required WeatherEntity weather,
    required AirEntity air,
    required TrafficEntity traffic,
  }) {
    // Generate individual insights
    final airQualityHint = _generateAirQualityHint(air);
    final trafficHint = _generateTrafficHint(traffic);
    final temperatureHint = _generateTemperatureHint(weather);
    final bestTimeToGoOut = _generateBestTimeToGoOut(weather, air, traffic);

    // Calculate comfort score (0-100)
    final comfortScore = _calculateComfortScore(weather, air, traffic);

    // Generate combined summary
    final combinedSummary = _generateCombinedSummary(
      weather,
      air,
      traffic,
      comfortScore,
    );

    return InsightsEntity(
      bestTimeToGoOut: bestTimeToGoOut,
      airQualityHint: airQualityHint,
      trafficHint: trafficHint,
      temperatureHint: temperatureHint,
      combinedSummary: combinedSummary,
      comfortScore: comfortScore,
      generatedAt: DateTime.now(),
    );
  }

  String _generateAirQualityHint(AirEntity air) {
    final aqi = air.aqi ?? 0;
    final pm25 = air.pm25 ?? 0.0;

    if (aqi <= 50 || pm25 <= 12.0) {
      return 'Air quality is excellent! Perfect for outdoor activities.';
    } else if (aqi <= 100 || pm25 <= 35.4) {
      return 'Air quality is acceptable. Most people can enjoy outdoor activities.';
    } else if (aqi <= 150 || pm25 <= 55.4) {
      return 'Air quality is moderate. Sensitive individuals should limit prolonged outdoor activities.';
    } else if (aqi <= 200 || pm25 <= 150.4) {
      return 'Air quality is unhealthy. Everyone should reduce prolonged outdoor exertion.';
    } else if (aqi <= 300 || pm25 <= 250.4) {
      return 'Air quality is very unhealthy. Avoid outdoor activities if possible.';
    } else {
      return 'Air quality is hazardous! Stay indoors and use air purifiers.';
    }
  }

  String _generateTrafficHint(TrafficEntity traffic) {
    final congestion = traffic.congestion.toLowerCase();
    final speed = traffic.speedAverage;

    if (congestion == 'low' || speed > 60) {
      return 'Traffic is flowing smoothly. Great time for driving!';
    } else if (congestion == 'moderate' || speed > 40) {
      return 'Traffic is moderate. Expect some delays on major roads.';
    } else {
      return 'Traffic is heavy. Consider using public transport or wait for a better time.';
    }
  }

  String _generateTemperatureHint(WeatherEntity weather) {
    final temp = weather.currentTemperature;
    final humidity = weather.humidity;

    if (temp < 10) {
      return 'It\'s quite cold outside. Dress warmly and consider indoor activities.';
    } else if (temp >= 10 && temp < 18) {
      return 'Temperature is cool. A light jacket would be comfortable.';
    } else if (temp >= 18 && temp < 25) {
      return 'Temperature is pleasant! Perfect weather for outdoor activities.';
    } else if (temp >= 25 && temp < 32) {
      if (humidity > 70) {
        return 'It\'s warm and humid. Stay hydrated and seek shade when possible.';
      } else {
        return 'Temperature is warm. Comfortable for most activities with sun protection.';
      }
    } else if (temp >= 32 && temp < 38) {
      return 'It\'s hot outside. Limit outdoor exposure during peak hours and stay hydrated.';
    } else {
      return 'Extreme heat! Avoid outdoor activities and stay in air-conditioned spaces.';
    }
  }

  String _generateBestTimeToGoOut(
      WeatherEntity weather,
      AirEntity air,
      TrafficEntity traffic,
      ) {
    final temp = weather.currentTemperature;
    final aqi = air.aqi ?? 0;
    final congestion = traffic.congestion.toLowerCase();
    final currentHour = DateTime.now().hour;

    // Ideal conditions
    if (temp >= 18 && temp <= 28 && aqi <= 100 && congestion == 'low') {
      return 'Now is an excellent time to go outside! Weather, air quality, and traffic are all favorable.';
    }

    // Good temperature, but other factors not ideal
    if (temp >= 18 && temp <= 28) {
      if (aqi > 100) {
        return 'Temperature is pleasant, but air quality is concerning. Consider indoor activities.';
      }
      if (congestion == 'high') {
        return 'Weather is nice, but traffic is heavy. Good for walking or cycling nearby.';
      }
    }

    // Time-based recommendations
    if (temp > 32) {
      if (currentHour < 10) {
        return 'Best time to go out is early morning (before 10 AM) when it\'s cooler.';
      } else if (currentHour > 18) {
        return 'Evening hours (after 6 PM) are better when temperature drops.';
      } else {
        return 'It\'s very hot now. Wait for evening or early morning for outdoor activities.';
      }
    }

    // Poor air quality
    if (aqi > 150) {
      return 'Air quality is poor. Best to stay indoors or postpone outdoor activities.';
    }

    // Default recommendation
    if (currentHour >= 6 && currentHour < 10) {
      return 'Morning hours are generally good for outdoor activities with less traffic.';
    } else if (currentHour >= 17 && currentHour < 20) {
      return 'Evening is a good time once the heat subsides, though traffic may be moderate.';
    } else {
      return 'Current conditions are acceptable. Use sun protection and stay hydrated.';
    }
  }

  int _calculateComfortScore(
      WeatherEntity weather,
      AirEntity air,
      TrafficEntity traffic,
      ) {
    int score = 100;

    // Temperature scoring (0-30 points deduction)
    final temp = weather.currentTemperature;
    if (temp < 10 || temp > 38) {
      score -= 30;
    } else if (temp < 15 || temp > 35) {
      score -= 20;
    } else if (temp < 18 || temp > 32) {
      score -= 10;
    } else if (temp >= 22 && temp <= 26) {
      // Ideal temperature range - no deduction
    } else {
      score -= 5;
    }

    // Air quality scoring (0-40 points deduction)
    final aqi = air.aqi ?? 0;
    if (aqi > 300) {
      score -= 40;
    } else if (aqi > 200) {
      score -= 30;
    } else if (aqi > 150) {
      score -= 20;
    } else if (aqi > 100) {
      score -= 10;
    } else if (aqi > 50) {
      score -= 5;
    }

    // Traffic scoring (0-20 points deduction)
    final congestion = traffic.congestion.toLowerCase();
    if (congestion == 'high') {
      score -= 20;
    } else if (congestion == 'moderate') {
      score -= 10;
    }

    // Humidity factor (0-10 points deduction)
    final humidity = weather.humidity;
    if (humidity > 80) {
      score -= 10;
    } else if (humidity > 70) {
      score -= 5;
    }

    // Ensure score stays within bounds
    return score.clamp(0, 100);
  }

  String _generateCombinedSummary(
      WeatherEntity weather,
      AirEntity air,
      TrafficEntity traffic,
      int comfortScore,
      ) {
    if (comfortScore >= 80) {
      return 'Excellent conditions overall! All factors are favorable for outdoor activities. Enjoy your day!';
    } else if (comfortScore >= 60) {
      return 'Good conditions with minor concerns. Generally comfortable for most outdoor activities.';
    } else if (comfortScore >= 40) {
      return 'Moderate conditions. Some factors may affect comfort. Plan accordingly and take precautions.';
    } else if (comfortScore >= 20) {
      return 'Challenging conditions. Multiple factors are unfavorable. Consider indoor alternatives.';
    } else {
      return 'Poor conditions across multiple factors. Strongly recommend staying indoors if possible.';
    }
  }
}