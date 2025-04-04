import 'package:flutter/material.dart';
import 'package:todo_app/utils/extensions.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final size = context.deviceSize;
    final colorScheme = context.colorScheme;

    return Container(
      width: size.width,
      height: size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colorScheme.primaryContainer,
      ),
      child: child,
    );
  }
}
