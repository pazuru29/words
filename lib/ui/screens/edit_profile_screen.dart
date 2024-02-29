import 'dart:typed_data';

import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/logic/bloc/settings_cubit/settings_cubit.dart';
import 'package:app_android_b_0145_24/logic/models/user_model.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/app_tab_bar.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends BaseScreen {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends BaseScreenState<EditProfileScreen> {
  late final SettingsCubit _settingsCubit;

  Uint8List? _image;

  late final TextEditingController _nameController;
  late final FocusNode _nameFocus;

  @override
  void initState() {
    _settingsCubit = context.read<SettingsCubit>();
    _settingsCubit.getInitData();

    _nameController = TextEditingController();
    _nameFocus = FocusNode();
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        setState(() {
          if (state is LoadedSettingsState) {
            _nameController.text = state.userModel.name;
            _image = state.userModel.image;
          }
        });
      },
      child: Column(
        children: [
          const AppTabBar(title: 'Edit Profile'),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height -
                    (64 + MediaQuery.paddingOf(context).top),
                child: Column(
                  children: [
                    const Gap(59),
                    _imageWidget(),
                    const Gap(40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _nameController,
                        focusNode: _nameFocus,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(60),
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintText: 'Name',
                          hintStyle: const TextStyle()
                              .copyWith(color: AppColors.textSecondary),
                          filled: true,
                          fillColor: AppColors.layer3,
                        ),
                        onChanged: (text) {
                          setState(() {});
                        },
                        onTapOutside: (detail) {
                          setState(() {
                            _nameFocus.unfocus();
                          });
                        },
                      ),
                    ),
                    const Gap(16),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: AppButton(
                        title: 'Save changes',
                        bgColor: AppColors.accentPrimary1,
                        bgActiveColor: AppColors.accentSecondary1,
                        textActiveColor: AppColors.textBody,
                        onPressed: _getButtonActive()
                            ? () {
                                _settingsCubit.changeUserModel(
                                  UserModel(
                                    name: _getFormattedName(),
                                    image: _image,
                                  ),
                                );
                                AppNavigator.goBack(context);
                              }
                            : null,
                      ),
                    ),
                    Gap(MediaQuery.paddingOf(context).bottom + 53),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageWidget() {
    return GestureDetector(
      onTap: () async {
        await _settingsCubit.getPhoto().then((value) {
          setState(() {
            _image = value;
          });
        });
      },
      child: Container(
        height: 172,
        color: Colors.transparent,
        child: Stack(
          children: [
            if (_image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.memory(
                  _image!,
                  height: 148,
                  width: 148,
                  fit: BoxFit.cover,
                ),
              ),
            if (_image == null)
              SvgPicture.asset(
                AppIcons.icAvatar,
                height: 148,
                width: 148,
              ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SvgPicture.asset(
                AppIcons.icAdd,
                height: 48,
                width: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedName() {
    return _nameController.text.trimLeft().trimRight();
  }

  bool _getButtonActive() {
    return _nameController.text.trimLeft().trimRight().isNotEmpty;
  }

  @override
  Color bgColor() {
    return AppColors.layer3;
  }
}
