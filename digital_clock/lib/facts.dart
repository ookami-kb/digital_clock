import 'dart:ui';

class Fact {
  Fact(this.animation, this.description, this.color);

  final String animation;
  final String description;
  final Color color;
}

class FactProvider {
  Fact getForTime(DateTime time) {
    if (time.hour >= 6 && time.hour < 8)
      return Fact(
        '1_morning',
        'coffee was discovered by a goat herder',
        const Color(0xFF479BBA),
      );
    if (time.hour >= 8 && time.hour < 11)
      return Fact(
        '2_forenoon',
        'coffee was discovered by a goat herder',
        const Color(0xFFC7A029),
      );
    if (time.hour >= 11 && time.hour < 13)
      return Fact(
        '3_noon',
        'coffee was discovered by a goat herder',
        const Color(0xFF46BAC6),
      );
    if (time.hour >= 13 && time.hour < 16)
      return Fact(
        '4_afternoon',
        'coffee was discovered by a goat herder',
        const Color(0xFF1CA362),
      );
    if (time.hour >= 16 && time.hour < 18)
      return Fact(
        '5_evening',
        'coffee was discovered by a goat herder',
        const Color(0xFF4F4F4F),
      );
    if (time.hour >= 18 && time.hour < 22)
      return Fact(
        '6_night',
        'coffee was discovered by a goat herder',
        const Color(0xFF3D2260),
      );
    return Fact(
      '7_sleep',
      'coffee was discovered by a goat herder',
      const Color(0xFF132835),
    );
  }
}
