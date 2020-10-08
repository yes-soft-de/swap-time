import 'package:inject/inject.dart';

@provide
@singleton
class Logger {
  void info(String tag, String msg) {
    // TODO: Check Log Level, and Display Accordingly
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');
  }

  void warn(String tag, String msg) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');

    // TODO: Maybe Send a Log to Google Analytics?
  }

  void error(String tag, String msg) {
    String time = DateTime.now().toString();
    print('$time: \t $tag \t $msg');

    // TODO: Maybe Send a Log to Google Analytics?
  }
}
