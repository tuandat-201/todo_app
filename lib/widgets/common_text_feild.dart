import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_app/utils/extensions.dart';

class CommonTextFeild extends StatelessWidget {
  const CommonTextFeild({
    super.key,
    required this.title,
    required this.hintText,
    this.controller,
    this.maxLine,
    this.suffixIcon,
    this.readOnly = false,
  });

  final String title;
  final String hintText;
  final int? maxLine;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(5),
        TextField(
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            suffixIcon: suffixIcon,
          ),
          maxLines: maxLine,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
