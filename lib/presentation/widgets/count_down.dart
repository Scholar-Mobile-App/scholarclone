import 'dart:async';
import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  final int startSeconds;
  final TextStyle enableTS, disableTS;
  final String? verifyStr;
  final Function(Timer)? onTick;

  /// click callback
  final Function()? onTapCallback;

  const CountDownWidget(
      {super.key,
      this.startSeconds = 60,
      this.onTapCallback,
      this.onTick,
      this.enableTS = const TextStyle(fontSize: 16, color: Color(0xff00ff00)),
      this.disableTS = const TextStyle(fontSize: 16, color: Color(0xff999999)),
      this.verifyStr});

  @override
  _CountDownState createState() {
    return _CountDownState();
  }
}

class _CountDownState extends State<CountDownWidget> {
  Timer? _timer;
  int? _seconds;
  bool _enable = true;

  TextStyle? _inkWellStyle;

  String? _verifyStr;

  @override
  void initState() {
    super.initState();
    _verifyStr = 'Send';
    _seconds = widget.startSeconds;
    _inkWellStyle = widget.enableTS;
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (_enable && (_seconds == widget.startSeconds))
          ? () {
              widget.onTapCallback!();
              _startTimer();
            }
          : null,
      child: Text(
        _verifyStr!,
        style: _inkWellStyle,
      ),
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.startSeconds;
        _verifyStr = 'Resend OTP';
        _enable = true;
        _inkWellStyle = widget.enableTS;
        setState(() {});
        return;
      }

      _enable = false;
      _inkWellStyle = widget.disableTS;
      _seconds = _seconds! - 1;
      _verifyStr = '${_seconds}s';
      setState(() {});
      widget.onTick!(timer);
    });
  }

  void _cancelTimer() {
    _timer!.cancel();
  }
}
