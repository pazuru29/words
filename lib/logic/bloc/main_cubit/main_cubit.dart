import 'package:app_android_b_0145_24/logic/models/game_model.dart';
import 'package:app_android_b_0145_24/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitialMainState());

  void getInitData() async {
    emit(LoadingMainState());
    await Hive.openBox(kAppStorage).then((value) {
      GameModel? lastGame = value.get(kLastGame);
      print(lastGame);
      emit(LoadedMainState(gameModel: lastGame));
    });
  }
}
