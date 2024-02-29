import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/main_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_images.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:app_android_b_0145_24/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';

class OnBoardingScreen extends BaseScreen {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends BaseScreenState<OnBoardingScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return Column(
      children: [
        const Gap(130),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: AppText(
            text: 'Have fun with your friends',
            style: AppTextStyles.headerLarge,
            color: AppColors.accentSecondary2,
            maxLines: null,
            align: TextAlign.center,
          ),
        ),
        const Gap(10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: AppText(
            text: 'Play with a company to find out who is smarter than you',
            style: AppTextStyles.semibold18,
            color: AppColors.textWhite,
            maxLines: null,
            align: TextAlign.center,
          ),
        ),
        const Gap(50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: AppButton(
            title: 'Next',
            bgColor: AppColors.accentPrimary1,
            bgActiveColor: AppColors.accentSecondary1,
            onPressed: () async {
              await Hive.openBox(kAppStorage).then((value) {
                value.put(kIsFirstRun, false);
                AppNavigator.replaceToNextScreen(context, const MainScreen());
              });
            },
          ),
        ),
        const Gap(65),
        Expanded(
          child: Image.asset(
            AppImages.imOb,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
      ],
    );
  }
}
