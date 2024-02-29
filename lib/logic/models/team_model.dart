import 'package:hive/hive.dart';

part 'team_model.g.dart';

@HiveType(typeId: 1)
class TeamModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final List<String> namesOfPlayers;

  TeamModel({
    required this.id,
    required this.name,
    required this.namesOfPlayers,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamModel &&
        other.id == id &&
        other.name == name &&
        other.namesOfPlayers.length == namesOfPlayers.length;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;

  TeamModel copyWith({
    String? id,
    String? name,
    List<String>? namesOfPlayers,
  }) {
    return TeamModel(
      id: id ?? this.id,
      name: name ?? this.name,
      namesOfPlayers: namesOfPlayers ?? this.namesOfPlayers,
    );
  }
}
