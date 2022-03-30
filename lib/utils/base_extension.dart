import 'package:flutter/foundation.dart' show kDebugMode;

extension StringExtension on String? {
  void get toLog {
    if (kDebugMode) {
      print('LOG::PROJECT::$this');
    }
  }

  void get toErrorLog {
    if (kDebugMode) {
      print('ERROR::PROJECT::$this');
    }
  }
}
