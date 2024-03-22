import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/colors.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({
    super.key,
    required int selectedIndex,
    required String title,
    required int index
  }) : _selectedIndex = selectedIndex, _title = title, _index = index;

  final int _selectedIndex;
  final String _title;
  final int _index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _selectedIndex == _index
              ? primaryColor
              : primaryColor.withOpacity(0.1)),
      child: Center(
        child: Text(
          _title,
          style: TextStyle(
            fontSize: 12,
              color: _selectedIndex == _index ? white : primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
