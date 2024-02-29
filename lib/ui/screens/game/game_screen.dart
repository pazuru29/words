import 'dart:async';
import 'dart:math';

import 'package:app_android_b_0145_24/data/app_storage.dart';
import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/logic/models/game_model.dart';
import 'package:app_android_b_0145_24/logic/models/round_model.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/ui/components/shape_painter.dart';
import 'package:app_android_b_0145_24/ui/screens/game/first_result_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_icons.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:app_android_b_0145_24/utils/constants.dart';
import 'package:app_android_b_0145_24/utils/enums/categories_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';

class GameScreen extends BaseScreen {
  final GameModel gameModel;

  const GameScreen({
    super.key,
    required this.gameModel,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends BaseScreenState<GameScreen>
    with WidgetsBindingObserver {
  late Timer _timer;
  double _currentTime = 0;

  late GameModel game;
  late RoundModel? _roundModel;
  List<String> _listOfAllWords = [];

  bool _isPaused = true;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    debugPrint(state.name);
    //Save time to storage
    if (state == AppLifecycleState.paused) {
      setState(() {
        _isPaused = true;
      });
      double currentTime = _currentTime;
      await Hive.openBox(kAppStorage).then((value) {
        game.listOfRounds
            .firstWhere((element) => element.id == _roundModel?.id)
            .currentTime = currentTime;

        // _roundModel?.currentTime = currentTime;

        value.put(kLastGame, game);

        debugPrint("Time save to storage");
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    // Observer for app state
    WidgetsBinding.instance.addObserver(this);

    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!_isPaused) {
        setState(() {
          _currentTime += 1;
          debugPrint(_currentTime.toString());
          if (_currentTime >= game.timeOfRound) {
            _isPaused = true;
            _currentTime = 0;
            _getNextRound();
            debugPrint('Next Round');
          }
        });
      }
    });

    _getAllWords();
    game = widget.gameModel;
    print("game rounds: ${game.listOfRounds.length}");
    _getCurrentRound();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget buildMain(BuildContext context) {
    if (_roundModel == null) {
      return _loadingWidget();
    } else {
      return _body();
    }
  }

  Widget _wordWidget() {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.sizeOf(context).width - 120,
      child: Column(
        children: [
          Container(
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: const BoxDecoration(
              color: AppColors.layer3,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          ),
          Container(
            height: 13,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: AppColors.layer2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
          ),
          Container(
            height: MediaQuery.sizeOf(context).width - 148,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.accentSecondary2,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: AppText(
                text:
                    _roundModel?.currentWord ?? 'Tap play\nto start the round',
                style: AppTextStyles.headerLarge,
                color: AppColors.textBody,
                maxLines: null,
                align: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getTime() {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_roundModel!.currentWord == null) {
            _getCurrentWord();
          }
          _isPaused = !_isPaused;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            const AppText(
              text: 'Time',
              style: AppTextStyles.regular14,
              color: AppColors.textSecondary,
            ),
            const Gap(10),
            SizedBox(
              height: 72,
              width: 72,
              child: Stack(
                children: [
                  RotatedBox(
                    quarterTurns: -45,
                    child: CustomPaint(
                      key: UniqueKey(),
                      size: const Size(72, 72),
                      painter: ShapePainter(
                          rate: (game.timeOfRound - _currentTime) /
                              game.timeOfRound),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                        _isPaused ? AppIcons.icPlay : AppIcons.icPause),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingWidget() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Gap(53),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: AppText(
                  text: _roundModel?.team.name ?? '',
                  style: AppTextStyles.headerSmall,
                  color: AppColors.textWhite,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Gap(3),
          const AppText(
            text: 'Remembers the word:',
            style: AppTextStyles.regular14,
            color: AppColors.textSecondary,
          ),
          const Gap(5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 18),
            decoration: BoxDecoration(
              color: AppColors.layer3,
              borderRadius: BorderRadius.circular(5),
            ),
            child: AppText(
              text: _roundModel?.name ?? '',
              style: AppTextStyles.regular16,
              color: AppColors.textWhite,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(25),
          _wordWidget(),
          const Gap(25),
          _getTime(),
          const Gap(114),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: 'Not right',
                    bgColor: AppColors.tertiaryPink,
                    bgActiveColor: const Color(0xFFFB94AB),
                    onPressed: _isPaused
                        ? null
                        : () {
                            setState(() {
                              _getCurrentWord();
                            });
                          },
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: AppButton(
                    title: 'Right',
                    bgColor: AppColors.accentPrimary1,
                    bgActiveColor: AppColors.accentSecondary1,
                    onPressed: _isPaused
                        ? null
                        : () {
                            setState(() {
                              _onRightTap();
                            });
                          },
                  ),
                ),
              ],
            ),
          ),
          Gap(MediaQuery.paddingOf(context).bottom + 16),
        ],
      ),
    );
  }

  void _getAllWords() {
    _listOfAllWords = [];
    for (var item in widget.gameModel.listOfKeysWords) {
      switch (item) {
        case CategoriesEnum.football:
          _listOfAllWords.addAll(AppStorage.listOfFootball);
          break;
        case CategoriesEnum.basketball:
          _listOfAllWords.addAll(AppStorage.listOfBasketball);
          break;
        case CategoriesEnum.baseball:
          _listOfAllWords.addAll(AppStorage.listOfBaseball);
          break;
        case CategoriesEnum.rugby:
          _listOfAllWords.addAll(AppStorage.listOfRugby);
          break;
        case CategoriesEnum.hockey:
          _listOfAllWords.addAll(AppStorage.listOfHockey);
          break;
      }
    }
  }

  void _getCurrentRound() async {
    _roundModel =
        game.listOfRounds.firstWhereOrNull((element) => !element.isFinished);
    print("name of player: ${_roundModel?.name}, ${_roundModel?.isFinished}");
    if (_roundModel == null) {
      await Hive.openBox(kAppStorage).then((value) {
        value.put(kLastGame, game);
        AppNavigator.replaceToNextScreen(
            context, FirstResultScreen(gameModel: game));
      });
    } else {
      _currentTime = _roundModel?.currentTime ?? 0;
    }
  }

  void _getCurrentWord() async {
    int index;
    String currentWord;

    //Take random word and check on repeat
    do {
      index = Random().nextInt(_listOfAllWords.length);
      currentWord = _listOfAllWords[index];
    } while (game.listOfRounds
        .firstWhere((element) => element.id == _roundModel?.id)
        .listOfUsedWords
        .contains(currentWord));

    //Set to game
    game.listOfRounds
        .firstWhere((element) => element.id == _roundModel?.id)
        .currentWord = currentWord;

    // _roundModel?.currentWord = currentWord;

    //Save to storage
    await Hive.openBox(kAppStorage).then((value) {
      value.put(kLastGame, game);
    });
  }

  void _getNextRound() {
    game.listOfRounds
        .firstWhere((element) => element.id == _roundModel?.id)
        .isFinished = true;
    _getCurrentRound();
  }

  void _onRightTap() async {
    await Hive.openBox(kAppStorage).then((value) {
      game.listOfRounds
          .firstWhere((element) => element.id == _roundModel?.id)
          .points += 1;

      // _roundModel?.points += 1;

      value.put(kLastGame, game);

      _getCurrentWord();
    });
  }
}
