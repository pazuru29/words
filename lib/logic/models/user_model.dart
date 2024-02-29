import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String name;
  @HiveField(1)
  Uint8List? image;

  UserModel({
    this.name = 'Username',
    this.image,
  });
}
