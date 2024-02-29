import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_icons.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class AppComponents {
  static void showDeleteDialog(
      BuildContext context, VoidCallback onDeletePressed) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppIcons.icDelete,
                  color: AppColors.textBody,
                ),
                const Gap(9),
                const AppText(
                  text: 'Delete data?',
                  style: AppTextStyles.headerSmall,
                  color: AppColors.textBody,
                  maxLines: null,
                ),
                const Gap(9),
                const AppText(
                  text: 'All data will be lost',
                  style: AppTextStyles.regular14,
                  color: Color(0xFF909090),
                  maxLines: null,
                ),
                const Gap(26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        AppNavigator.goBack(context);
                        onDeletePressed();
                      },
                      child: const AppText(
                        text: 'Delete',
                        style: AppTextStyles.semibold18,
                        color: AppColors.layer3,
                      ),
                    ),
                    const Gap(24),
                    TextButton(
                      onPressed: () {
                        AppNavigator.goBack(context);
                      },
                      child: const AppText(
                        text: 'Cancel',
                        style: AppTextStyles.semibold18,
                        color: AppColors.layer3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showNotificationsDialog(BuildContext context,
      VoidCallback onBlockPressed, VoidCallback onAllowPressed) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppText(
                  text: 'Notification',
                  style: AppTextStyles.headerSmall,
                  color: AppColors.textBody,
                  maxLines: null,
                ),
                const Gap(9),
                const AppText(
                  text: 'Click on allow to receive notifications',
                  style: AppTextStyles.regular14,
                  color: Color(0xFF909090),
                  maxLines: null,
                ),
                const Gap(26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        AppNavigator.goBack(context);
                        onBlockPressed();
                      },
                      child: const AppText(
                        text: 'Block',
                        style: AppTextStyles.semibold18,
                        color: AppColors.layer3,
                      ),
                    ),
                    const Gap(24),
                    TextButton(
                      onPressed: () {
                        AppNavigator.goBack(context);
                        onAllowPressed();
                      },
                      child: const AppText(
                        text: 'Allow',
                        style: AppTextStyles.semibold18,
                        color: AppColors.layer3,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
