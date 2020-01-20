import 'dart:async';

import 'package:digital_clock/view.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  ViewProvider _factProvider;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _factProvider = Provider.of(context);
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

  int _ms = 0;

  void _updateTime() {
    setState(() {
      _ms += 60 * 1000;
      _dateTime = DateTime.fromMillisecondsSinceEpoch(_ms);
      _timer = Timer(
//        Duration(minutes: 1) -
        Duration(milliseconds: 100),
//            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final is24HourFormat = widget.model.is24HourFormat;
    final hour = DateFormat(is24HourFormat ? 'H' : 'h').format(_dateTime);
    final minute = DateFormat('mm').format(_dateTime);
    final marker = is24HourFormat ? '' : DateFormat('a').format(_dateTime);

    final screenWidth = MediaQuery.of(context).size.width;

    final fontSize = screenWidth * 0.28;
    final defaultStyle = TextStyle(
      color: Colors.white,
      fontFamily: 'SixCaps',
      fontSize: fontSize,
      height: 1,
    );
    final markerStyle = defaultStyle.copyWith(fontSize: screenWidth * 0.1);
    final descriptionStyle = defaultStyle.copyWith(
      fontFamily: 'Roboto',
      fontSize: screenWidth * 0.04,
    );

    final clockContentWidth = screenWidth / 2;
    final fact = _factProvider.getForTime(_dateTime);

    return Stack(
      children: <Widget>[
        Container(
          color: fact.color,
          child: FlareActor(
            'assets/${fact.animation}.flr',
            fit: BoxFit.fill,
            animation: fact.animation,
            alignment: Alignment.center,
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          child: Container(
            width: clockContentWidth,
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Flexible(flex: 52, child: Container()),
                Flexible(
                  flex: 210,
                  child: Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          textBaseline: TextBaseline.alphabetic,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          children: <Widget>[
                            Text('$hour:$minute', style: defaultStyle),
                            Container(width: 8),
                            Text(marker, style: markerStyle)
                          ],
                        ),
                        Text(fact.fact, style: descriptionStyle),
                      ],
                    ),
                  ),
                ),
                Flexible(flex: 31, child: Container()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
