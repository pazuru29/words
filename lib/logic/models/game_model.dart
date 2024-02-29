import 'package:app_android_b_0145_24/logic/models/round_model.dart';
import 'package:app_android_b_0145_24/logic/models/team_model.dart';
import 'package:app_android_b_0145_24/utils/enums/categories_enum.dart';
import 'package:hive/hive.dart';

part 'game_model.g.dart';

@HiveType(typeId: 2)
class GameModel {
  @HiveField(0)
  final List<CategoriesEnum> listOfKeysWords;
  @HiveField(1)
  final List<TeamModel> listOfTeams;
  @HiveField(2)
  final int timeOfRound;
  @HiveField(3)
  final List<RoundModel> listOfRounds;
  @HiveField(4)
  bool isGameStarted;

  GameModel({
    required this.listOfKeysWords,
    required this.listOfTeams,
    required this.timeOfRound,
    required this.listOfRounds,
    this.isGameStarted = false,
  });
}
