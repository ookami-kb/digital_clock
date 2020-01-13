import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';

/// A basic digital clock.
///
/// You can do better than this!
class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
      // Cause the clock to rebuild when the model changes.
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      // Update once per minute. If you want to update every second, use the
      // following code.
      _timer = Timer(
        Duration(minutes: 1) -
            Duration(seconds: _dateTime.second) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'H' : 'h').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final marker =
        widget.model.is24HourFormat ? '' : DateFormat('a').format(_dateTime);

    final screenWidth = MediaQuery.of(context).size.width;

    final fontSize = screenWidth * 0.28;
    final defaultStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'SixCaps',
      fontSize: fontSize,
      height: 1,
    );
    final markerStyle = defaultStyle.copyWith(fontSize: screenWidth * 0.1);
    final descriptionStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'Roboto',
      fontSize: screenWidth * 0.04,
      height: 1,
    );

    final clockContentWidth = screenWidth / 2;

    return Container(
      color: Colors.black,
      alignment: Alignment.centerLeft,
      child: Container(
        width: clockContentWidth,
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Flexible(flex: 52, child: Container()),
            Flexible(
              flex: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    textBaseline: TextBaseline.alphabetic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: <Widget>[
                      Text('$hour:$minute', style: defaultStyle),
                      Container(width: 16),
                      Text(marker, style: markerStyle)
                    ],
                  ),
                  Text(
                    'coffee was discovered by a goat herder',
                    style: descriptionStyle,
                  ),
                ],
              ),
            ),
            Flexible(flex: 31, child: Container()),
          ],
        ),
      ),
    );
  }
}
