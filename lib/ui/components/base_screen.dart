import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => BaseScreenState();
}

class BaseScreenState<T extends BaseScreen> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor(),
      body: needSafeArea()
          ? Container(
              margin: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
              color: AppColors.backgroundMain,
              child: buildMain(context),
            )
          : buildMain(context),
    );
  }

  Widget buildMain(BuildContext context) {
    return const Placeholder();
  }

  Color bgColor() {
    return AppColors.backgroundMain;
  }

  bool needSafeArea() {
    return true;
  }
}
