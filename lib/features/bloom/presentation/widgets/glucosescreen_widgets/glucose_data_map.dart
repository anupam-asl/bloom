import 'package:flutter/material.dart';

class HealthMarker {
  final String type;
  final double positionPercent;
  final Color background;
  final double size;

  HealthMarker({
    required this.type,
    required this.background,
    required this.positionPercent,
    this.size = 20.0,
  });
}
class GlucoseData {
  final int glucose;
  final List<HealthMarker> markers;

  GlucoseData(
      {
        required this.glucose,
        required this.markers
      }
      );
}