extension DateTimeSimplefy on DateTime {
  int simplify() {
    return millisecondsSinceEpoch ~/ 60000;
  }

  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

  DateTime resetTime({bool toEnd = false}) {
    return copyWith(
      hour: toEnd ? 23 : 0,
      minute: toEnd ? 59 : 0,
      second: toEnd ? 59 : 0,
      millisecond: toEnd ? 999 : 0,
    );
  }
}
