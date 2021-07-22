import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer_count_down/timer_controller.dart';

class CounterModel {
  final int id;
  Rx<CounterState> state = CounterState.init.obs;
  final Color color;
  final int delai; //in second
  Rx<CounterPosition> position = CounterPosition.right.obs;
  CountdownController? controller = CountdownController(autoStart: true);

  CounterModel({
    required this.id,
    required this.color,
    required this.delai,
    required this.position,
  });
}

enum CounterPosition { right, left }

enum CounterState {
  init,
  start,
  finish,
  pause,
}
