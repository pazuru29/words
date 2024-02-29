import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/logic/models/game_model.dart';
import 'package:app_android_b_0145_24/logic/models/round_model.dart';
import 'package:app_android_b_0145_24/logic/models/team_model.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/app_tab_bar.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/ui/components/settings_button.dart';
import 'package:app_android_b_0145_24/ui/screens/categories_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/game/start_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/new_team_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:app_android_b_0145_24/utils/constants.dart';
import 'package:app_android_b_0145_24/utils/enums/categories_enum.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:collection/collection.dart';
import 'package:hive/hive.dart';

class NewGameScreen extends BaseScreen {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends BaseScreenState<NewGameScreen> {
  bool _isLoading = false;

  double _duration = 60;
  double _round = 1;

  List<CategoriesEnum> _listOfKeys = [
    CategoriesEnum.football,
    CategoriesEnum.basketball,
    CategoriesEnum.baseball,
    CategoriesEnum.rugby,
    CategoriesEnum.hockey,
  ];

  final List<TeamModel> _listOfTeams = [
    TeamModel(
      id: UniqueKey().toString(),
      name: 'Best team',
      namesOfPlayers: ['', ''],
    ),
    TeamModel(
      id: UniqueKey().toString(),
      name: 'Wow team',
      namesOfPlayers: ['', ''],
    ),
  ];

