// ignore_for_file: no_logic_in_create_state
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:widgets_flutter_and_material/extension/datetime.dart';

import '../resources/color_pallete.dart';

/// Custom DateTimePicker widget
class DateTimePickerVisitorNew extends StatefulWidget {
  final bool ranged;
  final int minHour;
  final int maxHour;
  final int initialStartHour;
  final int initialEndHour;
  final DateTime? initialDate;

  final ValueChanged<DateTime>? onDateTimeChanged;
  final ValueChanged<DateTimeRange>? onDateTimeRangeChanged;

  /// A widget for Date Time Picker
  ///
  /// See `DateTimePicker.range` to pick date time in range
  const DateTimePickerVisitorNew({
    super.key,
    this.minHour = 0,
    this.maxHour = 23,
    int? initialStartHour,
    int? initialEndHour,
    this.initialDate,
    ValueChanged<DateTimeRange>? onChanged,
  })  : assert(minHour < maxHour && (maxHour - minHour >= 1)),
        initialStartHour = initialStartHour ?? minHour,
        initialEndHour = initialEndHour ?? maxHour,
        onDateTimeChanged = null,
        onDateTimeRangeChanged = onChanged,
        ranged = true;

  @override
  State<DateTimePickerVisitorNew> createState() =>
      _DateTimePickerVisitorNewState(maxHour);
}

class _DateTimePickerVisitorNewState extends State<DateTimePickerVisitorNew> {
  static const _whiteColor = TextStyle(color: Colors.white);
  static const _halfColor = TextStyle(color: Color(0x80292929));
  static const _textStyle = TextStyle(
    color: Color(0xFF292929),
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
  );

  late final DateTime today;
  late final DateTime date2;
  final int maxhour;
  late List<int> hours;
  late DateTime currMonth;
  late int daysInMonth;
  late int firstDayOffset;
  late int disableDayUntil;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  // late List<int> startTime;
  // late List<int> endTime;

  DateTime? selectedDate;
  _DateTimePickerVisitorNewState(this.maxhour);

  @override
  void initState() {
    super.initState();

    today = DateTime.now();
    date2 = DateTime.now().add(const Duration(days: 1));
    hours = List.generate(
      1 + widget.maxHour - widget.minHour,
      (i) => i + widget.minHour,
    );

    selectedDate = ((widget.initialDate)?.isBeforeDay(today) ?? false)
        ? widget.initialDate
        : null;
    startTime = TimeOfDay(hour: today.hour, minute: today.minute);
    endTime = TimeOfDay(hour: widget.initialEndHour, minute: 0);
    // startTime = List.from([today.hour, today.minute], growable: false);
    // endTime = List.from([widget.initialEndHour, 0], growable: false);

    changeCurrMonth(selectedDate ?? today, init: true);
  }

