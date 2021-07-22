import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';

class CounterModel {
  final int id;
  Rx<CounterState> state = CounterState.init.obs;
  final Color color;
  CountdownController? controller = CountdownController(autoStart: true);

  CounterModel({
    required this.id,
    required this.color,
  });
}

enum CounterState {
  init,
  start,
  finish,
  pause,
}
