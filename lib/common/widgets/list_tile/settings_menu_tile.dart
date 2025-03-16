// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';


class SettingsMenuTile extends StatelessWidget {
  const SettingsMenuTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.subTitle,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 28,
        color: TColors.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailing,
    );
  }
}
