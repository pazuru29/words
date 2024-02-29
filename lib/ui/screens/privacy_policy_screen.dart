import 'package:app_android_b_0145_24/ui/components/app_tab_bar.dart';
import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/ui/components/base_screen.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends BaseScreen {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends BaseScreenState<PrivacyPolicyScreen> {
  @override
  Widget buildMain(BuildContext context) {
    return Column(
      children: [
        const AppTabBar(title: 'Privacy Policy'),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                16, 17, 16, MediaQuery.paddingOf(context).bottom + 16),
            child: const Column(
              children: [
                AppText(
                  text:
                      'Lorem ipsum dolor sit amet consectetur. Malesuada pharetra blandit eros nunc. Diam aliquet senectus sed habitant neque id sed mauваris. Id auctor nisl vestibulum urna mauris nulla aliquam. Interdum nunc scelerisque dui sapien tincidunt parturient nunc tristique in. Viverra vitae faucibus id dolor tincidunt pівмroin. Aliquam vulputate orci nibh vitae aeque ваcurabitur mauris nec eget sed interdum et. Diam mi vehicula vel mi tortor eu mauris. Libero magna scelerisque bit justo. Vulputate venenatis urna ante enim enim bibendum. Viverra tortor risus sodales mauris amet interdum pellваіentesque. Nulla habitant et non porta. Lobortis sem tristique interdum eleifend pharetra venenatis id sapien sollicitudin.\n\nPurus nullam feugiat pellentesque amet integer pharetra risus. Ac sit adipiscing adipiscing pretium est convallis. Orci arcu convallis integer neque enim accumsan auctor tincidunt. Porttitor tempor tortor viverra volutpat pulvinar eu. Ultricies sed venenatis ac erat volutpat et dignissim. Velit quam tincidunt enim lacus gravida consequat porttitor dui. Neque ваcurabitur mauris nec eget sed interdum et. Diam mi vehicula vel mi tortor eu mauris. Libero magna scelerisque bibendum pellentesque. Eget nec maecenas faucibus hendrerit adipiscing quam. Nunc auctor magna sit velit fermentum montes. Curabitur sed at fermentum ac urna vel. Netus vulputate cras cras ac. Non imperdiet mattis metus vestibulum quisque tortor amet aliquet faucibus. Fusce at nullam sed nam diam egestas erat.\n\nAmet ac tellus eget in auctor bibendum facilisis venenatis a. Et quis egestas risus bibendum. Sed ut tortor justo pharetra facilisi volutpat hendrerit eu. Proin massa lacus blandit ac egestas turpis commodo velit. Adipiscing bibendum sit mollis consectetur in aliquet tempus lectus. Nibh aliquet molestie pretium lectus. Metus sit tellus enim ipsum neque molestie enim. Diam non gravida facilisis sed adipiscing enim at faucibus. Vestibulum enim porttitor morbi natoque faucibus at quis adipiscing. Tempus quis ut ac venenatis vitae id et. Non risus leo scelerisque orci fusce pretium est.',
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
