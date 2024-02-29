import 'package:app_android_b_0145_24/logic/models/team_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'round_model.g.dart';

@HiveType(typeId: 4)
class RoundModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final TeamModel team;
  @HiveField(2)
  final String name;
  @HiveField(3)
  int points;
  @HiveField(4)
  List<String> listOfUsedWords;
  @HiveField(5)
  String? currentWord;
  @HiveField(6)
  double currentTime;
  @HiveField(7)
  bool isFinished;

  RoundModel({
    required this.id,
    required this.team,
    required this.name,
    this.currentWord,
    this.currentTime = 0,
    this.listOfUsedWords = const [],
    this.points = 0,
    this.isFinished = false,
  });
}
