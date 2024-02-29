import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/logic/bloc/settings_cubit/settings_cubit.dart';
import 'package:app_android_b_0145_24/logic/models/user_model.dart';
import 'package:app_android_b_0145_24/main.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/app_tab_bar.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/ui/components/settings_button.dart';
import 'package:app_android_b_0145_24/ui/screens/edit_profile_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/on_boarding_screen.dart';
import 'package:app_android_b_0145_24/ui/screens/privacy_policy_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_components.dart';
import 'package:app_android_b_0145_24/utils/app_icons.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:app_android_b_0145_24/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends BaseScreen {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  late final SettingsCubit _settingsCubit;

  UserModel _userModel = UserModel();

  //TODO - add id's
  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    googlePlayIdentifier: 'fr.skyost.example',
    appStoreIdentifier: '1491556149',
  );

  @override
  void initState() {
    _settingsCubit = context.read<SettingsCubit>();
    _settingsCubit.getInitData();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        setState(() {
          if (state is LoadedSettingsState) {
            _userModel = state.userModel;
          }
        });
      },
      child: Column(
        children: [
          const AppTabBar(title: 'Settings'),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(40),
                  _profileWidget(),
                  const Gap(34),
                  _buttonsWidget(),
                  const Gap(101),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: AppButton(
                      title: 'Delete data',
                      bgColor: AppColors.tertiaryPink,
                      bgActiveColor: const Color(0xFFFB94AB),
                      onPressed: () {
                        AppComponents.showDeleteDialog(context, () async {
                          await Hive.openBox(kAppStorage).then((value) {
                            value.clear();
                            isFirstRun.value = true;
                            isNotificationsNeed.value = true;
                            AppNavigator.goBack(context);
                            AppNavigator.replaceToNextScreen(
                                context, const OnBoardingScreen());
                          });
                        });
                      },
                    ),
                  ),
                  Gap(MediaQuery.paddingOf(context).bottom + 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Color bgColor() {
    return AppColors.layer3;
  }

  Widget _profileWidget() {
    return GestureDetector(
      onTap: () {
        AppNavigator.goToNextScreen(context, const EditProfileScreen());
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            SizedBox(
              height: 135,
              child: Stack(
                children: [
                  if (_userModel.image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.memory(
                        _userModel.image!,
                        height: 116,
                        width: 116,
                        fit: BoxFit.cover,
                      ),
                    ),
                  if (_userModel.image == null)
                    SvgPicture.asset(
                      AppIcons.icAvatar,
                      height: 116,
                      width: 116,
                    ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: SvgPicture.asset(
                      AppIcons.icEdit,
                      height: 48,
                      width: 48,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(11),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: AppText(
                text: _userModel.name,
                style: AppTextStyles.headerSmall,
                color: AppColors.textWhite,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SettingsButton(
            title: 'Notification',
            bgColor: AppColors.layer3,
            onPressed: () {
              AppComponents.showNotificationsDialog(
                context,
                () async {
                  await Hive.openBox(kAppStorage).then((value) {
                    value.put(kNeedNotify, false);
                    isNotificationsNeed.value = false;
                  });
                },
                () async {
                  await Hive.openBox(kAppStorage).then((value) {
                    value.put(kNeedNotify, true);
                    isNotificationsNeed.value = true;
                  });
                },
              );
            },
          ),
          const Gap(13),
          SettingsButton(
            title: 'Privacy Policy',
            bgColor: AppColors.layer3,
            onPressed: () {
              AppNavigator.goToNextScreen(context, const PrivacyPolicyScreen());
            },
          ),
          const Gap(13),
          SettingsButton(
            title: 'Share app',
            bgColor: AppColors.layer3,
            onPressed: () {
              Share.share('check out my website https://example.com',
                  subject: 'Look what I made!');
            },
          ),
          const Gap(13),
          SettingsButton(
            title: 'Rate app',
            bgColor: AppColors.layer3,
            onPressed: () {
              _rateApp();
            },
          ),
        ],
      ),
    );
  }

  void _rateApp() {
    rateMyApp.init().then((value) {
      rateMyApp.showRateDialog(
        context,
        title: 'Rate this app',
        message:
            'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
        rateButton: 'RATE',
        noButton: 'NO THANKS',
        laterButton: 'MAYBE LATER',
        listener: (button) {
          switch (button) {
            case RateMyAppDialogButton.rate:
              print('Clicked on "Rate".');
              break;
            case RateMyAppDialogButton.later:
              print('Clicked on "Later".');
              break;
            case RateMyAppDialogButton.no:
              print('Clicked on "No".');
              break;
          }
          return true;
        },
        ignoreNativeDialog: false,
        dialogStyle: const DialogStyle(),
        onDismissed: () =>
            rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
      );
    });
  }
}
