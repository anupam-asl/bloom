import 'package:flutter/material.dart';
import '../../viewmodels/bloom_dashboard_vm.dart';
import 'dart:math';

import 'HealthScoreCircle.dart';
import 'package:flutter_svg/flutter_svg.dart';


class HomepagePetalChart extends StatefulWidget {
  final BloomDashboardViewModel viewModel;
  final VoidCallback? onAnimationComplete; // <-- Add this

  const HomepagePetalChart({
    super.key,
    required this.viewModel,
    this.onAnimationComplete,
  });

  @override
  State<HomepagePetalChart> createState() => _HomepagePetalChartState();
}


class _HomepagePetalChartState extends State<HomepagePetalChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotationAnim;
  late final Animation<double> _fillAnim;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _rotationAnim = Tween<double>(
      begin: pi / 8,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _fillAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    //  Call the callback when the animation finishes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed &&
          widget.onAnimationComplete != null) {
        widget.onAnimationComplete!();
      }
    });

    _controller.forward();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final minSide = size.shortestSide * 0.85;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.rotate(
          angle: _rotationAnim.value,
          child: SizedBox(
            width: minSide,
            height: minSide,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Base petals (all 4)
                for (int i = 0; i < 4; i++)
                  Transform.rotate(
                    angle: (pi / 2) * i + (pi / 2), // rotates each petal 90° more
                    child: SvgPicture.asset(
                      'assets/score_morning.svg',
                      width: minSide * 0.85,
                    ),
                  ),


                // ONLY ONE filled petal in top-right quadrant
                // Only one filled petal in top-right quadrant (Activities)
                // Properly positioned filled petal in top-right quadrant
                Positioned(
                  top: minSide * 0.01,
                  right: minSide * 0.0001,
                  child: Transform.rotate(
                    angle: 0, // No rotation needed, it matches background petal
                    child: Transform.scale(
                      scale: _fillAnim.value.clamp(0.5, 0.7),
                      child: SvgPicture.asset(
                        'assets/Frame212.svg',
                        width: minSide * 0.65,
                      ),
                    ),
                  ),
                ),




                // Health Score in center
                SizedBox(
                  width: 70,
                  height: 70,
                  child: HealthScoreCircle(
                    score: _rotationAnim.isCompleted
                        ? (5 * _fillAnim.value).round()
                        : null,
                  ),
                ),
              ],

            ),
          ),
        );
      },
    );
  }

}