// lib/feature/bloom_dashboard/domain/entities/glucose_data.dart

class GlucoseData {
  final int id;
  final DateTime timestamp;
  final double value;

  GlucoseData({required this.id, required this.timestamp, required this.value});
}
