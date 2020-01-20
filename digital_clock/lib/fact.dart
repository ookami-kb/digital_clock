import 'dart:math';

class FactProvider {
  final _random = Random();

  String get random => _facts[_random.nextInt(_facts.length)];
}

const _facts = [
  "The official drink in Kentucky (USA) is milk.",
  "The world's largest pyramid isn't located in Egypt but in Mexico.",
  "The IKEA catalog is the world's most widely read catalog in history.",
  "A secret underground vault stores all Lego sets ever made.",
  "Africa is the only continent that is in all four hemispheres.",
  "The name PEZ comes from the German word for peppermint, “PfeffErminZ”.",
  "Beer was invented before a wheel, 7000 BCE.",
];
