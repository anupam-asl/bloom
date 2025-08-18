import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bloom_health_app/features/bloom/domain/entities/glucose_entity.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/glucose_providers.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/homepage_widgets/homepage_header.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/homepage_widgets/bottom_navbar.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/homepage_widgets/homepage_petalchart.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/homepage_widgets/homepage_reminder_card.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/entities/activity_entity.dart';
import '../../domain/entities/food_entity.dart';
import '../../domain/entities/sleep_entity.dart';
import '../viewmodels/activity_provider.dart';
import '../viewmodels/food_providers.dart';
import '../viewmodels/sleep_provider.dart';
import '../widgets/homepage_widgets/homepage_greetings.dart';

class BloomHomePage extends ConsumerStatefulWidget {
  const BloomHomePage({super.key});

  @override
  ConsumerState<BloomHomePage> createState() => _BloomHomePageState();
}

class _BloomHomePageState extends ConsumerState<BloomHomePage> {
  bool _showReminder = false;
  Timer? _dummyDataTimer;

  @override
  void initState() {
    super.initState();

    debugPrint("BloomHomePage initState — setting up dummy data for glucose, food, and sleep");

    // Insert one initial reading for each
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _insertRandomGlucose();
      _insertRandomFood();
      _insertRandomSleep();
    });

    // Every 10 seconds insert new random entries
    _dummyDataTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      debugPrint("10 seconds passed — inserting new dummy values");

      _insertRandomGlucose();
      _insertRandomFood();
      _insertRandomSleep();
      _insertRandomActivity();
    });
  }


  void _insertRandomGlucose() {
    final random = Random();
    final value = 10 + random.nextInt(91); // 10–100

    final entity = GlucoseEntity(
      dateTime: DateTime.now(),
      valueMgDl: value,
    );

    ref.read(glucoseViewModelProvider.notifier).addGlucoseEntry(entity);
    debugPrint("Inserted dummy glucose: $value mg/dL");
  }

  void _insertRandomFood() {
    final random = Random();

    final entity = FoodEntity(
      dateTime: DateTime.now(),
      foodname: "Food ${random.nextInt(100)}",
      calorie: (150 + random.nextInt(350)).toDouble(), // 150–500 kcal
    );

    ref.read(foodViewModelProvider.notifier).addFoodEntry(entity);
    debugPrint(
      "Inserted dummy food: ${entity.foodname} (${entity.calorie} kcal, ${entity.protein}g protein)",
    );
  }

  void _insertRandomActivity() {
    final random = Random();
    final minutes = 5 + random.nextInt(96);

    final entity = ActivityEntity(
      dateTime: DateTime.now(),
      exerciseMin: minutes,
    );

    ref.read(activityViewModelProvider.notifier).addActivityEntry(entity);
    debugPrint("Inserted dummy activity: $minutes min exercise");
  }


  void _insertRandomSleep() {
    final random = Random();
    final heartrate = (60 + random.nextInt(61));

    final entity = SleepEntity(
      dateTime: DateTime.now().toIso8601String(),
      sleepState: "asleep",
      heartRate: heartrate,
    );

    ref.read(sleepViewModelProvider.notifier).addSleepEntry(entity);
    debugPrint("Inserted dummy heartRate: $heartrate per min");
  }

  @override
  void dispose() {
    debugPrint(" BloomHomePage dispose — cancelling dummy data timer");

    _dummyDataTimer?.cancel();
    super.dispose();
  }

  void _handleAnimationComplete() {
    setState(() {
      _showReminder = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;
            final double chartSize = (constraints.maxWidth < constraints.maxHeight
                ? constraints.maxWidth
                : constraints.maxHeight) * 0.85;

            Widget mainColumn = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: constraints.maxHeight * 0.04),
                const HomePageHeader(),
                SizedBox(height: constraints.maxHeight * 0.02),
                const FlourishGreeting(),
                SizedBox(height: constraints.maxHeight * 0.04),
                Center(
                  child: SizedBox(
                    width: chartSize,
                    height: chartSize,
                    child: HomepagePetalChart(
                      onAnimationComplete: _handleAnimationComplete,
                    ),
                  ),
                ),
                const Spacer(),
                if (_showReminder)
                  ReminderCard(
                    message: 'Post-breakfast activity aids digestion - take the stairs to boost your bloom at work.',
                    onTap: () {},
                  ),
                if (_showReminder) const SizedBox(height: 28),
              ],
            );

            return isLandscape
                ? SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.06),
              child: mainColumn,
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.06),
              child: mainColumn,
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );
  }
}
