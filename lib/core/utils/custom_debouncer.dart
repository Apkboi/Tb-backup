import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({this.milliseconds = 500});

  call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  cancel() {
    _timer?.cancel();
    _timer = null;
  }
}

class DebouncerMaster<T> {
  DebouncerMaster(this.duration, this.onValue);

  final Duration duration;
  void Function(T value) onValue;
  late T _value;
  Timer? _timer;

  T get value => _value;

  set value(T val) {
    _value = val;
    _timer?.cancel();
    _timer = Timer(duration, () => onValue(_value));
  }
}
