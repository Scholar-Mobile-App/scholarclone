import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? resumeCallBack;
  final AsyncCallback? suspendingCallBack;

  LifecycleEventHandler({
    this.resumeCallBack,
    this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        log("Resumed.........");
        await resumeCallBack!();
        break;
      case AppLifecycleState.inactive:
        log("Inactive.........");
        break;
      case AppLifecycleState.hidden:
        log("Hidden.........");
        break;
      case AppLifecycleState.paused:
        log("Paused.........");
        break;
      case AppLifecycleState.detached:
        log("Detached.........");
        await suspendingCallBack!();
        break;
    }
  }
}
