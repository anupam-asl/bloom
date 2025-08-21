import 'package:flutter/material.dart';

List<String> generate2HourLabels() {

  return List.generate(12, (index) {
    final hour24 = index * 2;
    final hour12 = hour24 == 0
        ? 12
        : hour24 > 12
        ? hour24 - 12
        : hour24;
    final period = hour24 < 12 ? 'AM' : 'PM';
    return '$hour12 $period';
  });
}

class TimeScaleWidget extends StatefulWidget {
  final List<String> timeLabels;
  final double height; // visible height of the scale
  final double itemSpacing; // distance between major labels
  final ValueChanged<int> onTimeAtIndicator;

  const TimeScaleWidget({
    super.key,
    required this.timeLabels,
    required this.height,
    required this.itemSpacing,
    required this.onTimeAtIndicator,
  });

  @override
  State<TimeScaleWidget> createState() => _TimeScaleWidgetState();
}

class _TimeScaleWidgetState extends State<TimeScaleWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // The indicator is fixed in the middle of the height
    // double indicatorY = widget.height / 2;
    double indicatorY = 367 / 2; // fixed height from Figma
    // Calculate which label is aligned with the indicator
    int index = (( _scrollController.offset + indicatorY ) / widget.itemSpacing).round();

    if (index >= 0 && index < widget.timeLabels.length) {
      widget.onTimeAtIndicator(index);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 1, // From Figma spec
      child: SizedBox(
        width: 72, // From Figma spec
        height: 374, // From Figma spec
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.timeLabels.length * 2 - 1,
            itemBuilder: (context, index) {
              bool isMajor = index % 2 == 0;
              return Padding(
                padding: EdgeInsets.only(
                  top: index == 0 ? 0 : widget.itemSpacing / 2,
                ),
                child: Row(
                  children: [
                    if (isMajor)
                      Text(
                        widget.timeLabels[index ~/ 2],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    if (isMajor) const SizedBox(width: 4),
                    Container(
                      width: isMajor ? 12 : 6,
                      height: 3,
                      color: Colors.black,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

}





