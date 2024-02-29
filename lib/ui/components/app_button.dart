import 'package:app_android_b_0145_24/ui/components/app_text.dart';
import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:app_android_b_0145_24/utils/app_text_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatefulWidget {
  final String title;
  final double? width;
  final double height;
  final BorderRadius? borderRadius;
  final Color bgColor, textColor, bgActiveColor, textActiveColor;
  final bool needShadow;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.bgActiveColor,
    this.textColor = AppColors.textBody,
    this.textActiveColor = AppColors.textBody,
    this.width,
    this.height = 41,
    this.needShadow = false,
    this.borderRadius,
    this.onPressed,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
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
      color = widget.bgColor.withOpacity(0.5);
    } else if (_isHighlighted) {
      color = widget.bgActiveColor;
    }

    return color;
  }

  Widget _getMainWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getTexWidget(),
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
        padding: const EdgeInsets.symmetric(horizontal: 8),
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
      style: AppTextStyles.semibold18,
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
      color = widget.textActiveColor;
    }

    return color;
  }
}
