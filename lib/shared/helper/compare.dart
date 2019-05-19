import 'package:flutter/material.dart';

isSameDate(DateTime date, DateTime other) =>
    date.year == other.year &&
    date.month == other.month &&
    date.day == other.day;
