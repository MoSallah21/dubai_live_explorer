
import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.currentTemperature,
    required super.humidity,
    required super.windSpeed,
    required super.hourlyForecast,
    required super.dailyForecast,
    required super.timestamp,
    required super.locationName,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    // Parse current weather data
    final current = json['current'] as Map<String, dynamic>? ?? {};
    final currentTemp = (current['temperature_2m'] ?? 0.0) as num;
    final currentHumidity = (current['relative_humidity_2m'] ?? 0.0) as num;
    final currentWindSpeed = (current['wind_speed_10m'] ?? 0.0) as num;

    // Parse hourly forecast
    final hourly = json['hourly'] as Map<String, dynamic>? ?? {};
    final hourlyTimes = hourly['time'] as List<dynamic>? ?? [];
    final hourlyTemps = hourly['temperature_2m'] as List<dynamic>? ?? [];

    List<HourlyForecastModel> hourlyForecastList = [];
    final now = DateTime.now();

    for (int i = 0; i < hourlyTimes.length && i < 24; i++) {
      try {
        final time = DateTime.parse(hourlyTimes[i] as String);
        if (time.isAfter(now)) {
          final temp = (hourlyTemps[i] ?? 0.0) as num;
          hourlyForecastList.add(
            HourlyForecastModel(
              time: time,
              temperature: temp.toDouble(),
            ),
          );
        }
      } catch (e) {
        continue;
      }
    }

    // Parse daily forecast
    final daily = json['daily'] as Map<String, dynamic>? ?? {};
    final dailyDates = daily['time'] as List<dynamic>? ?? [];
    final dailyMaxTemps = daily['temperature_2m_max'] as List<dynamic>? ?? [];
    final dailyMinTemps = daily['temperature_2m_min'] as List<dynamic>? ?? [];

    List<DailyForecastModel> dailyForecastList = [];

    for (int i = 0; i < dailyDates.length && i < 7; i++) {
      try {
        final date = DateTime.parse(dailyDates[i] as String);
        final maxTemp = (dailyMaxTemps[i] ?? 0.0) as num;
        final minTemp = (dailyMinTemps[i] ?? 0.0) as num;

        dailyForecastList.add(
          DailyForecastModel(
            date: date,
            maxTemperature: maxTemp.toDouble(),
            minTemperature: minTemp.toDouble(),
          ),
        );
      } catch (e) {
        continue;
      }
    }

    // Get timestamp
    DateTime timestamp;
    try {
      final currentTime = current['time'] as String?;
      timestamp = currentTime != null
          ? DateTime.parse(currentTime)
          : DateTime.now();
    } catch (e) {
      timestamp = DateTime.now();
    }

    return WeatherModel(
      currentTemperature: currentTemp.toDouble(),
      humidity: currentHumidity.toDouble(),
      windSpeed: currentWindSpeed.toDouble(),
      hourlyForecast: hourlyForecastList,
      dailyForecast: dailyForecastList,
      timestamp: timestamp,
      locationName: 'Dubai, UAE', // Can be passed as parameter
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': {
        'temperature_2m': currentTemperature,
        'relative_humidity_2m': humidity,
        'wind_speed_10m': windSpeed,
        'time': timestamp.toIso8601String(),
      },
      'hourly': {
        'time': hourlyForecast.map((h) => h.time.toIso8601String()).toList(),
        'temperature_2m': hourlyForecast.map((h) => h.temperature).toList(),
      },
      'daily': {
        'time': dailyForecast.map((d) => d.date.toIso8601String()).toList(),
        'temperature_2m_max': dailyForecast.map((d) => d.maxTemperature).toList(),
        'temperature_2m_min': dailyForecast.map((d) => d.minTemperature).toList(),
      },
    };
  }
}

class HourlyForecastModel extends HourlyForecast {
  const HourlyForecastModel({
    required super.time,
    required super.temperature,
  });
}

class DailyForecastModel extends DailyForecast {
  const DailyForecastModel({
    required super.date,
    required super.maxTemperature,
    required super.minTemperature,
  });
}