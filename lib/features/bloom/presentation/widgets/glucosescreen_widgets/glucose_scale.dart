import 'package:flutter/material.dart';
import 'package:bloom_health_app/core/theme/app_colors.dart';


class GlucoseScaleWidget extends StatelessWidget {
  final double glucoseValue;
  final double height;
  final double Function(double) calculateIndicatorTop;

  const GlucoseScaleWidget({
    super.key,
    required this.glucoseValue,
    required this.height,
    required this.calculateIndicatorTop,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                // Glucose Value (updated with Figma layout)
                IntrinsicWidth(
                // SizedBox(
                //   width: 80,
                //   height: 39,
                  child: FittedBox( // scales down if number is too big
                    fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        glucoseValue.toStringAsFixed(0),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textBlack,// SemiBold
                        ),
                      ),
                  ),
                ),
                // Glucose Unit (Figma spec)
                SizedBox(
                  width: 63,
                  height: 20,
                  child: Text(
                    "mg/dL",
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                        color: AppColors.textBlack,// makes line-height consistent
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: 42,
                  height: 360,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.red, Colors.orange, Colors.green],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                Positioned(
                  top: calculateIndicatorTop(glucoseValue),
                  child: Container(
                    width: 42,
                    height: 3,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

}





//Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Column(
//               children: [
//                 Text(
//                   glucoseValue.toStringAsFixed(0),
//                   style: const TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const Text(
//                   "mg/dL",
//                   style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 8),
//             Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 Container(
//                   width: 40,
//                   height: height,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [Colors.red, Colors.orange, Colors.green],
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(8)),
//                   ),
//                 ),
//                 Positioned(
//                   top: calculateIndicatorTop(glucoseValue),
//                   child: Container(
//                     width: 40,
//                     height: 2,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }