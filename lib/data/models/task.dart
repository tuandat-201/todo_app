// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:todo_app/data/data.dart';

class Task extends Equatable {
  final int? id;
  final String title;
  final String note;
  final String time;
  final String date;
  final TaskCategory category;
  final bool isCompleted;

  const Task({
    this.id,
    required this.title,
    required this.note,
    required this.time,
    required this.date,
    required this.category,
    required this.isCompleted,
  });

  @override
  List<Object> get props {
    return [
      id!,
      title,
      note,
      time,
      date,
      isCompleted,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'time': time,
      'date': date,
      'category': category.name,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      note: map['note'] as String,
      time: map['time'] as String,
      date: map['date'] as String,
      category: TaskCategory.stringToCategory(map['category']),
      isCompleted: map['isCompleted'] as int == 1 ? true : false,
    );
  }

  Task copyWith({
    int? id,
    String? title,
    String? note,
    String? time,
    String? date,
    TaskCategory? category,
    bool? isCompleted,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      time: time ?? this.time,
      date: date ?? this.date,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
