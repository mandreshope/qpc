import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qpc/app/data/models/counter_model.dart';
import 'package:qpc/app/data/models/user_model.dart';
import 'package:qpc/app/data/providers/data_provider.dart';
import 'package:qpc/app/utils/currency_formatter.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  Player player = Player(id: 69420);
  Media chrono = Media.asset("assets/chrono.mp3");

  List<CounterModel> counters = DataProvider().rightCounters;

  final CustomTextInputFormatter formatter = CustomTextInputFormatter(
    separator: " ",
    decimalSeparator: ",",
  );

  CounterModel currentCounterModel = CounterModel(
    id: 4,
    color: Colors.orange,
    delai: 10,
    position: CounterPosition.right.obs,
  );

  RxBool isPlay = false.obs;
  bool isFirstPlay = true;

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
    if (!isFirstPlay) {
      if (currentCounterModel.position.value == CounterPosition.left) {
        currentCounterModel.position.value = CounterPosition.right;
      } else {
        currentCounterModel.position.value = CounterPosition.left;
      }
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

  void initCounter({CounterPosition? firstPosition}) {
    switch (firstPosition) {
      case CounterPosition.left:
        counters = DataProvider().leftCounters;
        currentCounterModel = CounterModel(
          id: 4,
          color: Colors.orange,
          delai: 10,
          position: CounterPosition.left.obs,
        );
        break;
      case CounterPosition.right:
        counters = DataProvider().rightCounters;
        currentCounterModel = CounterModel(
          id: 4,
          color: Colors.orange,
          delai: 10,
          position: CounterPosition.right.obs,
        );
        break;
      default:
        counters = DataProvider().rightCounters;
        currentCounterModel = CounterModel(
          id: 4,
          color: Colors.orange,
          delai: 10,
          position: CounterPosition.right.obs,
        );
    }

    isPlay.value = false;
    isFirstPlay = true;
    player.stop();
    update();
  }

  void controll() {
    isPlay.value = !isPlay.value;
    final c = counters.firstWhere((c) => currentCounterModel.id == c.id);

    if (isPlay.value) {
      player.open(
        Playlist(
          playlistMode: PlaylistMode.loop,
          medias: [
            chrono,
            chrono,
            chrono,
            chrono,
            chrono,
            chrono,
          ],
        ),
        autoStart: true, // default
      );
      startCounter(c);
      permuteCurrentCounterPosition();
      isFirstPlay = false;
    } else {
      player.pause();
      c.controller!.pause();
    }
  }

  void initScore() {
    user1.score.value = 0;
    user1.scoreCtrl.text = "0";
    user2.score.value = 0;
    user2.scoreCtrl.text = "0";
  }

  void user1Answer() {
    initCounter(
      firstPosition: CounterPosition.left,
    );
  }

  void user2Answer() {
    initCounter(
      firstPosition: CounterPosition.right,
    );
  }

  void next() {
    final nextCounter =
        counters.where((c) => c.controller?.isCompleted == null).toList();
    final previousCounter =
        counters.where((c) => c.controller?.isCompleted == true).toList();
    previousCounter.last.state.value = CounterState.finish;
    if (nextCounter.isEmpty) {
      isPlay.value = false;
      player.stop();
      return;
    }
    startTimer(nextCounter.first);
  }

  void addScore(UserModel user) {
    if (user.scoreCtrl.text.isEmpty) {
      return;
    }
    int score = formatter.parse(user.scoreCtrl.text)?.toInt() ?? 0;
    final isCompleted = currentCounterModel.controller?.isCompleted;
    if (isCompleted != null) {
      if (!isCompleted) {
        user.score.value = score + currentCounterModel.id;
        user.scoreCtrl.text = user.score.value.toString();
      }
    }
  }
}
