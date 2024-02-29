import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/logic/models/game_model.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/game/game_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_images.dart';
import 'package:app_android_b_0145_24/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class StartScreen extends BaseScreen {
  final GameModel gameModel;

  const StartScreen({
    super.key,
    required this.gameModel,
  });

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends BaseScreenState<StartScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Image.asset(
            AppImages.imMain,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
          ),
        ),
        const Gap(61),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: AppButton(
            title: 'Start',
            bgColor: AppColors.accentPrimary1,
            bgActiveColor: AppColors.accentSecondary1,
            onPressed: () async {
              await Hive.openBox(kAppStorage).then((value) {
                var game = widget.gameModel;
                game.isGameStarted = true;
                value.put(kLastGame, game);
                AppNavigator.replaceToNextScreen(
                    context, GameScreen(gameModel: game));
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  Color bgColor() {
    return AppColors.layer2;
  }
}
