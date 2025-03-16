
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/device/device_utility.dart';
import '../../../utils/helpers/helper_functions.dart';

class TTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? TColors.black : TColors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align to the end (right)
        children: [
          Expanded(
            child: TabBar(
              tabs: tabs,
              isScrollable: true,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: TColors.darkGrey,
              // Add this to control alignment within the TabBar itself:
              labelPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust as needed
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
