import 'package:flutter/material.dart';

class FlourishGreeting extends StatelessWidget {
  const FlourishGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Scale font size based on width (or height) available
        final width = constraints.maxWidth;


        final double headlineBaseSize = (theme.textTheme.headlineMedium?.fontSize ?? 24) * 0.85;
        final double bodyBaseSize = (theme.textTheme.bodyMedium?.fontSize ?? 14) * 0.85;


        // Scale factors, adjust max/min as per your preference
        final double scaleFactor = (width / 350).clamp(0.8, 1.2);

        final double headlineFontSize = headlineBaseSize * scaleFactor;
        final double bodyFontSize = bodyBaseSize * scaleFactor;

        // Scale spacing proportional to scaleFactor
        final double spacing = 8 * scaleFactor;

        return Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Absolutely flourishing, John!',
                style: theme.textTheme.headlineMedium?.copyWith(fontSize: headlineFontSize),
              ),
              SizedBox(height: spacing),
              Text(
                'You are absolutely thriving in every way.',
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: bodyFontSize),
              ),
            ],
          ),
        );
      },
    );
  }
}
