import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bloom_health_app/core/theme/app_colors.dart';


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
        final iconSize = 20.0 * scaleFactor;
        final arrowIconSize = 26.0 * scaleFactor;
        final spacingWidth = 16.0 * scaleFactor;

        // Helper to build a tinted SVG with given size
        Widget svgIcon(String asset, double size) {
          return SvgPicture.asset(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            // Optional: show nothing while loading
            placeholderBuilder: (_) => SizedBox(width: size, height: size),
          );
        }

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
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(20 * scaleFactor),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                svgIcon('assets/images/icons/notification_3_line.svg', iconSize),

                SizedBox(width: spacingWidth),
                Expanded(
                  child: Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontSize: scaledFontSize,
                      height: 1,
                    ),
                  ),
                ),
                SizedBox(width: spacingWidth),
                svgIcon('assets/images/icons/arrow_drop_right_line.svg', arrowIconSize),
              ],
            ),
          ),
        );
      },
    );
  }
}
