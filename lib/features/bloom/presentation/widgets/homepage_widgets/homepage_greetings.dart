import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FlourishGreeting extends StatelessWidget {
  const FlourishGreeting({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Absolutely flourishing, Sandip!',
            style: theme.textTheme.titleLarge,
          ),
          SizedBox(height: 8.h), // responsive spacing
          Text(
            'You are absolutely thriving in every way.',
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
