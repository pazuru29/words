part of 'settings_cubit.dart';

abstract class SettingsState {}

class InitialSettingsState extends SettingsState {}

class LoadingSettingsState extends SettingsState {}

class LoadedSettingsState extends SettingsState {
  final UserModel userModel;

  LoadedSettingsState({
    required this.userModel,
  });
}
