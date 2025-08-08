import 'package:flutter/material.dart';

class HealthScoreCircle extends StatelessWidget {
  final int? score;

  const HealthScoreCircle({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // The size of the circle will be the smallest dimension (width or height)
        final double size = constraints.biggest.shortestSide;

        // Calculate font sizes relative to the circle size
        final double scoreFontSize = size * 0.4; // 40% of circle size
        final double slashFontSize = size * 0.15; // 15% of circle size

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: theme.cardColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.3),
                blurRadius: size * 0.25,  // scale blur based on size
                spreadRadius: size * 0.06,
              ),
            ],
          ),
          child: score != null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$score',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: scoreFontSize,
                ),
              ),
              Text(
                '/10',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontSize: slashFontSize,
                ),
              ),
            ],
          )
              : const SizedBox.shrink(),
        );
      },
    );
  }
}
