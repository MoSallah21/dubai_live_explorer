// features/traffic/domain/entities/traffic_entity.dart

import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficEntity {
  final String congestion;
  final double speedAverage;
  final DateTime timestamp;
  final List<LatLng> coordinates;
  final String roadName;

  const TrafficEntity({
    required this.congestion,
    required this.speedAverage,
    required this.timestamp,
    required this.coordinates,
    required this.roadName,
  });
}