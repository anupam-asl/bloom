// lib/feature/bloom_dashboard/presentation/constants/petals_constants.dart

import 'package:flutter/material.dart';

class PetalConfig {
  final String label;
  final List<Color> gradient;
  final int maxValue;

  const PetalConfig({
    required this.label,
    required this.gradient,
    required this.maxValue,
  });
}

const petalConfigs = [
  PetalConfig(
    label: 'ACTIVITIES',
    gradient: [Color(0xFFC4459F), Color(0xFFE066C7)],

    maxValue: 10,
  ),
  PetalConfig(
    label: 'SLEEP',
    gradient: [Color(0xFF4591C4), Color(0xFF66B3E8)],

    maxValue: 10,
  ),
  PetalConfig(
    label: 'GLUCOSE',
    gradient: [Color(0xFF5B45C4), Color(0xFF8B7DE8)],
    maxValue: 10,
  ),
  PetalConfig(
    label: 'CALORIE',
    gradient: [Color(0xFFE8984E), Color(0xFFFFB366)],
    maxValue: 10,
  ),
];
