import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bloom_health_app/core/theme/app_colors.dart';

class ReminderCard extends StatelessWidget {
  final String message;
  final VoidCallback? onTap;

  const ReminderCard({super.key, required this.message, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final double horizontalPadding = 16.w;
    final double verticalPadding = 20.h;
    final double borderRadius = 20.r;
    final double notificationIconSize = 20.w;
    final double arrowIconSize = 26.w;
    final double spacing = 16.w;

    Widget svgIcon(String asset, double size) {
      return SvgPicture.asset(
        asset,
        width: size,
        height: size,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        placeholderBuilder: (_) => SizedBox(width: size, height: size),
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.purple,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            svgIcon('assets/images/icons/notification_3_line.svg', notificationIconSize),
            SizedBox(width: spacing),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  // fontSize is already responsive via `.sp` in AppTheme
                ),
              ),
            ),
            SizedBox(width: spacing),
            svgIcon('assets/images/icons/arrow_drop_right_line.svg', arrowIconSize),
          ],
        ),
      ),
    );
  }
}
