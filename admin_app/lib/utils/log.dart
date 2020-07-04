//ignore_for_file: avoid_print

import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart';

abstract class Log {
  static final _debugCode = chooseLogColor(LogLevel.DEBUG);
  static final _infoCode = chooseLogColor(LogLevel.INFO);
  static final _warnCode = chooseLogColor(LogLevel.WARN);
  static final _errorCode = chooseLogColor(LogLevel.ERROR);

  static void debug(dynamic data) {
    if (!kReleaseMode) _print(_debugCode, '::debug:: $data');
  }

  static void info(dynamic data) {
    _print(_infoCode, '::info:: $data');
  }

  static void warn(dynamic data) {
    _print(_warnCode, '::warn:: $data');
  }

  static void error(dynamic data) {
    _print(_errorCode, '::error:: $data');
  }

  static void _print([AnsiPen code, dynamic data]) {
    print(code(data));
  }
}

enum LogLevel {
  DEBUG,
  INFO,
  WARN,
  ERROR,
  ALL,
}

/// Chooses a color based on the logger [level].
AnsiPen chooseLogColor(LogLevel level) {
  switch (level) {
    case LogLevel.ALL:
      return AnsiPen()..white();
    case LogLevel.DEBUG:
      return AnsiPen()..green();
    case LogLevel.INFO:
      return AnsiPen()..blue();
    case LogLevel.WARN:
      return AnsiPen()..yellow();
    case LogLevel.ERROR:
      return AnsiPen()..red();
    default:
      return AnsiPen()..white();
  }
}
