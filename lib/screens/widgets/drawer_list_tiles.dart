import 'package:flutter/material.dart';

import '../../util/utils.dart';

class DrawerListTile extends StatelessWidget {
  DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String? icon;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Image.asset(
        "$icon",
        color: Utils.getIconColor(),
        height: 24.0,
        width: 24.0,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getIconColor()),
      ),
    );
  }
}
