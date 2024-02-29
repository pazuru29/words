import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconButton extends StatefulWidget {
  final String assetName;
  final VoidCallback? onPressed;
  final Color bgColor, bgActiveColor;
  final Color iconColor, iconActiveColor;
  final double height, width, borderRadius;

  const AppIconButton({
    required this.assetName,
    required this.bgColor,
    required this.bgActiveColor,
    this.iconColor = AppColors.accentPrimary1,
    this.iconActiveColor = AppColors.accentPrimary1,
    this.height = 48,
    this.width = 48,
    this.borderRadius = 100,
    this.onPressed,
    super.key,
  });

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
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

  Color _getIconColor() {
    Color color = widget.iconColor;
    if (widget.onPressed == null) {
      color = widget.iconColor.withOpacity(0.5);
    } else if (_isHighlighted) {
      color = widget.iconActiveColor;
    }

    return color;
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: _getMainColor(),
        ),
        child: Center(
          child: SvgPicture.asset(
            widget.assetName,
            color: _getIconColor(),
          ),
        ),
      ),
    );
  }
}
