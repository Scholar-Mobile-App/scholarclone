import 'package:flutter/material.dart';

import 'counter_storage.dart';

Future<int> getNotificationCounter() async {
  final counterStorage = CounterStorage();
  int a = await counterStorage.readCounter();
  return a;
}

incrementNotificationCounter() {
  var counterStorage = CounterStorage();
  counterStorage.readCounter().then((count) async {
    int counter = 0;
    try {
      counter = int.parse(count.toString()) + 1;
    } catch (e) {
      counter = 0;
    }
    counterStorage.writeCounter(counter);
  });
}

clearNotificationCount() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    var counterStorage = CounterStorage();
    counterStorage.writeCounter(0);
  });
}
