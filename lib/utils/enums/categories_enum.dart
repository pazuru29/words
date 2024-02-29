import 'package:hive/hive.dart';

part 'categories_enum.g.dart';

@HiveType(typeId: 3)
enum CategoriesEnum {
  @HiveField(0)
  football,
  @HiveField(1)
  basketball,
  @HiveField(2)
  baseball,
  @HiveField(3)
  rugby,
  @HiveField(4)
  hockey,
}

extension CategoriesEnumExtension on CategoriesEnum {
  String getString() {
    switch (this) {
      case CategoriesEnum.football:
        return 'Football';
      case CategoriesEnum.basketball:
        return 'Basketball';
      case CategoriesEnum.baseball:
        return 'Baseball';
      case CategoriesEnum.rugby:
        return 'Rugby';
      case CategoriesEnum.hockey:
        return 'Hockey';
    }
  }
}
