import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpc/app/data/models/counter_model.dart';

class DataProvider {
  List<CounterModel> leftCounters = [
    CounterModel(
      id: 4,
      color: Colors.orange,
      delai: 10,
      position: CounterPosition.left.obs,
    ),
    CounterModel(
      id: 3,
      color: Colors.orange,
      delai: 5,
      position: CounterPosition.right.obs,
    ),
    CounterModel(
      id: 2,
      color: Colors.orange,
      delai: 3,
      position: CounterPosition.left.obs,
    ),
    CounterModel(
      id: 1,
      color: Colors.red,
      delai: 2,
      position: CounterPosition.right.obs,
    ),
  ];

  List<CounterModel> rightCounters = [
    CounterModel(
      id: 4,
      color: Colors.orange,
      delai: 10,
      position: CounterPosition.right.obs,
    ),
    CounterModel(
      id: 3,
      color: Colors.orange,
      delai: 5,
      position: CounterPosition.left.obs,
    ),
    CounterModel(
      id: 2,
      color: Colors.orange,
      delai: 3,
      position: CounterPosition.right.obs,
    ),
    CounterModel(
      id: 1,
      color: Colors.red,
      delai: 2,
      position: CounterPosition.left.obs,
    ),
  ];
}
