import 'package:app_android_b_0145_24/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NameWidget extends StatefulWidget {
  final String name;
  final int number;
  final Function(String) onChange;

  const NameWidget({
    super.key,
    required this.name,
    required this.number,
    required this.onChange,
  });

  @override
  State<NameWidget> createState() => _NameWidgetState();
}

class _NameWidgetState extends State<NameWidget> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    controller.text = widget.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: TextField(
        controller: controller,
        focusNode: focus,
        inputFormatters: [
          LengthLimitingTextInputFormatter(60),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          hintText: 'Name ${widget.number}',
          hintStyle: const TextStyle().copyWith(color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.layer3,
        ),
        onChanged: (text) {
          widget.onChange(text);
        },
        onTapOutside: (detail) {
          setState(() {
            focus.unfocus();
          });
        },
      ),
    );
  }
}
