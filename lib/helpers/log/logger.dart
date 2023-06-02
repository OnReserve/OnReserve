import 'package:logger/logger.dart';

logger(Type type) => Logger(
    printer: OnReservePrinter(className: type.toString()),
    level: Level.verbose);

class OnReservePrinter extends LogPrinter {
  final String className;

  OnReservePrinter({required this.className});

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final messageStr = event.message.toString();
    final errorStr = event.error?.toString();
    final stackTraceStr = event.stackTrace?.toString();
    final message = messageStr.isNotEmpty ? messageStr : errorStr;

    return [color!('$emoji $className : $message'), stackTraceStr ?? ''];
  }
}
