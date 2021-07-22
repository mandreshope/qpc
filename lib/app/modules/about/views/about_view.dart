import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qpc/app/modules/about/controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  AboutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Apropos'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Developed by mandreshope',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
