import 'dart:math';

class FactProvider {
  final _random = Random();

  String get random => _facts[_random.nextInt(_facts.length)];
}

const _facts = [
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
