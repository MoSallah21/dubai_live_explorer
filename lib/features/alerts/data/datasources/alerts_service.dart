// features/alerts/data/datasources/alerts_service.dart

import 'package:uuid/uuid.dart';
import '../../../air_quality/domain/entities/air_entity.dart';
import '../../../traffic/domain/entities/traffic_entity.dart';
import '../../../weather/domain/entities/weather_entity.dart';
import '../../domain/entities/alert_entity.dart';

class AlertsService {
  // Configurable thresholds
  static const double highPM25Threshold = 75.0;
  static const double moderatePM25Threshold = 35.4;
  static const double highPM10Threshold = 150.0;
  static const double moderatePM10Threshold = 55.0;
  static const int highAQIThreshold = 150;
  static const int moderateAQIThreshold = 100;

  static const double highTempThreshold = 40.0;
  static const double veryHighTempThreshold = 45.0;
  static const double lowTempThreshold = 5.0;
  static const double veryLowTempThreshold = 0.0;
  static const double highWindSpeedThreshold = 50.0;
  static const double moderateWindSpeedThreshold = 30.0;

  static const double highTrafficSpeedThreshold = 20.0;
  static const double lowTrafficSpeedThreshold = 40.0;

  final _uuid = const Uuid();

  List<AlertEntity> processAlerts({
    required WeatherEntity weather,
    required AirEntity air,
    required TrafficEntity traffic,
  }) {
    final alerts = <AlertEntity>[];
    final now = DateTime.now();

    // Process air quality alerts
    alerts.addAll(_generateAirQualityAlerts(air, now));

    // Process weather alerts
    alerts.addAll(_generateWeatherAlerts(weather, now));

    // Process traffic alerts
    alerts.addAll(_generateTrafficAlerts(traffic, now));

    return alerts;
  }