  @override
  Widget buildMain(BuildContext context) {
    return Column(
      children: [
        const AppTabBar(title: 'New game'),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom + 16),
            child: Column(
              children: [
                const Gap(11),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _categoriesWidget(),
                ),
                const Gap(19),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _teamsWidget(),
                ),
                const Gap(19),
                _settingsWidget(),
                const Gap(93),
                Column(
                  children: [
                    if (_isLoading) const CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: AppButton(
                        title: 'Start the game',
                        bgColor: AppColors.accentPrimary1,
                        bgActiveColor: AppColors.accentSecondary1,
                        onPressed: _getActiveButton()
                            ? () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                await Hive.openBox(kAppStorage).then((value) {
                                  final game = GameModel(
                                    listOfKeysWords: _listOfKeys,
                                    listOfTeams: _listOfTeams,
                                    timeOfRound: _duration.toInt(),
                                    listOfRounds: _getListOfRounds(),
                                  );
                                  value.put(kLastGame, game);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  AppNavigator.replaceToNextScreen(
                                      context, StartScreen(gameModel: game));
                                });
                              }
                            : null,
                      ),
                    ),
                  ],
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

  Widget _categoriesWidget() {
    String title = '';
    for (final item in _listOfKeys) {
      title = '$title${item.getString()}, ';
    }
    title = title.replaceRange(title.length - 2, null, '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: 'Categories',
          style: AppTextStyles.regular14,
          color: AppColors.textSecondary,
        ),
        const Gap(6),
        SettingsButton(
          title: title,
          bgColor: AppColors.layer3,
          onPressed: () {
            AppNavigator.goToNextScreen(
              context,
              CategoriesScreen(
                keyOfWordList: _listOfKeys,
                onChangeList: (value) {
                  setState(() {
                    _listOfKeys = value;
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _teamsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: 'Teams',
          style: AppTextStyles.regular14,
          color: AppColors.textSecondary,
        ),
        const Gap(6),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _listOfTeams.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: SettingsButton(
                title: _listOfTeams[index].name,
                bgColor: AppColors.layer3,
                onPressed: () {
                  AppNavigator.goToNextScreen(
                    context,
                    NewTeamScreen(
                      teamModel: _listOfTeams[index]
                          .copyWith(id: UniqueKey().toString()),
                      onTeamSave: (newTeam) {
                        setState(() {
                          _listOfTeams[index] = newTeam;
                        });
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
        const Gap(5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Expanded(
                child: AppButton(
                  title: '- Remove',
                  bgColor: AppColors.tertiaryPink,
                  bgActiveColor: const Color(0xFFFB94AB),
                  onPressed: _listOfTeams.length > 2
                      ? () {
                          setState(() {
                            _listOfTeams.removeLast();
                          });
                        }
                      : null,
                ),
              ),
              const Gap(16),
              Expanded(
                child: AppButton(
                  title: '+ Add',
                  bgColor: AppColors.accentPrimary1,
                  bgActiveColor: AppColors.accentSecondary1,
                  onPressed: _listOfTeams.length < 5
                      ? () {
                          AppNavigator.goToNextScreen(
                            context,
                            NewTeamScreen(
                              onTeamSave: (newTeam) {
                                setState(() {
                                  _listOfTeams.add(newTeam);
                                });
                              },
                            ),
                          );
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _settingsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: AppText(
            text: 'Settings',
            style: AppTextStyles.regular14,
            color: AppColors.textSecondary,
          ),
        ),
        const Gap(6),
        _sliderWidget(
          'Game duration',
          'sec',
          _duration,
          25,
          300,
          27,
          (value) {
            setState(() {
              // 85 - 130 => -1
              // 135 - 190 => -2
              // 195 - 240 => -3
              // 245 - 290 => -4
              if (value > 85 && value < 130) {
                _duration = (value - 1);
              } else if (value > 135 && value < 190) {
                _duration = (value - 2);
              } else if (value > 195 && value < 240) {
                _duration = (value - 3);
              } else if (value > 245 && value < 290) {
                _duration = (value - 4);
              } else {
                _duration = value;
              }
            });
          },
        ),
        const Gap(19),
        _sliderWidget(
          'Number of rounds',
          '',
          _round,
          1,
          5,
          4,
          (value) {
            setState(() {
              _round = value;
            });
          },
        ),
      ],
    );
  }

  Widget _sliderWidget(
    String title,
    String subtitle,
    double value,
    double minValue,
    double maxValue,
    int step,
    Function(double) onValueChange,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.only(left: 13, right: 15),
            height: 55,
            decoration: BoxDecoration(
              color: AppColors.layer3,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: title,
                  style: AppTextStyles.regular16,
                  color: AppColors.textSecondary,
                ),
                Row(
                  children: [
                    AppText(
                      text: '${value.toInt()}',
                      style: AppTextStyles.regular16,
                      color: AppColors.textWhite,
                    ),
                    if (subtitle.isNotEmpty)
                      AppText(
                        text: ' $subtitle',
                        style: AppTextStyles.regular16,
                        color: AppColors.textWhite,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Gap(6),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            valueIndicatorTextStyle: const TextStyle(color: AppColors.textBody),
          ),
          child: Slider(
            inactiveColor: AppColors.accentSecondary2,
            divisions: step,
            max: maxValue,
            min: minValue,
            label: '${value.toInt()}',
            value: value.toDouble(),
            onChanged: (value) {
              onValueChange(value);
            },
          ),
        ),
      ],
    );
  }

  bool _getActiveButton() {
    bool isButtonActive = true;

    for (final item in _listOfTeams) {
      bool hasEmptyName = item.namesOfPlayers
              .firstWhereOrNull((e) => e.trimLeft().trimRight().isEmpty) !=
          null;
      if (hasEmptyName) {
        isButtonActive = false;
        break;
      }
    }

    return isButtonActive;
  }

  int _getMaxRounds() {
    int maxCount = _listOfTeams.first.namesOfPlayers.length;

    for (final item in _listOfTeams) {
      if (maxCount < item.namesOfPlayers.length) {
        maxCount = item.namesOfPlayers.length;
      }
    }

    return maxCount;
  }

  List<RoundModel> _getListOfRounds() {
    List<RoundModel> finalList = [];
    int countRepeat = _round.toInt();
    int maxRoundsForOneTeam = _getMaxRounds() * countRepeat;

    for (var i = 0; i < maxRoundsForOneTeam; i++) {
      for (final item in _listOfTeams) {
        int indexOfPlayer = i % item.namesOfPlayers.length;
        final round = RoundModel(
          id: UniqueKey().toString(),
          team: item,
          name: item.namesOfPlayers[indexOfPlayer],
        );

        finalList.add(round);
        print(
            "Add $i, name of player: ${round.name}, team: ${round.team.name}, isFinished: ${round.isFinished}");
      }
    }

    return finalList;
  }
}
