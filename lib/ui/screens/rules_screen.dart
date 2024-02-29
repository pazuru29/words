import 'package:app_android_b_0145_24/ui/components/app_tab_bar.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class RulesScreen extends BaseScreen {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends BaseScreenState<RulesScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return Column(
      children: [
        const AppTabBar(title: 'Rules'),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                16, 17, 16, MediaQuery.paddingOf(context).bottom + 16),
            child: const Column(
              children: [
                AppText(
                  text:
                      'Rules for the Elias Game:\n\n1. Team Composition:\n• A minimum of two teams is required to play the Elias Game.\n• The maximum number of teams is 5.\n• Each participating team must consist of at least two members.\n• There can be a maximum of 6 members in one team\n\n2. Game Duration:\n• The game consists of rounds, and the minimum duration for one complete round is required.\n• Within a round, two games will be played—one for each participating team.\n\n3. Guessing Time:\n• Participants are allowed to guess words until the allocated time for each round expires.\n• The duration of the game and the time allotted for guessing can be set when creating a new game.\n\n4. Word Categories:\n• Teams have the option to select words from specific categories for guessing.\n• The choice of word categories is made at the beginning of the game when creating a new session.\n\nThese rules aim to ensure a fair and enjoyable experience for all participants in the Elias Game.',
                  style: AppTextStyles.regular14,
                  color: AppColors.textWhite,
                  maxLines: null,
                  align: TextAlign.justify,
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
}
