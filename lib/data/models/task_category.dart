import 'package:flutter/material.dart';

enum TaskCategory {
  others(Icons.density_medium, Colors.lightGreen),
  education(Icons.school, Colors.blue),
  health(Icons.favorite, Colors.redAccent),
  shopping(Icons.shopping_bag, Colors.cyan),
  home(Icons.home, Colors.brown),
  work(Icons.work, Colors.teal);

  final IconData icon;
  final Color color;
  const TaskCategory(this.icon, this.color);

  static TaskCategory stringToCategory(String category) {
    for (var taskCategory in TaskCategory.values) {
      if (taskCategory.name == category) {
        return taskCategory;
      }
    }

    return TaskCategory.others;
  }
}
