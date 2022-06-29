import 'package:flutter/material.dart';
import 'package:flutter_poster_studio_json_generator/main.dart';
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
              icon: "assets/icons/back.png",
              title: "Previous menu",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainApp()),
                );
              },
            ),
            DrawerListTile(
              icon: "assets/icons/code.png",
              title: "Main Json",
              press: () {
                Provider.of<MenuController>(context, listen: false).setPageIndex(0);
              },
            ),
            DrawerListTile(
              icon: "assets/icons/code.png",
              title: "Poster Json",
              press: () {
                Provider.of<MenuController>(context, listen: false).setPageIndex(1);
              },
            ),
            DrawerListTile(
              icon: "assets/icons/setting.png",
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
      leading: Image.asset("$icon",
        color: Utils.getIconColor(),
        height: 24.0,
        width: 24.0,
      ),
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
