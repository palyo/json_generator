import 'package:flutter/material.dart';

import '../../util/utils.dart';

class DrawerListTileCustomize extends StatelessWidget {
  const DrawerListTileCustomize({
    Key? key,
    required this.icon,
    required this.title,
    required this.press,
  }) : super(key: key);

  final IconData? icon;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: Utils.getIconColor(),
        size: 24.0,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 18.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getIconColor()),
      ),
    );
  }
}
