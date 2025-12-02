// features/alerts/domain/entities/alert_entity.dart

class AlertEntity {
  final String id;
  final String title;
  final String message;
  final String severity;
  final DateTime timestamp;
  final String source;

  const AlertEntity({
    required this.id,
    required this.title,
    required this.message,
    required this.severity,
    required this.timestamp,
    required this.source,
  });
}