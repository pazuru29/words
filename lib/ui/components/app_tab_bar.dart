import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/ui/components/app_icon_button.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_icons.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppTabBar extends StatelessWidget {
  final String title;
  final bool isSecondary;
  final VoidCallback? onBackChanges;

  const AppTabBar({
    super.key,
    required this.title,
    this.isSecondary = true,
    this.onBackChanges,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: AppColors.layer3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isSecondary)
            AppIconButton(
              assetName: AppIcons.icArrowBack,
              bgColor: AppColors.layer3,
              bgActiveColor: AppColors.layer3,
              iconColor: AppColors.accentPrimary1,
              iconActiveColor: AppColors.accentSecondary1,
              onPressed: () {
                if (onBackChanges != null) {
                  onBackChanges!();
                }
                AppNavigator.goBack(context);
              },
            ),
          if (!isSecondary) const Gap(48),
          AppText(
            text: title,
            style: AppTextStyles.headerSmall,
            color: AppColors.textWhite,
          ),
          const Gap(48),
        ],
      ),
    );
  }
}
