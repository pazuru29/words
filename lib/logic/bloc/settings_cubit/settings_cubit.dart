import 'dart:io';
import 'dart:typed_data';

import 'package:app_android_b_0145_24/logic/models/user_model.dart';
import 'package:app_android_b_0145_24/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(InitialSettingsState());

  void getInitData() async {
    emit(LoadingSettingsState());
    await Hive.openBox(kAppStorage).then((value) {
      final userModel = value.get(kUserModel, defaultValue: UserModel());
      emit(LoadedSettingsState(userModel: userModel));
    });
  }

  void changeUserModel(UserModel newUserModel) async {
    emit(LoadingSettingsState());
    await Hive.openBox(kAppStorage).then((value) {
      value.put(kUserModel, newUserModel);
      emit(LoadedSettingsState(userModel: newUserModel));
    });
  }

  Future<Uint8List?> getPhoto() async {
    File file;
    Uint8List? bytes;
    final ImagePicker picker = ImagePicker();
    //pick image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      file = File(image.path);
      bytes = await file.readAsBytes();
    }
    return bytes;
  }
}
