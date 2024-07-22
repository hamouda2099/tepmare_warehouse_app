import 'dart:async';

Timer? timer;

void debounce(Function callback, {int d = 500}) {
  timer?.cancel();
  timer = Timer(Duration(milliseconds: d), () {
    callback();
  });
}
