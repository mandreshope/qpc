import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:qpc/app/data/models/counter_model.dart';
import 'package:qpc/app/modules/home/controllers/home_controller.dart';
import 'package:qpc/app/modules/home/views/liquid_custom_progress_indicator_view.dart';
import 'package:qpc/app/routes/app_pages.dart';
import 'package:timer_count_down/timer_count_down.dart';

class ControllerIntent extends Intent {
  const ControllerIntent();
}

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.space): const ControllerIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ControllerIntent: CallbackAction<ControllerIntent>(
            onInvoke: (ControllerIntent intent) {
              controller.controll();
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: Scaffold(
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
                  child: Image.asset("assets/images/samson.jpg",
                      fit: BoxFit.cover),
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
                                hintText: "timer en seconde",
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
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.grey[200]!.withOpacity(0.1)),
                        ),
                        onPressed: () {
                          controller.user1Answer();
                        },
                        child: Icon(
                          Icons.question_answer,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                      // ElevatedButton(
                      //   style: ButtonStyle(
                      //     elevation: MaterialStateProperty.all(0),
                      //     backgroundColor: MaterialStateProperty.all(
                      //         Colors.grey[200]!.withOpacity(0.1)),
                      //   ),
                      //   onPressed: () {
                      //     controller.user2Answer();
                      //   },
                      //   child: Icon(
                      //     Icons.question_answer,
                      //     color: Colors.white.withOpacity(0.5),
                      //   ),
                      // ),
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
                        () => Row(
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.grey[200]!.withOpacity(0.1)),
                              ),
                              onPressed: controller.isPlay.value
                                  ? null
                                  : () {
                                      controller.addScore(controller.user1);
                                    },
                              child: Icon(
                                Icons.add,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(60),
                              ),
                              child: TextField(
                                controller: controller.user1.scoreCtrl,
                                inputFormatters: [controller.formatter],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 45, color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor: MaterialStateProperty.all(
                              Colors.grey[200]!.withOpacity(0.1)),
                        ),
                        onPressed: () {
                          controller.controll();
                        },
                        child: Obx(
                          () => Icon(
                            !controller.isPlay.value
                                ? Icons.play_arrow
                                : Icons.pause,
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ),
                      // Obx(
                      //   () => Row(
                      //     children: [
                      //       Container(
                      //         width: 100,
                      //         decoration: BoxDecoration(
                      //           color: Colors.orange,
                      //           borderRadius: BorderRadius.circular(60),
                      //         ),
                      //         child: TextField(
                      //           controller: controller.user2.scoreCtrl,
                      //           inputFormatters: [controller.formatter],
                      //           textAlign: TextAlign.center,
                      //           style: TextStyle(
                      //               fontSize: 45, color: Colors.white),
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //           ),
                      //         ),
                      //       ),
                      //       ElevatedButton(
                      //         style: ButtonStyle(
                      //           elevation: MaterialStateProperty.all(0),
                      //           backgroundColor: MaterialStateProperty.all(
                      //               Colors.grey[200]!.withOpacity(0.1)),
                      //         ),
                      //         onPressed: controller.isPlay.value
                      //             ? null
                      //             : () {
                      //                 controller.addScore(controller.user2);
                      //               },
                      //         child: Icon(
                      //           Icons.add,
                      //           color: Colors.white.withOpacity(0.5),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                GetBuilder<HomeController>(builder: (_) {
                  return Center(
                    child: Container(
                      height: 200,
                      color: Colors.black45,
                      child: Center(
                        child: CountdownTimer(
                          controller: controller.controller,
                          endTime: controller.endTime,
                          textStyle: TextStyle(
                              fontSize: 150,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          onEnd: () {},
                        ),
                      ),
                    ),
                  );
                }),
                // Center(
                //   child: GetBuilder<HomeController>(
                //     init: controller,
                //     builder: (_) => Obx(
                //       () => Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: controller.counters
                //             .map(
                //               (counter) => counter.state.value ==
                //                       CounterState.init
                //                   ? Container(
                //                       margin: counter.position.value ==
                //                               CounterPosition.left
                //                           ? EdgeInsets.only(
                //                               bottom: 1, right: 50, left: 0)
                //                           : EdgeInsets.only(
                //                               bottom: 1, right: 0, left: 50),
                //                       height: 120,
                //                       width: 120,
                //                       decoration: BoxDecoration(
                //                         color: Colors.orange,
                //                         border: Border.all(
                //                           color: Colors.white,
                //                           width: 5,
                //                         ),
                //                       ),
                //                       child: Center(
                //                         child: Text(
                //                           "${counter.id}",
                //                           style: TextStyle(
                //                             fontSize: 60,
                //                             color: Colors.black,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                         ),
                //                       ),
                //                     )
                //                   : Container(
                //                       margin: counter.position.value ==
                //                               CounterPosition.left
                //                           ? EdgeInsets.only(
                //                               bottom: 1, right: 50, left: 0)
                //                           : EdgeInsets.only(
                //                               bottom: 1, right: 0, left: 50),
                //                       height: 120,
                //                       width: 120,
                //                       child: Countdown(
                //                         seconds: counter.delai,
                //                         controller: counter.controller,
                //                         build: (BuildContext context,
                //                                 double time) =>
                //                             LiquidCustomProgressIndicatorView(
                //                           value: ((time * 1) / counter.delai) ==
                //                                   0.0
                //                               ? -1
                //                               : ((time * 1) / counter.delai),
                //                           valueColor: AlwaysStoppedAnimation(
                //                             counter.color,
                //                           ),
                //                           backgroundColor:
                //                               Get.theme.scaffoldBackgroundColor,
                //                           direction: Axis.vertical,
                //                           center: Text(
                //                             "${counter.id}",
                //                             style: TextStyle(
                //                               fontSize: 60,
                //                               color: Colors.black,
                //                               fontWeight: FontWeight.bold,
                //                             ),
                //                           ),
                //                         ),
                //                         interval: Duration(milliseconds: 100),
                //                         onFinished: () {
                //                           counter.controller!.isCompleted =
                //                               true;

                //                           controller.next();
                //                         },
                //                       ),
                //                     ),
                //             )
                //             .toList(),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
