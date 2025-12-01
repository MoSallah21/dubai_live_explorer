import '../../domain/entities/air_entity.dart';

class AirQualityModel extends AirEntity {
  const AirQualityModel({
    required super.pm25,
    required super.pm10,
    required super.aqi,
    required super.timestamp,
    required super.locationName,
    super.unit,
  });

  factory AirQualityModel.fromJson(Map<String, dynamic> json) {
    final measurements = json['measurements'] as List<dynamic>? ?? [];

    double? pm25Value;
    double? pm10Value;
    String? unit;

    for (var measurement in measurements) {
      final parameter = measurement['parameter'] as String?;
      final value = measurement['value'] as num?;
      final measurementUnit = measurement['unit'] as String?;

      if (parameter == 'pm25' && value != null) {
        pm25Value = value.toDouble();
        unit = measurementUnit;
      } else if (parameter == 'pm10' && value != null) {
        pm10Value = value.toDouble();
        unit = measurementUnit;
      }
    }

    // Calculate basic AQI from PM2.5 (simplified calculation)
    int? aqiValue;
    if (pm25Value != null) {
      if (pm25Value <= 12.0) {
        aqiValue = ((50 - 0) / (12.0 - 0.0) * (pm25Value - 0.0) + 0).round();
      } else if (pm25Value <= 35.4) {
        aqiValue = ((100 - 51) / (35.4 - 12.1) * (pm25Value - 12.1) + 51).round();
      } else if (pm25Value <= 55.4) {
        aqiValue = ((150 - 101) / (55.4 - 35.5) * (pm25Value - 35.5) + 101).round();
      } else if (pm25Value <= 150.4) {
        aqiValue = ((200 - 151) / (150.4 - 55.5) * (pm25Value - 55.5) + 151).round();
      } else if (pm25Value <= 250.4) {
        aqiValue = ((300 - 201) / (250.4 - 150.5) * (pm25Value - 150.5) + 201).round();
      } else {
        aqiValue = ((500 - 301) / (500.4 - 250.5) * (pm25Value - 250.5) + 301).round();
      }
    }

    final location = json['location'] as String? ?? 'Unknown';
    final coordinates = json['coordinates'] as Map<String, dynamic>?;
    final locationName = coordinates?['label'] as String? ?? location;

    String? lastUpdated = json['lastUpdated'] as String?;
    DateTime timestamp;

    if (lastUpdated != null) {
      try {
        timestamp = DateTime.parse(lastUpdated);
      } catch (e) {
        timestamp = DateTime.now();
      }
    } else {
      timestamp = DateTime.now();
    }

    return AirQualityModel(
      pm25: pm25Value,
      pm10: pm10Value,
      aqi: aqiValue,
      timestamp: timestamp,
      locationName: locationName,
      unit: unit,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pm25': pm25,
      'pm10': pm10,
      'aqi': aqi,
      'timestamp': timestamp.toIso8601String(),
      'locationName': locationName,
      'unit': unit,
    };
  }
}