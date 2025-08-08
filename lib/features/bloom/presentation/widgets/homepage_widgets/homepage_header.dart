import 'package:flutter/material.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  String getFormattedDate() {
    final now = DateTime.now();
    // e.g. THURSDAY, JUNE 12
    return "${["SUNDAY", "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY"][now.weekday % 7]}, "
        "${["JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE", "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"][now.month - 1]} "
        "${now.day}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.iconTheme.color!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          getFormattedDate(),
          style: theme.textTheme.bodySmall,
        ),
        Row(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.1),
              child: Icon(Icons.face_retouching_natural, color: iconColor),
            ),
            const SizedBox(width: 12),
            CircleAvatar(
              backgroundColor: theme.colorScheme.secondary,
              radius: 18,
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
