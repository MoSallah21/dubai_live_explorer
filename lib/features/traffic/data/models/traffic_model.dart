// features/traffic/data/models/traffic_model.dart

import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/traffic_entity.dart';

class TrafficModel extends TrafficEntity {
  const TrafficModel({
    required super.congestion,
    required super.speedAverage,
    required super.timestamp,
    required super.coordinates,
    required super.roadName,
  });

  factory TrafficModel.fromJson(Map<String, dynamic> json) {
    // Parse coordinates
    List<LatLng> coords = [];

    if (json['coordinates'] != null) {
      final coordsList = json['coordinates'] as List<dynamic>;
      coords = coordsList.map((coord) {
        if (coord is Map<String, dynamic>) {
          final lat = (coord['latitude'] ?? coord['lat'] ?? 0.0) as num;
          final lng = (coord['longitude'] ?? coord['lng'] ?? 0.0) as num;
          return LatLng(lat.toDouble(), lng.toDouble());
        } else if (coord is List) {
          // Handle [lat, lng] format
          final lat = (coord[0] ?? 0.0) as num;
          final lng = (coord[1] ?? 0.0) as num;
          return LatLng(lat.toDouble(), lng.toDouble());
        }
        return const LatLng(0.0, 0.0);
      }).toList();
    }

    // Parse timestamp
    DateTime timestamp;
    try {
      final timestampStr = json['timestamp'] as String?;
      if (timestampStr != null) {
        timestamp = DateTime.parse(timestampStr);
      } else {
        timestamp = DateTime.now();
      }
    } catch (e) {
      timestamp = DateTime.now();
    }

    // Parse congestion level
    String congestion = json['congestion_level'] ??
        json['congestion'] ??
        json['status'] ??
        'Unknown';

    // Parse speed
    double speed = 0.0;
    final speedValue = json['speed_average'] ??
        json['average_speed'] ??
        json['speed'] ??
        0;

    if (speedValue is num) {
      speed = speedValue.toDouble();
    } else if (speedValue is String) {
      speed = double.tryParse(speedValue) ?? 0.0;
    }

    // Parse road name
    String roadName = json['road_name'] ??
        json['street_name'] ??
        json['name'] ??
        'Unknown Road';

    return TrafficModel(
      congestion: congestion,
      speedAverage: speed,
      timestamp: timestamp,
      coordinates: coords,
      roadName: roadName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'congestion_level': congestion,
      'speed_average': speedAverage,
      'timestamp': timestamp.toIso8601String(),
      'coordinates': coordinates.map((coord) {
        return {
          'latitude': coord.latitude,
          'longitude': coord.longitude,
        };
      }).toList(),
      'road_name': roadName,
    };
  }

  // Factory for creating mock/dummy data
  factory TrafficModel.dummy() {
    return TrafficModel(
      congestion: 'High',
      speedAverage: 35.5,
      timestamp: DateTime.now(),
      coordinates: [
        const LatLng(25.2048, 55.2708), // Dubai coordinates
        const LatLng(25.2148, 55.2808),
        const LatLng(25.2248, 55.2908),
        const LatLng(25.2348, 55.3008),
      ],
      roadName: 'Sheikh Zayed Road',
    );
  }
}