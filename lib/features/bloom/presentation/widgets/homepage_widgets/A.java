// Center scoreboard
Positioned(
  left: halfSide - 35, // 70 / 2 = 35
  top: halfSide - 35,
  child: SizedBox(
    width: 70,
    height: 70,
    child: HealthScoreCircle(
      score: _rotationAnim.isCompleted
          ? (5 * _fillAnim.value).round()
          : null,
    ),
  ),
),
