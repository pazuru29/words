part of 'main_cubit.dart';

abstract class MainState {}

class InitialMainState extends MainState {}

class LoadingMainState extends MainState {}

class LoadedMainState extends MainState {
  final GameModel? gameModel;

  LoadedMainState({
    required this.gameModel,
  });
}
