import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

import '../components/color.dart';

EasyDateTimeLine changeTodyHighlightColorExample() {
  return EasyDateTimeLine(
    initialDate: DateTime.now(),
    onDateChange: (selectedDate) {
      //`selectedDate` the new date selected.
    },
    activeColor: AppColor.primeColor,
    dayProps:  EasyDayProps(
      todayHighlightStyle: TodayHighlightStyle.withBackground,
      todayHighlightColor: AppColor.secondColor,
    ),
  );
}

class EasyInfiniteDateTimeLineExample extends StatefulWidget {
  const EasyInfiniteDateTimeLineExample({super.key});

  @override
  State<EasyInfiniteDateTimeLineExample> createState() =>
      _EasyInfiniteDateTimeLineExampleState();
}

class _EasyInfiniteDateTimeLineExampleState
    extends State<EasyInfiniteDateTimeLineExample> {
  final EasyInfiniteDateTimelineController _controller =
  EasyInfiniteDateTimelineController();
  DateTime? _focusDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EasyInfiniteDateTimeLine(
          controller: _controller,
          firstDate: DateTime(2024),
          focusDate: _focusDate,
          lastDate: DateTime(2024, 12, 31),
          onDateChange: (selectedDate) {
            setState(() {
              _focusDate = selectedDate;
            });
          },
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _controller.animateToFocusDate();
              },
              child: const Text('Animate To Focus Date'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.animateToCurrentData();
              },
              child: const Text('Animate To Current Date'),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.animateToDate(DateTime(2024, 6, 5));
              },
              child: const Text('Animate To 2024-6-5 '),
            ),
          ],
        ),
      ],
    );
  }
}
