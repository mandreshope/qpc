import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:qpc/app/data/models/counter_model.dart';
import 'package:qpc/app/modules/home/controllers/home_controller.dart';
import 'package:qpc/app/routes/app_pages.dart';
import 'package:timer_count_down/timer_count_down.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton(
          onSelected: (v) {
            if (v == 0) {
              controller.initCounter();
            } else if (v == 1) {
              controller.initScore();
            } else {
              Get.toNamed(Routes.ABOUT);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Réinitialiser le compte à rebours'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Réinitialiser les scores'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('A propos'),
              )
            ];
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/images/samson.jpg", fit: BoxFit.cover),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * .4,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: controller.user1NameCtrl,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 45),
                        decoration: InputDecoration(
                          hintText: "user1",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: Get.width * .4,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: controller.user2NameCtrl,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 45),
                        decoration: InputDecoration(
                          hintText: "user2",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: Get.width * .2,
            right: Get.width * .2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => InkWell(
                    onTap: controller.isPlay.value
                        ? null
                        : () {
                            controller.addScore(controller.user1);
                          },
                    child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "${controller.user1.score.value}",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.grey[200])),
                    onPressed: () {
                      controller.isPlay.value = !controller.isPlay.value;
                      final c = controller.counters.firstWhere(
                          (c) => controller.currentCounterModel.id == c.id);

                      if (controller.isPlay.value) {
                        controller.startCounter(c);
                        controller.permuteCurrentCounterPosition();
                      } else {
                        c.controller!.pause();
                      }
                    },
                    child: Obx(
                      () => Icon(
                        !controller.isPlay.value
                            ? Icons.play_arrow
                            : Icons.pause,
                        color: Colors.grey[600],
                      ),
                    )),
                Obx(
                  () => InkWell(
                    onTap: controller.isPlay.value
                        ? null
                        : () {
                            controller.addScore(controller.user2);
                          },
                    child: Container(
                      width: 100,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "${controller.user2.score.value}",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: GetBuilder<HomeController>(
              init: controller,
              builder: (_) => Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.counters
                      .map(
                        (counter) => counter.state.value == CounterState.init
                            ? Container(
                                margin: counter.position.value ==
                                        CounterPosition.left
                                    ? EdgeInsets.only(
                                        bottom: 1, right: 50, left: 0)
                                    : EdgeInsets.only(
                                        bottom: 1, right: 0, left: 50),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.orange,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "${counter.id}",
                                    style: TextStyle(
                                      fontSize: 60,
                                      color: Colors.black.withOpacity(0.5),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: counter.position.value ==
                                        CounterPosition.left
                                    ? EdgeInsets.only(
                                        bottom: 1, right: 50, left: 0)
                                    : EdgeInsets.only(
                                        bottom: 1, right: 0, left: 50),
                                height: 120,
                                width: 120,
                                child: Countdown(
                                  seconds: counter.delai,
                                  controller: counter.controller,
                                  build: (BuildContext context, double time) =>
                                      LiquidCircularProgressIndicator(
                                    value: ((time * 1) / counter.delai) == 0.0
                                        ? -1
                                        : ((time * 1) /
                                            counter.delai), // Defaults to 0.5.
                                    valueColor: AlwaysStoppedAnimation(
                                      counter.color,
                                    ),
                                    backgroundColor:
                                        Get.theme.scaffoldBackgroundColor,
                                    borderColor: Colors.white,
                                    borderWidth: 5,
                                    direction: Axis.vertical,
                                    center: Text(
                                      "${counter.id}",
                                      style: TextStyle(
                                        fontSize: 60,
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  interval: Duration(milliseconds: 100),
                                  onFinished: () {
                                    counter.controller!.isCompleted = true;

                                    controller.next();
                                  },
                                ),
                              ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
