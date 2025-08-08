import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  final String message;
  final VoidCallback? onTap;

  const ReminderCard({super.key, required this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use the available width to scale text sizes and paddings
        final width = constraints.maxWidth;

        // Base font size from theme
        final baseFontSize = theme.textTheme.bodyMedium?.fontSize ?? 14;

        // Scale factor between 0.85 and 1.2 for font size and spacing
        final scaleFactor = (width / 300).clamp(0.85, 1.2);

        // Scaled font size and paddings
        final scaledFontSize = baseFontSize * scaleFactor;
        final horizontalPadding = 16.0 * scaleFactor;
        final verticalPadding = 20.0 * scaleFactor;
        final iconSize = 24.0 * scaleFactor;
        final arrowIconSize = 16.0 * scaleFactor;
        final spacingWidth = 16.0 * scaleFactor;

        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20 * scaleFactor),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.secondary,
              borderRadius: BorderRadius.circular(20 * scaleFactor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                  size: iconSize,
                ),
                SizedBox(width: spacingWidth),
                Expanded(
                  child: Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: scaledFontSize,
                      height: 1.3, // line height for readability
                    ),
                  ),
                ),
                SizedBox(width: spacingWidth),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: arrowIconSize,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
