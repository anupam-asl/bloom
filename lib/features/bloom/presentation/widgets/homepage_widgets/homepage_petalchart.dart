import 'package:bloom_health_app/features/bloom/presentation/viewmodels/activity_provider.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/food_providers.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '../../viewmodels/sleep_provider.dart';
import 'HealthScoreCircle.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/glucose_providers.dart';

//  Add this at top-level (NOT inside a class/method)
enum PetalQuadrant { bottomLeft, topLeft, bottomRight, topRight }

class HomepagePetalChart extends ConsumerStatefulWidget {
  final VoidCallback? onAnimationComplete;
  const HomepagePetalChart({super.key, this.onAnimationComplete});

  @override
  ConsumerState<HomepagePetalChart> createState() => _HomepagePetalChartState();
}

class _HomepagePetalChartState extends ConsumerState<HomepagePetalChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotationAnim;
  late final Animation<double> _fillAnim;

  double _lastGlucosePerc = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _rotationAnim = Tween<double>(
      begin: pi / 9,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _fillAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final glucoseState = ref.watch(glucoseViewModelProvider);
    final sleepState   = ref.watch(sleepViewModelProvider);
    final calorieState = ref.watch(foodViewModelProvider);
    final activityState= ref.watch(activityViewModelProvider);

    double glucoseValue = 0;
    double sleepValue   = 0;
    double calorieValue = 0;
    double activityValue= 0;

    glucoseState.when(
      data: (entries) {
        if (entries.isNotEmpty) glucoseValue = entries.last.valueMgDl.toDouble();
      },
      loading: () {},
      error: (_, __) {},
    );

    sleepState.when(
      data: (entries) {
        if (entries.isNotEmpty) {
          sleepValue = entries.last.heartRate.toDouble();
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    calorieState.when(
      data: (entries) {
        if (entries.isNotEmpty) calorieValue = entries.last.calorie.toDouble();
      },
      loading: () {},
      error: (_, __) {},
    );

    activityState.when(
      data: (entries) {
        if (entries.isNotEmpty) activityValue = entries.last.exerciseMin.toDouble();
      },
      loading: () {},
      error: (_, __) {},
    );

    const minGlucose = 10.0,  maxGlucose = 100.0;
    const minSleep   = 60.0,  maxSleep   = 120.0;
    const minCalories= 100.0, maxCalories= 500.0;
    const minActivity= 5.0,   maxActivity= 100.0;

    final glucosePerc = ((glucoseValue  - minGlucose ) / (maxGlucose  - minGlucose )).clamp(0.0, 1.0);
    final sleepPerc   = ((sleepValue    - minSleep   ) / (maxSleep    - minSleep   )).clamp(0.0, 1.0);
    final caloriePerc = ((calorieValue  - minCalories) / (maxCalories - minCalories)).clamp(0.0, 1.0);
    final activityPerc= ((activityValue - minActivity) / (maxActivity - minActivity)).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final size     = MediaQuery.of(context).size;
        final minSide  = size.shortestSide * 0.85;
        final halfSide = minSide / 2;

        return Transform.rotate(
          angle: _rotationAnim.value,
          child: SizedBox(
            width: minSide,
            height: minSide,
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/images/petals/score_petals_bg.svg',
                    width: minSide,
                  ),
                ),

                // Calories (top right)
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: caloriePerc),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, _) => _buildPetal(
                    halfSide: halfSide,
                    percValue: value,
                    assetPath: 'assets/images/petals/calories_orange_fg.svg',
                    quadrant: PetalQuadrant.bottomLeft,
                    align: Alignment.bottomLeft,
                  ),
                ),

                // Activity (bottom right)
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: activityPerc),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, _) => _buildPetal(
                    halfSide: halfSide,
                    percValue: value,
                    assetPath: 'assets/images/petals/activities_pink_fg.svg',
                    quadrant: PetalQuadrant.topLeft,
                    align: Alignment.topLeft,
                  ),
                ),

                // Glucose ( top left)
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: _lastGlucosePerc, end: glucosePerc),
                  duration: const Duration(milliseconds: 800),
                  onEnd: () => _lastGlucosePerc = glucosePerc,
                  builder: (context, value, _) => _buildPetal(
                    halfSide: halfSide,
                    percValue: value,
                    assetPath: 'assets/images/petals/glucose_purple_fg.svg',
                    quadrant: PetalQuadrant.bottomRight,
                    align: Alignment.bottomRight,
                  ),
                ),

                // Sleep (bottom left)
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: sleepPerc),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, _) => _buildPetal(
                    halfSide: halfSide,
                    percValue: value,
                    assetPath: 'assets/images/petals/sleep_blue_fg.svg',
                    quadrant: PetalQuadrant.topRight,
                    align: Alignment.topRight,
                  ),
                ),

                // Center Circle
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: halfSide / 2.7,
                    height: halfSide / 2.7,
                    child: HealthScoreCircle(
                      score: _rotationAnim.isCompleted
                          ? (5 * _fillAnim.value).round()
                          : null,
                    ),
                  ),
                ),

                // Border
                CustomPaint(
                  size: Size(minSide, minSide),
                  painter: PetalBorderPainter(halfSide / 2.4),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // EXACT same scaling/offset math as your original 4 methods
  Positioned _buildPetal({
    required double halfSide,
    required double percValue,
    required String assetPath,
    required PetalQuadrant quadrant,
    required Alignment align,
  }) {
    final displayPerc = percValue * 0.7;
    final normalizedScale = displayPerc.clamp(0.0, 0.7);

    double leftOffset = 0;
    double topOffset  = 0;

    if (displayPerc < 0.7) {
      leftOffset = -18.3333 * (displayPerc - 0.7);
      topOffset  =  23.3333 * (displayPerc - 0.7);
    }

    late double left;
    late double top;

    switch (quadrant) {
      case PetalQuadrant.bottomLeft:
        left = halfSide + leftOffset;
        top  = topOffset;
        break;
      case PetalQuadrant.topLeft:
        left = halfSide + leftOffset;
        top  = halfSide - topOffset;
        break;
      case PetalQuadrant.bottomRight:
        left = 0 - leftOffset;
        top  = 0 + topOffset;
        break;
      case PetalQuadrant.topRight:
        left = 0 - leftOffset;
        top  = halfSide - topOffset;
        break;
    }

    return Positioned(
      left: left,
      top: top,
      width: halfSide,
      height: halfSide,
      child: Align(
        alignment: align,
        child: SizedBox(
          width: halfSide * normalizedScale,
          height: halfSide * normalizedScale,
          child: SvgPicture.asset(assetPath, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class PetalBorderPainter extends CustomPainter {
  final double radius;
  PetalBorderPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final circlePaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
