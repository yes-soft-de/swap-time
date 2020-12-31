import 'package:inject/inject.dart';

@provide
@singleton
class Logger {
  void info(String tag, String msg) {
    String time = DateTime.now().toString();
    print('Info: $time: \t $tag \t $msg');
  }

  void warn(String tag, String msg) {
    String time = DateTime.now().toString();
    print('Warn: $time: \t $tag \t $msg');
  }

  void error(String tag, String msg) {
    String time = DateTime.now().toString();
    print('Error: $time: \t $tag \t $msg');
  }
}
