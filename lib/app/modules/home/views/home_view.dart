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
              controller.init();
            } else {
              Get.toNamed(Routes.ABOUT);
            }
          },
          itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text('Réinitialiser'),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text('A propos'),
              )
            ];
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: Get.width * .4,
                  child: Center(
                    child: TextField(
                      controller: controller.user1NameCtrl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                      decoration: InputDecoration(
                        hintText: "user1",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: Get.height,
                  color: Colors.grey[300],
                ),
                Container(
                  width: Get.width * .4,
                  child: Center(
                    child: TextField(
                      controller: controller.user2NameCtrl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 40),
                      decoration: InputDecoration(
                        hintText: "user2",
                        border: InputBorder.none,
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
                        color: Colors.orange,
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
                        color: Colors.orange,
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
                                margin: EdgeInsets.all(2),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.orange,
                                ),
                                child: Center(
                                  child: Text(
                                    "${counter.id}",
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.all(2),
                                height: 120,
                                width: 120,
                                child: Countdown(
                                  seconds: 10,
                                  controller: counter.controller,
                                  build: (BuildContext context, double time) =>
                                      LiquidCircularProgressIndicator(
                                    value: ((time * 1) / 10) == 0.0
                                        ? -1
                                        : ((time * 1) / 10), // Defaults to 0.5.
                                    valueColor: AlwaysStoppedAnimation(
                                      counter.color,
                                    ),
                                    backgroundColor:
                                        Get.theme.scaffoldBackgroundColor,
                                    borderColor: counter.color,
                                    borderWidth: 1,
                                    direction: Axis.vertical,
                                    center: Text(
                                      "${counter.id}",
                                      style: TextStyle(
                                        fontSize: 40,
                                        color: Colors.black,
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
