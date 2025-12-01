class AirEntity {
  final double? pm25;
  final double? pm10;
  final int? aqi;
  final DateTime timestamp;
  final String locationName;
  final String? unit;

  const AirEntity({
    required this.pm25,
    required this.pm10,
    required this.aqi,
    required this.timestamp,
    required this.locationName,
    this.unit,
  });
}