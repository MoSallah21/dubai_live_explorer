// features/insights/domain/entities/insights_entity.dart

class InsightsEntity {
  final String bestTimeToGoOut;
  final String airQualityHint;
  final String trafficHint;
  final String temperatureHint;
  final String combinedSummary;
  final int comfortScore;
  final DateTime generatedAt;

  const InsightsEntity({
    required this.bestTimeToGoOut,
    required this.airQualityHint,
    required this.trafficHint,
    required this.temperatureHint,
    required this.combinedSummary,
    required this.comfortScore,
    required this.generatedAt,
  });
}