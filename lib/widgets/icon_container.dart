import 'package:flutter/material.dart';
import 'package:todo_app/data/data.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.category,
    this.size,
    this.iconSize,
  });
  final TaskCategory category;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: category.color.withAlpha(100),
        border: Border.all(
          color: category.color,
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(
        category.icon,
        color: category.color.withAlpha(200),
        size: iconSize,
      ),
    );
  }
}
