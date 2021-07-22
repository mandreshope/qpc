import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpc/app/data/models/counter_model.dart';
import 'package:qpc/app/data/models/user_model.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  List<CounterModel> counters = [
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

  CounterModel currentCounterModel = CounterModel(
    id: 4,
    color: Colors.orange,
    delai: 10,
    position: CounterPosition.right.obs,
  );

  RxBool isPlay = false.obs;

  UserModel user1 = UserModel(id: 1, name: "user1", score: 0.obs);
  UserModel user2 = UserModel(id: 1, name: "user2", score: 0.obs);

  TextEditingController user1NameCtrl = TextEditingController();
  TextEditingController user2NameCtrl = TextEditingController();

  void startTimer(CounterModel counterModel) {
    currentCounterModel = counterModel;
    counterModel.state.value = CounterState.start;
    counterModel.controller!.start();
  }

  void permuteCurrentCounterPosition() {
    if (currentCounterModel.position.value == CounterPosition.left) {
      currentCounterModel.position.value = CounterPosition.right;
    } else {
      currentCounterModel.position.value = CounterPosition.left;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void startCounter(CounterModel c) {
    startTimer(c);
  }

  void initCounter() {
    counters = counters = [
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
    currentCounterModel = CounterModel(
      id: 4,
      color: Colors.orange,
      delai: 10,
      position: CounterPosition.right.obs,
    );

    isPlay.value = false;
    update();
  }

  void initScore() {
    user1.score.value = 0;
    user2.score.value = 0;
  }

  void next() {
    final nextCounter =
        counters.where((c) => c.controller?.isCompleted == null).toList();
    final previousCounter =
        counters.where((c) => c.controller?.isCompleted == true).toList();
    previousCounter.last.state.value = CounterState.finish;
    if (nextCounter.isEmpty) {
      isPlay.value = false;
      return;
    }
    startTimer(nextCounter.first);
  }

  void addScore(UserModel user) {
    final isCompleted = currentCounterModel.controller?.isCompleted;
    if (isCompleted != null) {
      if (!isCompleted) {
        user.score.value = user.score.value + currentCounterModel.id;
      }
    }
  }
}
