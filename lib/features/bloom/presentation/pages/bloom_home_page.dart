import 'package:flutter/material.dart';
import 'package:bloom_health_app/features/bloom/presentation/viewmodels/bloom_dashboard_vm.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/homepage_widgets/homepage_header.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/homepage_widgets/bottom_navbar.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/homepage_widgets/homepage_petalchart.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/homepage_widgets/homepage_reminder_card.dart';

import '../widgets/homepage_widgets/homepage_greetings.dart';

class BloomHomePage extends StatefulWidget {
  final BloomDashboardViewModel viewModel;

  const BloomHomePage({super.key, required this.viewModel});

  @override
  State<BloomHomePage> createState() => _BloomHomePageState();
}

class _BloomHomePageState extends State<BloomHomePage> {
  bool _showReminder = false;

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
            // Choose properly scaled size for petal chart
            final double chartSize = (constraints.maxWidth < constraints.maxHeight
                ? constraints.maxWidth
                : constraints.maxHeight) *0.85;


            Widget mainColumn = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 26),
                const HomePageHeader(),
                const SizedBox(height: 32),
                const FlourishGreeting(),
                const SizedBox(height: 32),
                Center(
                  child: SizedBox(
                    width: chartSize,
                    height: chartSize,
                    child: HomepagePetalChart(
                      viewModel: widget.viewModel,
                      onAnimationComplete: _handleAnimationComplete,
                    ),
                  ),
                ),
                const SizedBox(height: 160),
                if (_showReminder)
                  ReminderCard(
                    message: 'A gentle wind-down sets the stage...',
                    onTap: () {},
                  ),
                if (_showReminder) const SizedBox(height: 32),
              ],
            );

            // Wrap in scroll view if not enough height in landscape
            return isLandscape
                ? SingleChildScrollView(
              child: mainColumn,
              padding: const EdgeInsets.symmetric(horizontal: 24),
            )
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: mainColumn,
            );
          },
        ),
      ),
      bottomNavigationBar: const BottomNavbar(),
    );

  }
}
