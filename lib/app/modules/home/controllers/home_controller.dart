import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpc/app/data/models/counter_model.dart';
import 'package:qpc/app/data/models/user_model.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  List<CounterModel> counters = [
    CounterModel(id: 4, color: Colors.orange),
    CounterModel(id: 3, color: Colors.orange),
    CounterModel(id: 2, color: Colors.orange),
    CounterModel(id: 1, color: Colors.red),
  ];

  CounterModel currentCounterModel = CounterModel(id: 4, color: Colors.blue);

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

  void init() {
    user1NameCtrl.text = "";
    user2NameCtrl.text = "";

    counters = [
      CounterModel(id: 4, color: Colors.orange),
      CounterModel(id: 3, color: Colors.orange),
      CounterModel(id: 2, color: Colors.orange),
      CounterModel(id: 1, color: Colors.red),
    ];

    user1.score.value = 0;
    user2.score.value = 0;
    isPlay.value = false;
    update();
  }

  void next() {
    final founds =
        counters.where((c) => c.controller?.isCompleted == null).toList();
    if (founds.isEmpty) {
      isPlay.value = false;
      return;
    }
    startTimer(founds.first);
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
