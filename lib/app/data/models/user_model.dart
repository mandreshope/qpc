import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UserModel {
  final int id;
  final String name;
  RxInt score = 0.obs;
  TextEditingController scoreCtrl = TextEditingController(text: "0");

  UserModel({
    required this.id,
    required this.name,
    required this.score,
  });
}
