// lib/feature/bloom_dashboard/presentation/viewmodels/bloom_dashboard_vm.dart

import '../constants/petals_constants.dart';

class PetalDisplayData {
  final PetalConfig config;
  final double actualValue;

  PetalDisplayData({
    required this.config,
    required this.actualValue,
  });
}

class BloomDashboardViewModel {
  // Fake values for UI; replace these with real fetched DB values!
  final List<double> metricValues = [7, 3, 9, 6];

  List<PetalDisplayData> get petalDisplayData => List.generate(
    petalConfigs.length,
        (i) => PetalDisplayData(
      config: petalConfigs[i],
      actualValue: metricValues[i],
    ),
  );

  double get healthScore {
    final total = petalDisplayData
        .map((d) => (d.actualValue / d.config.maxValue) * 10)
        .reduce((a, b) => a + b);
    return total / petalDisplayData.length;
  }

  final String userName = "John";
}
