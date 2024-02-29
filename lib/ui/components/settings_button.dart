import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_icons.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SettingsButton extends StatefulWidget {
  final String title;
  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final Color bgColor, textColor;
  final bool needShadow;
  final VoidCallback? onPressed;

  const SettingsButton({
    super.key,
    required this.title,
    required this.bgColor,
    this.textColor = AppColors.textWhite,
    this.width,
    this.height = 55,
    this.needShadow = false,
    this.borderRadius,
    this.onPressed,
  });

  @override
  State<SettingsButton> createState() => _SettingsButtonState();
}

class _SettingsButtonState extends State<SettingsButton> {
  bool _isHighlighted = false;

  set isHighlighted(bool value) {
    setState(() {
      if (widget.onPressed != null) {
        _isHighlighted = value;
      }
    });
  }

  Color _getMainColor() {
    Color color = widget.bgColor;
    if (widget.onPressed == null) {
      color = widget.bgColor.withOpacity(0.7);
    } else if (_isHighlighted) {
      color = widget.bgColor.withOpacity(0.5);
    }

    return color;
  }

  Widget _getMainWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: _getTexWidget()),
        const Gap(16),
        SvgPicture.asset(
          AppIcons.icArrowNext,
          color: _getArrowColor(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (details) {
        isHighlighted = true;
      },
      onTapUp: (details) {
        isHighlighted = false;
      },
      onTapCancel: () {
        isHighlighted = false;
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        padding: const EdgeInsets.fromLTRB(12, 0, 15, 0),
        decoration: BoxDecoration(
          boxShadow: widget.needShadow
              ? [
                  BoxShadow(
                      color: AppColors.textSecondary.withOpacity(0.6),
                      blurRadius: 12,
                      spreadRadius: 0,
                      offset: const Offset(0, 2)),
                ]
              : null,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(5),
          color: _getMainColor(),
        ),
        child: _getMainWidget(),
      ),
    );
  }

  AppText _getTexWidget() {
    return AppText(
      style: AppTextStyles.regular16,
      text: widget.title,
      color: _getTextColor(),
      overflow: TextOverflow.ellipsis,
    );
  }

  Color _getTextColor() {
    Color color = widget.textColor;
    if (widget.onPressed == null) {
      color = widget.textColor.withOpacity(0.5);
    } else if (_isHighlighted) {
      color = widget.textColor.withOpacity(0.7);
    }

    return color;
  }

  Color _getArrowColor() {
    Color color = AppColors.accentSecondary1;
    if (widget.onPressed == null) {
      color = AppColors.accentSecondary1.withOpacity(0.5);
    } else if (_isHighlighted) {
      color = AppColors.accentSecondary1.withOpacity(0.7);
    }

    return color;
  }
}
