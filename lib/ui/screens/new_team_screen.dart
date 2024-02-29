import 'package:app_android_b_0145_24/logic/app_navigator.dart';
import 'package:app_android_b_0145_24/logic/models/team_model.dart';
import 'package:app_android_b_0145_24/ui/components/app_button.dart';
import 'package:app_android_b_0145_24/ui/components/app_tab_bar.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/ui/components/name_widget.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class NewTeamScreen extends BaseScreen {
  final TeamModel? teamModel;
  final Function(TeamModel) onTeamSave;

  const NewTeamScreen({
    super.key,
    required this.onTeamSave,
    this.teamModel,
  });

  @override
  State<NewTeamScreen> createState() => _NewTeamScreenState();
}

class _NewTeamScreenState extends BaseScreenState<NewTeamScreen> {
  List<String> _listOfPlayers = [];

  late final TextEditingController _teamNameController;
  late final FocusNode _teamNameFocus;

  @override
  void initState() {
    _teamNameController = TextEditingController();
    _teamNameFocus = FocusNode();

    if (widget.teamModel != null) {
      _listOfPlayers = [...widget.teamModel!.namesOfPlayers];
      _teamNameController.text = widget.teamModel!.name;
    } else {
      _listOfPlayers = ['', ''];
    }
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const AppTabBar(title: 'New team'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Gap(11),
                    _teamWidget(),
                    const Gap(19),
                    _playersWidget(),
                    Gap(MediaQuery.paddingOf(context).bottom + 105),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (MediaQuery.of(context).viewInsets.bottom <= 10)
          Positioned(
            bottom: MediaQuery.paddingOf(context).bottom + 48,
            right: 50,
            left: 50,
            child: AppButton(
              title: 'Save',
              bgColor: AppColors.accentPrimary1,
              bgActiveColor: AppColors.accentSecondary1,
              onPressed: _getActiveButton()
                  ? () {
                      widget.onTeamSave(TeamModel(
                          id: UniqueKey().toString(),
                          name: _teamNameController.text,
                          namesOfPlayers: _listOfPlayers
                              .map((e) => e.trimLeft().trimRight())
                              .toList()));
                      AppNavigator.goBack(context);
                    }
                  : null,
            ),
          ),
      ],
    );
  }

  @override
  Color bgColor() {
    return AppColors.layer3;
  }

  Widget _teamWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: 'Team name',
          style: AppTextStyles.regular14,
          color: AppColors.textSecondary,
        ),
        const Gap(6),
        TextField(
          controller: _teamNameController,
          focusNode: _teamNameFocus,
          inputFormatters: [
            LengthLimitingTextInputFormatter(60),
          ],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: 'Name',
            hintStyle:
                const TextStyle().copyWith(color: AppColors.textSecondary),
            filled: true,
            fillColor: AppColors.layer3,
          ),
          onChanged: (text) {
            setState(() {});
          },
          onTapOutside: (detail) {
            setState(() {
              _teamNameFocus.unfocus();
            });
          },
        ),
      ],
    );
  }

  Widget _playersWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(
          text: 'Players',
          style: AppTextStyles.regular14,
          color: AppColors.textSecondary,
        ),
        const Gap(6),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: _listOfPlayers.length,
          itemBuilder: (context, index) {
            return NameWidget(
              name: _listOfPlayers[index],
              number: index + 1,
              onChange: (text) {
                setState(() {
                  _listOfPlayers[index] = text;
                });
              },
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
                  onPressed: _listOfPlayers.length > 2
                      ? () {
                          setState(() {
                            _listOfPlayers.removeLast();
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
                  onPressed: _listOfPlayers.length < 6
                      ? () {
                          setState(() {
                            _listOfPlayers.add('');
                          });
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

  bool _getActiveButton() {
    bool isAllPlayersFilled = true;

    for (final item in _listOfPlayers) {
      if (item.trimLeft().trimRight().isEmpty) {
        isAllPlayersFilled = false;
        break;
      }
    }

    return _teamNameController.text.trimLeft().trimRight().isNotEmpty &&
        isAllPlayersFilled;
  }
}