  @override
  void didUpdateWidget(covariant DateTimePickerVisitorNew oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.minHour != widget.minHour ||
        oldWidget.maxHour != widget.maxHour) {
      hours = List.generate(
        1 + widget.maxHour - widget.minHour,
        (i) => i + widget.minHour,
      );
    }
  }

  void changeCurrMonth(DateTime currentMonth, {bool init = false}) {
    currMonth = currentMonth;
    daysInMonth = currentMonth.daysInMonth;
    firstDayOffset = (currentMonth.copyWith(day: 1).weekday % 7);
    disableDayUntil = (currentMonth.isSameMonth(today)
        ? today.day
        : (currentMonth.isBefore(today) ? 32 : 0));

    if (!init) {
      setState(() {});
    }
  }

  void dateTimeChanged() {
    if (selectedDate != null) {
      if (widget.onDateTimeRangeChanged != null) {
        widget.onDateTimeRangeChanged!(
          DateTimeRange(
            start: selectedDate!.copyWith(
              hour: startTime.hour,
              minute: startTime.minute,
            ),
            end: selectedDate!.copyWith(
              hour: endTime.hour,
              minute: endTime.minute,
            ),
          ),
        );
      }
    }
  }

  // void dateTimeChanged() {
  //   if (selectedDate != null) {
  //     if (widget.onDateTimeRangeChanged != null) {
  //       widget.onDateTimeRangeChanged!(
  //         DateTimeRange(
  //           start: selectedDate!.copyWith(
  //             hour: startTime[0],
  //             minute: startTime[1],
  //           ),
  //           end: selectedDate!.copyWith(
  //             hour: endTime[0],
  //             minute: endTime[1],
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: _textStyle,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const SizedBox(height: 18.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Start Date'),
                    const SizedBox(
                      height: 5,
                    ),
                    DateTimeField(
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(16, 16, 26, 0.063),
                        hintText: 'Select Date',
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 14),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: ColorPalette.primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedDate = value;
                          dateTimeChanged();
                        });
                      },
                      format: DateFormat('EEE, dd MMMM yyyy'),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: today,
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Starting Hour'),
                  const SizedBox(
                    height: 5,
                  ),
                  _TimeDropdownNew(
                    time: startTime,
                    onTimeChanged: (val) {
                      setState(() {
                        startTime = val;
                        if (val.hour == endTime.hour &&
                            startTime.minute >= endTime.minute) {
                          endTime =
                              endTime.replacing(minute: startTime.minute + 15);
                        }
                        dateTimeChanged();
                      });
                    },
                    boxDecoration: const BoxDecoration(
                      color: Color.fromRGBO(16, 16, 26, 0.063),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    textStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('End Date'),
                    const SizedBox(
                      height: 5,
                    ),
                    DateTimeField(
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(16, 16, 26, 0.063),
                        hintText: 'Select Date',
                        hintStyle:
                            TextStyle(color: Colors.black54, fontSize: 14),
                        suffixIcon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: ColorPalette.primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedDate = value;
                          dateTimeChanged();
                        });
                      },
                      format: DateFormat('EEE, dd MMMM yyyy'),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: today,
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2030),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('End Hour'),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _TimeDropdownNew(
                        time: endTime,
                        onTimeChanged: (val) {
                          setState(() {
                            endTime = val;
                            if (endTime.hour == startTime.hour &&
                                endTime.minute <= startTime.minute) {
                              startTime ==
                                  startTime.replacing(
                                    minute: endTime.minute - 15,
                                  );
                            }
                          });
                        },
                        boxDecoration: const BoxDecoration(
                          color: Color.fromRGBO(16, 16, 26, 0.063),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        textStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget dayBuilder(BuildContext context, int index) {
    var day = (index + 1) - firstDayOffset;
    if (day >= 1) {
      if (day >= disableDayUntil) {
        final date = currMonth.copyWith(day: day);
        final selected = (date.isSameDay(selectedDate));
        if (!selected) {
          return Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  selectedDate = date;
                });
                dateTimeChanged();
              },
              child: Text('$day', style: _textStyle),
            ),
          );
        }
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: ColoredBox(
            color: primaryMColor,
            child: Center(child: Text('$day', style: _whiteColor)),
          ),
        );
      }
      return Center(child: Text('$day', style: _halfColor));
    }
    return const SizedBox.shrink();
  }
}

class _TimeDropdownNew extends StatelessWidget {
  final TimeOfDay time;
  final ValueChanged<TimeOfDay>? onTimeChanged;
  final BoxDecoration? boxDecoration;
  final TextStyle? textStyle;

  const _TimeDropdownNew({
    super.key,
    required this.time,
    this.onTimeChanged,
    required this.boxDecoration,
    required this.textStyle,
  });

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (picked != null && picked != time) {
      onTimeChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectTime(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        decoration: boxDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time.format(context),
              style: textStyle,
            ),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: ColorPalette.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

// class _TimeDropdownNew extends StatelessWidget {
//   final int time;
//   final Map<int, bool> times;
//   final ValueChanged<int?>? onChanged;

//   const _TimeDropdownNew({
//     super.key,
//     required this.time,
//     required this.times,
//     this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField2<int>(
//       isExpanded: true,
//       iconStyleData: const IconStyleData(icon: SizedBox.shrink()),
//       dropdownStyleData: DropdownStyleData(
//         elevation: 0,
//         maxHeight: MediaQuery.of(context).size.height * 5 / 10,
//         width: MediaQuery.of(context).size.width * 2 / 10,
//         padding: EdgeInsets.zero,
//       ),
//       menuItemStyleData: const MenuItemStyleData(
//         height: 30.0,
//       ),
//       alignment: Alignment.center,
//       decoration: const InputDecoration(
//         prefixIcon: Icon(
//           Icons.keyboard_arrow_down_outlined,
//           color: ColorPalette.primaryColor,
//         ),
//         filled: true,
//         fillColor: Color(0xFFDBDBDB),
//         contentPadding: EdgeInsets.zero,
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: BorderRadius.all(Radius.circular(5.0)),
//           gapPadding: 10.0,
//         ),
//         constraints: BoxConstraints(maxWidth: 70.0, maxHeight: 35),
//       ),
//       style: const TextStyle(
//         color: Color(0xFF292929),
//         fontWeight: FontWeight.w600,
//         fontSize: 14.0,
//       ),
//       value: time,
//       onChanged: onChanged,
//       items: times.entries
//           .map((e) => DropdownMenuItem(
//                 value: e.key,
//                 enabled: e.value,
//                 alignment: Alignment.center,
//                 child: Text(
//                   '${e.key}',
//                   style: TextStyle(
//                     color: e.value ? null : const Color(0x80292929),
//                   ),
//                 ),
//               ))
//           .toList(),
//     );
//   }
// }