import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/logic/models/game_model.dart';
import 'package:app_android_b_0145_24/logic/models/team_model.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/game/second_result_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_images.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FirstResultScreen extends BaseScreen {
  final GameModel gameModel;

  const FirstResultScreen({
    super.key,
    required this.gameModel,
  });

  @override
  State<FirstResultScreen> createState() => _FirstResultScreenState();
}

class _FirstResultScreenState extends BaseScreenState<FirstResultScreen> {
  final Map<String, int> _mapOfTeamPoints = {};

  late TeamModel _bestTeam;
  late int _bestPoints;

  @override
  void initState() {
    _getTeamsPoints();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Image.asset(
            AppImages.imResult1,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(45),
                const AppText(
                  text: 'Good result!',
                  style: AppTextStyles.headerLarge,
                  color: AppColors.textWhite,
                ),
                const Gap(7),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppText(
                    text: _bestTeam.name,
                    style: AppTextStyles.headerSmall,
                    color: AppColors.textWhite,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(20),
                Container(
                  height: 55,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.only(left: 13, right: 15),
                  decoration: BoxDecoration(
                    color: AppColors.layer3,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        text: 'Scored per game',
                        style: AppTextStyles.regular16,
                        color: AppColors.textSecondary,
                      ),
                      AppText(
                        text: '$_bestPoints points',
                        style: AppTextStyles.regular16,
                        color: AppColors.textWhite,
                      ),
                    ],
                  ),
                ),
                const Gap(34),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: AppButton(
                    title: 'Continue',
                    bgColor: AppColors.accentPrimary1,
                    bgActiveColor: AppColors.accentSecondary1,
                    onPressed: () {
                      AppNavigator.replaceToNextScreen(
                          context,
                          SecondResultScreen(
                              gameModel: widget.gameModel,
                              mapOfTeamsPoints: _mapOfTeamPoints));
                    },
                  ),
                ),
                Gap(MediaQuery.paddingOf(context).bottom + 16)
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Color bgColor() {
    return AppColors.layer2;
  }

  void _getTeamsPoints() {
    for (final item in widget.gameModel.listOfRounds) {
      if (_mapOfTeamPoints[item.team.id] != null) {
        _mapOfTeamPoints[item.team.id] =
            _mapOfTeamPoints[item.team.id]! + item.points;
        print("+ ${item.points}");
      } else {
        _mapOfTeamPoints[item.team.id] = item.points;
        print("= ${item.points}");
      }
    }

    _bestTeam = widget.gameModel.listOfTeams.first;
    _bestPoints = _mapOfTeamPoints[widget.gameModel.listOfTeams.first] ?? 0;

    for (final item in widget.gameModel.listOfTeams) {
      if (_mapOfTeamPoints[item.id] != null) {
        if (_mapOfTeamPoints[item.id]! > _bestPoints) {
          _bestTeam = item;
          _bestPoints = _mapOfTeamPoints[item.id]!;
        }
      }
    }
  }
}
