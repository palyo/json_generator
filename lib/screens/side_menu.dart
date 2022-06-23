import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/menu_controller.dart';
import '../util/utils.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1.0,
      child: Ink(
        color: Utils.getAccentColor(),
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(bottom: 36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/ic_logo_icon.png",
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
            ),
            DrawerListTile(
              title: "Home",
              press: () {
                Provider.of<MenuController>(context, listen: false).setPageIndex(0);
              },
            ),
            DrawerListTile(
              title: "Generate Json",
              press: () {
                Provider.of<MenuController>(context, listen: false).setPageIndex(1);
              },
            ),
            DrawerListTile(
              title: "Settings",
              press: () {
                Provider.of<MenuController>(context, listen: false).setPageIndex(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Sans',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: Utils.getIconColor()),
      ),
    );
  }
}