  List<AlertEntity> _generateAirQualityAlerts(AirEntity air, DateTime now) {
    final alerts = <AlertEntity>[];
    final pm25 = air.pm25 ?? 0.0;
    final pm10 = air.pm10 ?? 0.0;
    final aqi = air.aqi ?? 0;

    // PM2.5 alerts
    if (pm25 >= highPM25Threshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'High PM2.5 Detected',
        message:
        'PM2.5 level is ${pm25.toStringAsFixed(1)} µg/m³ in ${air.locationName}. Avoid outdoor exercise and consider staying indoors. Use air purifiers if available.',
        severity: 'high',
        timestamp: now,
        source: 'air',
      ));
    } else if (pm25 >= moderatePM25Threshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Moderate PM2.5 Level',
        message:
        'PM2.5 level is ${pm25.toStringAsFixed(1)} µg/m³ in ${air.locationName}. Sensitive individuals should limit prolonged outdoor activities.',
        severity: 'medium',
        timestamp: now,
        source: 'air',
      ));
    }

    // PM10 alerts
    if (pm10 >= highPM10Threshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'High PM10 Detected',
        message:
        'PM10 level is ${pm10.toStringAsFixed(1)} µg/m³ in ${air.locationName}. Poor air quality conditions present. Reduce outdoor exposure.',
        severity: 'high',
        timestamp: now,
        source: 'air',
      ));
    } else if (pm10 >= moderatePM10Threshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Moderate PM10 Level',
        message:
        'PM10 level is ${pm10.toStringAsFixed(1)} µg/m³ in ${air.locationName}. Air quality is acceptable for most, but sensitive groups should be cautious.',
        severity: 'medium',
        timestamp: now,
        source: 'air',
      ));
    }

    // AQI alerts
    if (aqi >= highAQIThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Unhealthy Air Quality',
        message:
        'Air Quality Index is $aqi in ${air.locationName}. Everyone should avoid prolonged outdoor exertion. Health effects may begin.',
        severity: 'high',
        timestamp: now,
        source: 'air',
      ));
    } else if (aqi >= moderateAQIThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Moderate Air Quality',
        message:
        'Air Quality Index is $aqi in ${air.locationName}. Air quality is acceptable but may pose a concern for sensitive individuals.',
        severity: 'medium',
        timestamp: now,
        source: 'air',
      ));
    }

    return alerts;
  }

  List<AlertEntity> _generateWeatherAlerts(WeatherEntity weather, DateTime now) {
    final alerts = <AlertEntity>[];
    final temp = weather.currentTemperature;
    final windSpeed = weather.windSpeed;
    final humidity = weather.humidity;

    // Temperature alerts
    if (temp >= veryHighTempThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Extreme Heat Warning',
        message:
        'Temperature has reached ${temp.toStringAsFixed(1)}°C in ${weather.locationName}. Extreme heat conditions! Avoid all outdoor activities. Stay hydrated and in air-conditioned spaces.',
        severity: 'high',
        timestamp: now,
        source: 'weather',
      ));
    } else if (temp >= highTempThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Heat Advisory',
        message:
        'Temperature exceeded ${temp.toStringAsFixed(1)}°C in ${weather.locationName}. Heat warning in effect. Limit outdoor exposure during peak hours and stay hydrated.',
        severity: 'high',
        timestamp: now,
        source: 'weather',
      ));
    }

    // Cold temperature alerts
    if (temp <= veryLowTempThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Freezing Temperature Alert',
        message:
        'Temperature has dropped to ${temp.toStringAsFixed(1)}°C in ${weather.locationName}. Freezing conditions present. Dress warmly and be cautious of ice.',
        severity: 'high',
        timestamp: now,
        source: 'weather',
      ));
    } else if (temp <= lowTempThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Cold Weather Advisory',
        message:
        'Temperature is ${temp.toStringAsFixed(1)}°C in ${weather.locationName}. Cold conditions present. Dress appropriately for outdoor activities.',
        severity: 'medium',
        timestamp: now,
        source: 'weather',
      ));
    }

    // Wind speed alerts
    if (windSpeed >= highWindSpeedThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'High Wind Warning',
        message:
        'Wind speed is ${windSpeed.toStringAsFixed(1)} km/h in ${weather.locationName}. Strong winds present. Secure loose objects and avoid outdoor activities.',
        severity: 'high',
        timestamp: now,
        source: 'weather',
      ));
    } else if (windSpeed >= moderateWindSpeedThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Windy Conditions',
        message:
        'Wind speed is ${windSpeed.toStringAsFixed(1)} km/h in ${weather.locationName}. Moderate winds expected. Be cautious with outdoor activities.',
        severity: 'medium',
        timestamp: now,
        source: 'weather',
      ));
    }

    // Combined heat and humidity alert
    if (temp >= 35.0 && humidity >= 70.0) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'High Heat Index',
        message:
        'Combination of high temperature (${temp.toStringAsFixed(1)}°C) and humidity (${humidity.toStringAsFixed(0)}%) creates uncomfortable conditions. Heat stress risk elevated.',
        severity: 'high',
        timestamp: now,
        source: 'weather',
      ));
    }

    return alerts;
  }

  List<AlertEntity> _generateTrafficAlerts(
      TrafficEntity traffic, DateTime now) {
    final alerts = <AlertEntity>[];
    final speed = traffic.speedAverage;
    final congestion = traffic.congestion.toLowerCase();

    // Severe traffic congestion
    if (speed <= highTrafficSpeedThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Severe Traffic Congestion',
        message:
        'Average speed on ${traffic.roadName} is only ${speed.toStringAsFixed(1)} km/h. Heavy traffic congestion detected. Consider alternative routes or delay travel.',
        severity: 'high',
        timestamp: now,
        source: 'traffic',
      ));
    } else if (speed <= lowTrafficSpeedThreshold) {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'Traffic Congestion',
        message:
        'Average speed on ${traffic.roadName} is ${speed.toStringAsFixed(1)} km/h. Moderate traffic congestion present. Expect delays.',
        severity: 'medium',
        timestamp: now,
        source: 'traffic',
      ));
    }

    // Congestion level-based alerts
    if (congestion == 'high') {
      alerts.add(AlertEntity(
        id: _uuid.v4(),
        title: 'High Traffic Volume',
        message:
        'Traffic congestion on ${traffic.roadName} is above normal levels. Consider using public transportation or alternative routes.',
        severity: 'medium',
        timestamp: now,
        source: 'traffic',
      ));
    }

    return alerts;
  }
}