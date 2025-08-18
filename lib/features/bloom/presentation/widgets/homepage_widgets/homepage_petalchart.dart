import 'package:bloom_health_app/features/bloom/presentation/viewmodels/activity_provider.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/food_providers.dart';
import 'package:flutter/material.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/bloom_dashboard_vm.dart';
import 'dart:math';

import '../../viewmodels/sleep_provider.dart';
import 'HealthScoreCircle.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/glucose_providers.dart';

class HomepagePetalChart extends ConsumerStatefulWidget {

  final VoidCallback? onAnimationComplete;

  const HomepagePetalChart({
    super.key,
    this.onAnimationComplete,
  });

  @override
  ConsumerState<HomepagePetalChart> createState() => _HomepagePetalChartState();
}

class _HomepagePetalChartState extends ConsumerState<HomepagePetalChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotationAnim;
  late final Animation<double> _fillAnim;

  double _lastGlucosePerc = 0.0;
  double _currentGlucosePerc = 0.0;

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
  Widget build(BuildContext context) {
    final glucoseState = ref.watch(glucoseViewModelProvider);
    final sleepState = ref.watch(sleepViewModelProvider);
    final calorieState = ref.watch(foodViewModelProvider);
    final activityState = ref.watch(activityViewModelProvider);

    // final activityState = ref.watch(activityViewModelProvider);

    double glucoseValue = 0;
    double sleepValue = 0;
    double calorieValue = 0;
    double activityValue = 0;

    glucoseState.when(
      data: (entries) {
        if (entries.isNotEmpty) {
          glucoseValue = entries.last.valueMgDl.toDouble();
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    sleepState.when(
      data: (entries) {
        if (entries.isNotEmpty) {
          debugPrint("Sleep entries count: ${entries.length}");
          debugPrint("Last heartRate: ${entries.last.heartRate}");
          sleepValue = entries.last.heartRate.toDouble();
          debugPrint("sleepValue used for petal: $sleepValue");
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    calorieState.when(
      data: (entries) {
        if (entries.isNotEmpty) {
          calorieValue = entries.last.calorie.toDouble();
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    activityState.when(
      data: (entries) {
        if (entries.isNotEmpty) {
          activityValue = entries.last.exerciseMin.toDouble();
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    const double minGlucose = 10;
    const double maxGlucose = 100;
    const double minSleep = 60; //heartrate in sleep
    const double maxSleep = 120; //heartrate in sleep
    const double minCalories = 100;
    const double maxCalories = 500;
    const double minActivity = 5;
    const double maxActivity = 100;

    double glucosePerc = ((glucoseValue - minGlucose) /
        (maxGlucose - minGlucose)).clamp(0.0, 1.0);
    double sleepPerc = ((sleepValue - minSleep) / (maxSleep - minSleep)).clamp(
        0.0, 1.0);
    double caloriePerc = ((calorieValue - minCalories) /
        (maxCalories - minCalories)).clamp(0.0, 1.0);
    double activityPerc = ((activityValue - minActivity) /
        (maxActivity - minActivity)).clamp(0.0, 1.0);

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final size = MediaQuery
            .of(context)
            .size;
        final minSide = size.shortestSide * 0.85;
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

                // Calorie Petal
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0.0,
                    end: caloriePerc,
                  ),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, _) {
                    return getCaloriePositioned(halfSide, value);
                  },
                ),

                // Activity Petal
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0.0,
                    end: activityPerc,
                  ),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, _) {
                    return getActivitiesPositioned(halfSide, value);
                  },
                ),


                // Glucose Petal
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: _lastGlucosePerc,
                    end: glucosePerc,
                  ),
                  duration: const Duration(milliseconds: 800),
                  onEnd: () => _lastGlucosePerc = glucosePerc,
                  builder: (context, value, _) {
                    return getGlucosePositioned(halfSide, value);
                  },
                ),

                // Sleep Petal
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(
                    begin: 0.0,
                    end: sleepPerc,
                  ),
                  duration: const Duration(milliseconds: 800),
                  builder: (context, value, _) {
                    return getSleepPositioned(halfSide, value);
                  },
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
                CustomPaint(
                  size: Size(minSide, minSide),
                  painter: PetalBorderPainter(halfSide/2.4), // halfSide = radius
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Positioned getCaloriePositioned(double halfSide, double percValue) {
    final displayPerc = percValue * 0.7;

    final normalizedScale = displayPerc.clamp(0.0, 0.7);

    double leftOffset = 0;
    double topOffset = 0;

    if (displayPerc < 0.7) {
      leftOffset = -18.3333 * (displayPerc - 0.7);
      topOffset = 23.3333 * (displayPerc - 0.7);
    }

    return Positioned(
      left: halfSide + leftOffset,
      top: topOffset,
      width: halfSide,
      height: halfSide,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: SizedBox(
          width: halfSide * normalizedScale,
          height: halfSide * normalizedScale,
          child: SvgPicture.asset(
            'assets/images/petals/calories_orange_fg.svg',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }


  Positioned getActivitiesPositioned(double halfSide, double percValue) {
    final displayPerc = percValue * 0.7;

    final normalizedScale = displayPerc.clamp(0.0, 0.7);

    double leftOffset = 0;
    double topOffset = 0;

    if (displayPerc < 0.7) {
      leftOffset = -18.3333 * (displayPerc - 0.7);
      topOffset = 23.3333 * (displayPerc - 0.7);
    }

    return Positioned(
      left: halfSide + leftOffset,
      top: halfSide - topOffset,
      width: halfSide,
      height: halfSide,
      child: Container(
        // color: Colors.purple.withOpacity(0.2),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: halfSide * normalizedScale,
            height: halfSide * normalizedScale,
            child: SvgPicture.asset(
              'assets/images/petals/activities_pink_fg.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Positioned getGlucosePositioned(double halfSide, double percValue) {
    final displayPerc = percValue * 0.7;

    final normalizedScale = displayPerc.clamp(0.0, 0.7);

    double leftOffset = 0;
    double topOffset = 0;

    if (displayPerc < 0.7) {
      leftOffset = -18.3333 * (displayPerc - 0.7);
      topOffset = 23.3333 * (displayPerc - 0.7);
    }

    return Positioned(
      left: 0 - leftOffset,
      top: 0 + topOffset,
      width: halfSide,
      height: halfSide,
      child: Container(
        // color: Colors.purple.withOpacity(0.2),
        child: Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: halfSide * normalizedScale,
            height: halfSide * normalizedScale,
            child: SvgPicture.asset(
              'assets/images/petals/glucose_purple_fg.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }

  Positioned getSleepPositioned(double halfSide, double percValue) {
    final displayPerc = percValue * 0.7;

    final normalizedScale = displayPerc.clamp(0.0, 0.7);

    double leftOffset = 0;
    double topOffset = 0;

    if (displayPerc < 0.7) {
      leftOffset = -18.3333 * (displayPerc - 0.7);
      topOffset = 23.3333 * (displayPerc - 0.7);
    }
    return Positioned(
      left: 0 - leftOffset,
      top: halfSide - topOffset,
      width: halfSide,
      height: halfSide,
      child: Container(
        // color: Colors.purple.withOpacity(0.2),
        child: Align(
          alignment: Alignment.topRight,
          child: SizedBox(
            width: halfSide * normalizedScale,
            height: halfSide * normalizedScale,
            child: SvgPicture.asset(
              'assets/images/petals/sleep_blue_fg.svg',
              fit: BoxFit.contain,
            ),
          ),
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

    // Draw outermost circle
    canvas.drawCircle(center, radius, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


