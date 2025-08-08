import 'package:flutter/material.dart';

class FlourishSuggestionCard extends StatelessWidget {
  const FlourishSuggestionCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_active_outlined, color: Colors.white),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'A gentle wind-down sets the stage for cellular repair; begin your evening routine mindfully.',
              style: theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}
