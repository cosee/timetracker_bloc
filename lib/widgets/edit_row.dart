import 'package:flutter/material.dart';
import 'package:time_track/model/work_day.dart';

class EditRow extends StatelessWidget {
  EditRow({
    this.workEntry,
    this.index,
    this.selectDay,
    this.isSelected = false,
  });

  final WorkDay workEntry;
  final int index;
  final Function(int) selectDay;
  final bool isSelected;

  @override
  Widget build(BuildContext context) =>
      Center(child: Text('Nothing to see here'));
}
