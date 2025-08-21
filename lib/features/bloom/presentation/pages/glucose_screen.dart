import 'package:flutter/material.dart';
import 'package:bloom_health_app/core/theme/theme.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/homepage_widgets/bottom_navbar.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/glucosescreen_widgets/glucose_data_map.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/glucosescreen_widgets/glucose_scale.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/glucosescreen_widgets/marker_scale_widget.dart';
import 'package:bloom_health_app/features/bloom/presentation/widgets/glucosescreen_widgets/time_scale.dart';
import 'package:bloom_health_app/core/theme/app_colors.dart';



class GlucoseApp extends StatelessWidget {
  const GlucoseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlucoseScreen();
  }
}

class GlucoseScreen extends StatefulWidget {
  const GlucoseScreen({super.key});

  @override
  State<GlucoseScreen> createState() => _GlucoseScreenState();
}

class _GlucoseScreenState extends State<GlucoseScreen> {
  double selectedGlucose = 95;
  List<HealthMarker> selectedMarkers = [];
  int selectedHourIndex = 0;
  int selectedTimeIndex = 0;



  double _calculateIndicatorTop(double  glucose) {
    const minValue = 70;
    const maxValue = 140;
    const barHeight = 200.0;

    final clamped = glucose.clamp(minValue, maxValue);
    final percentage = 1 - ((clamped - minValue) / (maxValue - minValue));
    return percentage * barHeight;
  }
  String selectedFilter = 'All';

  final List<Map<String, dynamic>> glucosePatterns = [
    {
      'title': 'Morning Rise',
      'description': 'Your glucose tends to rise between 6–8 AM, even before eating.',
      'icon': Icons.wb_sunny,
      'category': 'Time',
    },
    {
      'title': 'After Breakfast Spike',
      'description': 'High carb breakfast causes a +40–60 mg/dL spike within 1 hour.',
      'icon': Icons.breakfast_dining,
      'category': 'Meals',
    },
    {
      'title': 'Lunch Impact',
      'description': 'Your glucose is more stable after protein-rich lunches.',
      'icon': Icons.lunch_dining,
      'category': 'Meals',
    },
    {
      'title': 'Exercise Effect',
      'description': '30+ min walks lower your levels by ~20 mg/dL.',
      'icon': Icons.fitness_center,
      'category': 'Activities',
    },
    {
      'title': 'Evening Pattern',
      'description': 'Glucose tends to rise after 8 PM, possibly related to reduced activity.',
      'icon': Icons.nights_stay,
      'category': 'Time',
    },
  ];

  List<Map<String, dynamic>> get filteredPatterns {
    if (selectedFilter == 'All') return glucosePatterns;
    return glucosePatterns.where((item) => item['category'] == selectedFilter).toList();
  }


  final List<String> timeLabels = ['12 AM','2 AM', '4 AM', '6 AM', '8 AM','10 AM',
    '12 PM','2 PM', '4 PM', '6 PM', '8 PM','10 PM'];


  final Map<String, GlucoseData> timeToData = {                  // GlucoseData() and  HealthMarker() is define glucose_data_map.dart file
    '12 AM': GlucoseData(glucose: 95, markers: [
      HealthMarker(type: 'Sleep', background: Color(0xB24FAFFF), positionPercent: 0.8,size: 18),
    ]),
    '2 AM': GlucoseData(glucose: 85, markers: [
      HealthMarker(type: 'Sleep', background: Color(0xB24FAFFF), positionPercent: 0.5,size: 20),
    ]),
    '4 AM': GlucoseData(glucose: 110, markers: [
      // HealthMarker(type: 'Activity', color: Colors.purple, positionPercent: 0.5),
      HealthMarker(type: 'Sleep', background: Color(0xB24FAFFF), positionPercent: 0.2,size: 18),
      HealthMarker(type: 'Sleep', background: Color(0xB24FAFFF), positionPercent: 0.8,size: 10),
    ]),
    '6 AM': GlucoseData(glucose: 120, markers: [
      HealthMarker(type: 'Sleep', background: Color(0xB24FAFFF), positionPercent: 0.2,size: 15),
      HealthMarker(type: 'Food', background: Color(0xB2F59D0E), positionPercent: 0.8,size: 10),
      HealthMarker(type: 'Activity', background: Color(0xB5CA72F0), positionPercent: 0.5,size: 18),
    ]),
    '8 AM': GlucoseData(glucose: 120, markers: [
      HealthMarker(type: 'Food', background: Color(0xB2F59D0E), positionPercent: 0.8,size: 18),
      HealthMarker(type: 'Activity', background: Color(0xB5CA72F0), positionPercent: 0.6,size: 25),
    ]),
    '10 AM': GlucoseData(glucose: 80, markers: [
      HealthMarker(type: 'Food', background: Color(0xB2F59D0E), positionPercent: 0.5,size: 18),
      HealthMarker(type: 'Activity', background: Color(0xB5CA72F0), positionPercent: 0.8,size: 30),
    ]),
    '12 PM': GlucoseData(glucose: 130, markers: [
      HealthMarker(type: 'Food', background: Color(0xB2F59D0E), positionPercent: 0.8,size: 18),
      HealthMarker(type: 'Activity', background: Color(0xB5CA72F0), positionPercent: 0.5,size: 10),
    ]),
    '2 PM': GlucoseData(glucose: 100, markers: [
      // HealthMarker(type: 'Food', color: Colors.orange, positionPercent: 0.8),
      HealthMarker(type: 'Activity', background: Color(0xB5CA72F0), positionPercent: 0.3,size: 10),
      HealthMarker(type: 'Sleep', background: Color(0xB24FAFFF), positionPercent: 0.2,size: 10),
    ]),
    '4 PM': GlucoseData(glucose: 90, markers: [
      HealthMarker(type: 'Food', background: Color(0xB2F59D0E), positionPercent: 0.8,size: 18),
      HealthMarker(type: 'Activity', background: Color(0xB5CA72F0), positionPercent: 0.5,size: 05),
      HealthMarker(type: 'Sleep', background: Color(0xB24FAFFF), positionPercent: 0.2,size: 15),
    ]),
    '6 PM': GlucoseData(glucose: 81, markers: [
      HealthMarker(type: 'Food', background: Color(0xB2F59D0E), positionPercent: 0.8,size: 15),
      HealthMarker(type: 'Activity', background: Color(0xB5CA72F0), positionPercent: 0.5,size: 20),
    ]),
    '8 PM': GlucoseData(glucose: 95, markers: [
      HealthMarker(type: 'Food', background: Color(0xB2F59D0E), positionPercent: 0.8,size: 18),
      HealthMarker(type: 'Activity', background: Color(0xB5CA72F0), positionPercent: 0.5,size: 20),
    ]),
    '10 PM': GlucoseData(glucose: 110, markers: [
      HealthMarker(type: 'Food', background: Color(0xB2F59D0E), positionPercent: 0.8,size: 20),
      HealthMarker(type: 'Activity', background: Color(0xB5CA72F0), positionPercent: 0.5,size: 10),
    ]),
  };



