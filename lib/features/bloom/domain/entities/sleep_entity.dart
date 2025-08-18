class SleepEntity {
  final String? dateTime;
  final String sleepState; // e.g., "asleep", "awake"
  final int heartRate;

  SleepEntity({
    // required this.dateTime,
    this.dateTime,
    required this.sleepState,
    required this.heartRate,
  });
}

