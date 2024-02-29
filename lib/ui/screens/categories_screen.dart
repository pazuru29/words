import 'package:app_android_b_0145_24/ui/components/app_tab_bar.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_icons.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:app_android_b_0145_24/utils/enums/categories_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CategoriesScreen extends BaseScreen {
  final List<CategoriesEnum> keyOfWordList;
  final Function(List<CategoriesEnum>) onChangeList;

  const CategoriesScreen({
    super.key,
    required this.keyOfWordList,
    required this.onChangeList,
  });

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends BaseScreenState<CategoriesScreen> {
  List<CategoriesEnum> _listOfCategories = [];

  @override
  void initState() {
    _listOfCategories = widget.keyOfWordList;
    super.initState();
  }

  @override
  Widget buildMain(BuildContext context) {
    return Column(
      children: [
        AppTabBar(
          title: 'Categories',
          onBackChanges: () {
            widget.onChangeList(_listOfCategories);
          },
        ),
        Expanded(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
                16, 18, 16, MediaQuery.paddingOf(context).bottom + 10),
            shrinkWrap: true,
            itemCount: CategoriesEnum.values.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_listOfCategories
                              .contains(CategoriesEnum.values[index]) &&
                          _listOfCategories.length > 1) {
                        _listOfCategories.remove(CategoriesEnum.values[index]);
                      } else if (!_listOfCategories
                          .contains(CategoriesEnum.values[index])) {
                        _listOfCategories.add(CategoriesEnum.values[index]);
                      }
                    });
                  },
                  child: Container(
                    height: 55,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.layer3,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          _listOfCategories
                                  .contains(CategoriesEnum.values[index])
                              ? AppIcons.icCheckboxActive
                              : AppIcons.icCheckboxInactive,
                        ),
                        const Gap(8),
                        AppText(
                          text: CategoriesEnum.values[index].getString(),
                          style: AppTextStyles.regular16,
                          color: AppColors.textWhite,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
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