  @override
  void initState() {
    super.initState();
    updateSelectedData(0); // Initialize first time slot
  }

  void updateSelectedData(int index) {
    final time = timeLabels[index];
    final data = timeToData[time]!;
    setState(() {
      selectedHourIndex = index;
      selectedGlucose = data.glucose.toDouble();
      selectedMarkers = data.markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const double scaleHeight = 230;
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: false,
            pinned: false, // hides when scrolling
            snap: false,
            expandedHeight: 40,
            flexibleSpace:  FlexibleSpaceBar(
              centerTitle: true,
              title: SizedBox(
                width: 88, // Figma width
                height: 17, // Figma height
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'GLUCOSE',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500, // Medium
                      fontSize: 14,
                      height: 1.0, // line-height 100%
                      letterSpacing: 0.24 * 14, // 24% of font size
                      color: AppColors.glucoseDisplay, // change color if needed
                    ),
                  ),
                ),
              ),
            ),
            elevation: 0,
          ),

          // Your scrollable body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Top Section: Marker, Glucose, and Time Scales
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MarkerScaleWidget(
                        height: scaleHeight,
                        markers: selectedMarkers,
                      ),
                      GlucoseScaleWidget(
                        glucoseValue: selectedGlucose.toDouble(),
                        height: scaleHeight,
                        calculateIndicatorTop: _calculateIndicatorTop,
                      ),
                      TimeScaleWidget(
                        timeLabels: generate2HourLabels(),
                        height: scaleHeight,
                        itemSpacing: 38,
                        onTimeAtIndicator: (index) {
                          final time = timeLabels[index]; // match index to label
                          final data = timeToData[time]!; // get GlucoseData for that time

                          setState(() {
                            selectedTimeIndex = index;
                            selectedGlucose = data.glucose.toDouble();
                            selectedMarkers = data.markers;
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // LEGEND BELOW SCALE
                  SizedBox(
                    width: 232,
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        LegendItem(label: 'FOOD', color: AppColors.foodYellow),
                        // SizedBox(width: 24), // gap from Figma
                        LegendItem(label: 'ACTIVITIES', color: AppColors.activityPurple),
                        // SizedBox(width: 24), // gap from Figma
                        LegendItem(label: 'SLEEP', color: AppColors.sleepSky),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // TITLE & SUBTITLE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    child: Align(
                      alignment: Alignment.topLeft, // align everything to the left
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // ensures text is left-aligned
                        children: [
                          // Title: Glucose Patterns
                          SizedBox(
                            width: 158,
                            height: 22,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Glucose Patterns",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w500, // override weight only
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Subtitle: Insights based on your data
                          SizedBox(
                            width: 158,
                            height: 16,
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "Insights based on your data",
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),



                  // FILTER CHIPS
                  SizedBox(
                    width: 353, // Figma width
                    height: 32, // Figma height
                    child: Wrap(
                      spacing: 12, // horizontal gap
                      runSpacing: 0,
                      children: ['All', 'Meals', 'Activities', 'Time'].map((category) {
                        return SizedBox(
                          height: 32, // Figma height
                          child: FilterChip(
                            label: Text(category),
                            selected: selectedFilter == category,
                            onSelected: (_) {
                              setState(() {
                                selectedFilter = category;
                              });
                            },
                            showCheckmark: false, // removes the checkmark
                            selectedColor: AppColors.selectedColorFilter, // optional: active chip color
                            // backgroundColor: Colors.grey[200], // optional: inactive chip color
                          ),
                        );
                      }).toList(),
                    ),
                  ),


                  const SizedBox(height: 20),

                  // INFO CARDS
                  ...filteredPatterns.map((pattern) {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: Icon(pattern['icon'], color: Colors.blue),
                        title: Text(pattern['title']),
                        subtitle: Text(pattern['description']),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavbar(),
    );

  }



}

// ======= DATA MODELS =======


class TimeScalePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    const int tickCount = 24;
    const double tickSpacing = 8.0;

    for (int i = 0; i <= tickCount; i++) {
      final y = i * tickSpacing;
      final isMajor = i % 4 == 0;

      canvas.drawLine(
        Offset(0, y),
        Offset(isMajor ? 12 : 6, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



// ======= LEGEND WIDGET =======

class LegendItem extends StatelessWidget {
  final String label;
  final Color color;

  const LegendItem({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, size: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}








