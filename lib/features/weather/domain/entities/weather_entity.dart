// features/weather/domain/entities/weather_entity.dart

class WeatherEntity {
  final double currentTemperature;
  final double humidity;
  final double windSpeed;
  final List<HourlyForecast> hourlyForecast;
  final List<DailyForecast> dailyForecast;
  final DateTime timestamp;
  final String locationName;

  const WeatherEntity({
    required this.currentTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.hourlyForecast,
    required this.dailyForecast,
    required this.timestamp,
    required this.locationName,
  });
}

class HourlyForecast {
  final DateTime time;
  final double temperature;

  const HourlyForecast({
    required this.time,
    required this.temperature,
  });
}

class DailyForecast {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;

  const DailyForecast({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
  });
}