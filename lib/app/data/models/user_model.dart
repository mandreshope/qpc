import 'package:get/get.dart';

class UserModel {
  final int id;
  final String name;
  RxInt score = 0.obs;

  UserModel({
    required this.id,
    required this.name,
    required this.score,
  });
}
