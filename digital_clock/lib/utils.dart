import 'dart:ui';

class TimeOfDay {
  TimeOfDay(this.color, this.start);

  final Color color;
  final DateTime start;
}

extension DateTimeUtils on DateTime {
  DateTime withHour(int hour) => DateTime(year, month, day, hour);

  DateTime nextDay() => add(Duration(days: 1));

  bool isBetween(DateTime from, DateTime to) =>
      (isAfter(from) || isAtSameMomentAs(from)) && isBefore(to);
}
