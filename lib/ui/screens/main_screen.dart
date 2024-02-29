import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/logic/bloc/main_cubit/main_cubit.dart';
import 'package:app_android_b_0145_24/logic/models/game_model.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/game/game_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/game/start_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/new_game_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/rules_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/settings_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class MainScreen extends BaseScreen {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreenState<MainScreen> {
  late final MainCubit _mainCubit;

  GameModel? _lastGame;

  @override
  void initState() {
    _mainCubit = context.read<MainCubit>();
    _mainCubit.getInitData();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        setState(() {
          if (state is LoadedMainState) {
            _lastGame = state.gameModel;
          }
        });
      },
      child: Column(
        children: [
          Flexible(
            child: Image.asset(
              AppImages.imMain,
              width: MediaQuery.sizeOf(context).width,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          const Gap(36),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                AppButton(
                  title: 'Continue',
                  bgColor: AppColors.accentPrimary1,
                  bgActiveColor: AppColors.accentSecondary1,
                  onPressed: _lastGame != null
                      ? () {
                          if (_lastGame!.isGameStarted) {
                            AppNavigator.goToNextScreen(
                                context, GameScreen(gameModel: _lastGame!));
                          } else {
                            AppNavigator.goToNextScreen(
                                context, StartScreen(gameModel: _lastGame!));
                          }
                        }
                      : null,
                ),
                const Gap(13),
                AppButton(
                  title: 'New game',
                  bgColor: AppColors.accentPrimary1,
                  bgActiveColor: AppColors.accentSecondary1,
                  onPressed: () {
                    AppNavigator.goToNextScreen(context, const NewGameScreen());
                  },
                ),
                const Gap(13),
                AppButton(
                  title: 'Profile',
                  bgColor: AppColors.accentPrimary1,
                  bgActiveColor: AppColors.accentSecondary1,
                  onPressed: () {
                    AppNavigator.goToNextScreen(
                        context, const SettingsScreen());
                  },
                ),
                const Gap(13),
                AppButton(
                  title: 'Rules',
                  bgColor: AppColors.accentPrimary1,
                  bgActiveColor: AppColors.accentSecondary1,
                  onPressed: () {
                    AppNavigator.goToNextScreen(context, const RulesScreen());
                  },
                ),
                Gap(MediaQuery.sizeOf(context).height / 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Color bgColor() {
    return AppColors.layer2;
  }
}
