import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:triple_h/utils/constants/colors.dart';
import 'package:triple_h/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';

class periodSelect extends StatelessWidget {
  const periodSelect({
    super.key,
    required this.selectedTabIndex,
    required this.title,
    required this.index,
    required this.currentIndex,
  });

  final ValueNotifier<int> selectedTabIndex;
  final String title;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;
    return GestureDetector(
      onTap: () {
        selectedTabIndex.value = index; // Update the selected tab index
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: THelperFunctions.screenWidth()*0.04,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? TColors.companyColor : Colors.black54,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 3,
              width: 40,
              color: TColors.companyColor,
            ),
        ],
      ),
    );
  }
}