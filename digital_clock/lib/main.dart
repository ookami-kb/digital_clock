import 'package:digital_clock/fact.dart';
import 'package:digital_clock/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:provider/provider.dart';

import 'digital_clock.dart';

void main() {
  final factProvider = ViewProvider(FactProvider());
  runApp(
    ClockCustomizer(
      (ClockModel model) => Provider.value(
        value: factProvider,
        child: DigitalClock(model),
      ),
    ),
  );
}
