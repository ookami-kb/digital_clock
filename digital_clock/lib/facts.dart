import 'dart:math';
import 'dart:ui';

class Fact {
  Fact(this.animation, this.description, this.color);

  final String animation;
  final String description;
  final Color color;
}

const _colors = [
  const Color(0xFF479BBA),
  const Color(0xFFC7A029),
  const Color(0xFF46BAC6),
  const Color(0xFF1CA362),
  const Color(0xFF4F4F4F),
  const Color(0xFF3D2260),
  const Color(0xFF132835),
];

class Period {
  Period(this.color, this.start);

  final Color color;
  final DateTime start;
}

const _descriptions = [
  "Alaska is the easternmost, northernmost and westernmost state in the US.",
  "The official drink in Kentucky (USA) is milk.",
  "Blood service in Sweden notifies donors via message whenever their blood is used.",
  "The world's largest pyramid isn't located in Egypt but in Mexico.",
  "The IKEA catalog is the world's most widely read catalog in history.",
  "It is illegal to own only one guinea pig in Switzerland at a time due to their social rights.",
  "A secret underground vault stores all Lego sets ever made.",
  "Africa is the only continent that is in all four hemispheres.",
  "The name PEZ comes from the German word for peppermint, “PfeffErminZ”.",
  "Beer was invented before a wheel, 7000 BCE.",
];

class FactProvider {
  final _random = Random();

  String _description;
  DateTime _updated;

  Fact getForTime(DateTime time) {
    if (_updated == null || time.difference(_updated).inMinutes >= 10) {
      _updated = time;
      _description = _descriptions[_random.nextInt(_descriptions.length)];
    }

    final morning = Period(const Color(0xFF479BBA), time.withHour(6));
    final forenoon = Period(const Color(0xFFC7A029), time.withHour(8));
    final noon = Period(const Color(0xFF46BAC6), time.withHour(11));
    final afternoon = Period(const Color(0xFF1CA362), time.withHour(13));
    final evening = Period(const Color(0xFF4F4F4F), time.withHour(16));
    final night = Period(const Color(0xFF3D2260), time.withHour(18));
    final sleep = Period(const Color(0xFF132835), time.withHour(22));
    final tomorrow =
        Period(morning.color, morning.start.add(Duration(days: 1)));

    Color getColor(Period from, Period to) {
      final duration = to.start.difference(from.start).inSeconds;
      final updated =
          from.start.isAfter(time) ? time.add(Duration(days: 1)) : time;
      return Color.lerp(from.color, to.color,
          updated.difference(from.start).inSeconds.abs().toDouble() / duration);
    }

    if (time.hour >= 6 && time.hour < 8)
      return Fact(
        '1_morning',
        _description,
        getColor(morning, forenoon),
      );
    if (time.hour >= 8 && time.hour < 11)
      return Fact(
        '2_forenoon',
        _description,
        getColor(forenoon, noon),
      );
    if (time.hour >= 11 && time.hour < 13)
      return Fact(
        '3_noon',
        _description,
        getColor(noon, afternoon),
      );
    if (time.hour >= 13 && time.hour < 16)
      return Fact(
        '4_afternoon',
        _description,
        getColor(afternoon, evening),
      );
    if (time.hour >= 16 && time.hour < 18)
      return Fact(
        '5_evening',
        _description,
        getColor(evening, night),
      );
    if (time.hour >= 18 && time.hour < 22)
      return Fact(
        '6_night',
        _description,
        getColor(night, sleep),
      );
    return Fact(
      '7_sleep',
      _description,
      getColor(sleep, tomorrow),
    );
  }
}

extension on DateTime {
  DateTime withHour(int hour) => DateTime(year, month, day, hour);
}
