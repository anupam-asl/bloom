import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        Text(
          getFormattedDate(),
          style: theme.textTheme.bodyMedium,
        ),

        Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent, // no gray circle
              child: SvgPicture.asset(
                'assets/images/icons/ai.svg',
                width: 32.w,
                height: 32.w,
              ),
            ),
            SizedBox(width: 6.w),
            CircleAvatar(
              backgroundColor: Colors.transparent, // no gray circle
              child: SvgPicture.asset(
                'assets/images/icons/account.svg',
                width: 28.w,
                height: 28.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
