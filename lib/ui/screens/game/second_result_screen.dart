import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/logic/bloc/main_cubit/main_cubit.dart';
import 'package:app_android_b_0145_24/logic/models/game_model.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/app_tab_bar.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_images.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:app_android_b_0145_24/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class SecondResultScreen extends BaseScreen {
  final GameModel gameModel;
  final Map<String, int> mapOfTeamsPoints;

  const SecondResultScreen({
    super.key,
    required this.gameModel,
    required this.mapOfTeamsPoints,
  });

  @override
  State<SecondResultScreen> createState() => _SecondResultScreenState();
}

class _SecondResultScreenState extends BaseScreenState<SecondResultScreen> {
  late final MainCubit _mainCubit;

  List<ResultTeams> _listOfResults = [];

  @override
  void initState() {
    _mainCubit = context.read<MainCubit>();
    _getResults();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Column(
      children: [
        const AppTabBar(title: 'Result', isSecondary: false),
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                const Gap(52),
                const AppText(
                  text: 'Congratulations\non the victory!',
                  style: AppTextStyles.headerLarge,
                  color: AppColors.textWhite,
                  align: TextAlign.center,
                  maxLines: null,
                ),
                const Gap(8),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _listOfResults.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 55,
                      margin: const EdgeInsets.fromLTRB(16, 0, 16, 13),
                      padding: const EdgeInsets.only(left: 13, right: 15),
                      decoration: BoxDecoration(
                        color: AppColors.layer3,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: AppText(
                              text: _listOfResults[index].name,
                              style: AppTextStyles.regular16,
                              color: AppColors.textWhite,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Gap(8),
                          AppText(
                            text: '${_listOfResults[index].points} points',
                            style: AppTextStyles.regular16,
                            color: AppColors.textWhite,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Gap(3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: AppButton(
                    title: 'Menu',
                    bgColor: AppColors.accentPrimary1,
                    bgActiveColor: AppColors.accentSecondary1,
                    onPressed: () async {
                      await Hive.openBox(kAppStorage).then((value) {
                        value.delete(kLastGame);
                        _mainCubit.getInitData();
                        AppNavigator.goBack(context);
                      });
                    },
                  ),
                ),
                const Gap(29),
                Image.asset(
                  AppImages.imResult2,
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).width * 0.84,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Color bgColor() {
    return AppColors.layer3;
  }

  void _getResults() {
    _listOfResults = [];
    for (final item in widget.gameModel.listOfTeams) {
      final tmpResult = ResultTeams(
        name: item.name,
        points: widget.mapOfTeamsPoints[item.id] ?? 0,
      );
      _listOfResults.add(tmpResult);
    }

    _listOfResults.sort((b, a) => a.points.compareTo(b.points));
  }
}

class ResultTeams {
  final String name;
  final int points;

  ResultTeams({
    required this.name,
    required this.points,
  });
}
