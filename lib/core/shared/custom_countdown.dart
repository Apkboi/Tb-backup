import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class CustomCountDown extends StatelessWidget {
  const CustomCountDown({
    super.key,
    this.style,
  });

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
      spacerWidth: 3,
      timeTextStyle: style,
      minutesDescription: '',
      secondsDescription: '',
      format: CountDownTimerFormat.minutesSeconds,
      endTime: DateTime.now().add(
        const Duration(
          minutes: 5,
          seconds: 0,
        ),
      ),
      onEnd: () {},
    );
  }
}
