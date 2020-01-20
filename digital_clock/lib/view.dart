import 'dart:ui';

import 'package:digital_clock/fact.dart';
import 'package:digital_clock/utils.dart';

class View {
  View(this.animation, this.fact, this.color);

  final String animation;
  final String fact;
  final Color color;
}

class ViewProvider {
  ViewProvider(this._factProvider);

  final FactProvider _factProvider;

  String _fact;
  DateTime _factUpdated;

  View getForTime(DateTime time) {
    if (_factUpdated == null || time.difference(_factUpdated).inMinutes >= 10) {
      _factUpdated = time;
      _fact = _factProvider.random;
    }

    final morning = TimeOfDay(const Color(0xFF479BBA), time.withHour(6));
    final forenoon = TimeOfDay(const Color(0xFFC7A029), time.withHour(8));
    final noon = TimeOfDay(const Color(0xFF46BAC6), time.withHour(11));
    final afternoon = TimeOfDay(const Color(0xFF1CA362), time.withHour(13));
    final evening = TimeOfDay(const Color(0xFF4F4F4F), time.withHour(16));
    final night = TimeOfDay(const Color(0xFF3D2260), time.withHour(18));
    final sleep = TimeOfDay(const Color(0xFF132835), time.withHour(22));
    final tomorrow = TimeOfDay(morning.color, morning.start.nextDay());

    if (time.isBetween(morning.start, forenoon.start))
      return View(
        '1_morning',
        _fact,
        _getColor(time, morning, forenoon),
      );
    if (time.isBetween(forenoon.start, noon.start))
      return View(
        '2_forenoon',
        _fact,
        _getColor(time, forenoon, noon),
      );
    if (time.isBetween(noon.start, afternoon.start))
      return View(
        '3_noon',
        _fact,
        _getColor(time, noon, afternoon),
      );
    if (time.isBetween(afternoon.start, evening.start))
      return View(
        '4_afternoon',
        _fact,
        _getColor(time, afternoon, evening),
      );
    if (time.isBetween(evening.start, night.start))
      return View(
        '5_evening',
        _fact,
        _getColor(time, evening, night),
      );
    if (time.isBetween(night.start, sleep.start))
      return View(
        '6_night',
        _fact,
        _getColor(time, night, sleep),
      );
    return View(
      '7_sleep',
      _fact,
      _getColor(time, sleep, tomorrow),
    );
  }
}

Color _getColor(DateTime current, TimeOfDay from, TimeOfDay to) {
  final duration = to.start.difference(from.start).inSeconds;
  final updated =
      from.start.isAfter(current) ? current.add(Duration(days: 1)) : current;
  return Color.lerp(from.color, to.color,
      updated.difference(from.start).inSeconds.abs().toDouble() / duration);
}
