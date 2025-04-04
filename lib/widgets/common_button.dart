import 'package:flutter/material.dart';
import 'package:todo_app/utils/extensions.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondary,
      ),
      child: Text(
        title,
        style: textTheme.titleMedium!.copyWith(
          color: colorScheme.onSecondary,
        ),
      ),
    );
  }
}
