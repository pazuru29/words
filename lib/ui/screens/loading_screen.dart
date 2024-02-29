import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/main.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/main_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/on_boarding_screen.dart';
import 'package:app_android_b_0145_24/utils/app_animations.dart';
import 'package:app_android_b_0145_24/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends BaseScreen {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends BaseScreenState<LoadingScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (isFirstRun.value) {
        AppNavigator.replaceToNextScreen(context, const OnBoardingScreen());
      } else {
        AppNavigator.replaceToNextScreen(context, const MainScreen());
      }
    });
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.imLoadingBg,
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.center,
          child: Lottie.asset(
            AppAnimations.anLoading,
            width: 274,
          ),
        ),
      ],
    );
  }

  @override
  bool needSafeArea() {
    return false;
  }
}
