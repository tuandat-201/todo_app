import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helpers {
  const Helpers._();

  static String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('HH:mm').format(date);
  }

  static String formatDate(DateTime date) =>
      DateFormat('dd/MM/yyyy').format(date);
}
