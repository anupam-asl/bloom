import 'package:flutter/material.dart';
import 'glucose_data_map.dart';

class MarkerScaleWidget extends StatelessWidget {
  final double height;
  final List<HealthMarker> markers;

  const MarkerScaleWidget({
    super.key,
    required this.height,
    required this.markers,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22, // updated width from Figma
      height: 360, // updated height from Figma
      child: Stack(
        children: [
          // Vertical border line
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 1, // border thickness
              height: 360,
              color: const Color(0xFF6B4EFF), // border color from Figma
            ),
          ),

          // Bubbles / markers
          ...markers.map((marker) {
            return Positioned(
              top: marker.positionPercent * 360 - (marker.size / 2),
              left: (22 - marker.size) / 2, // center horizontally in 22px width
              child: Container(
                width: marker.size,
                height: marker.size,
                decoration: BoxDecoration(
                  color: marker.background,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: marker.background.withValues(alpha: 0.5),
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

}





//Widget build(BuildContext context) {
//     return SizedBox(
//       width: 40,
//       height: height,
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               width: 2,
//               height: height,
//               color: Colors.black,
//             ),
//           ),
//           // Bubbles
//           ...markers.map((marker) {
//             return Positioned(
//               top: marker.positionPercent * height - (marker.size / 2), // center vertically
//               left: (40 - marker.size) / 2, // center horizontally
//               child: Container(
//                 width: marker.size,
//                 height: marker.size,
//                 decoration: BoxDecoration(
//                   color: marker.background,
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: marker.background.withValues(alpha: 0.5),
//                       blurRadius: 6,
//                       spreadRadius: 1,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }