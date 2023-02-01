import 'package:flutter/material.dart';
import 'package:flutter_poster_studio_json_generator/main.dart';
import 'package:provider/provider.dart';

import '../../controller/menu_controller.dart';
import '../../util/utils.dart';
import '../widgets/drawer_list_custom_tiles.dart';

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
            DrawerListTileCustomize(
              icon: Icons.home_outlined,
              title: "Home",
              press: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MainApp()),
                );
              },
            ),
            DrawerListTileCustomize(
              icon: Icons.code_outlined,
              title: "Main Json",
              press: () {
                Provider.of<MenuController>(context, listen: false).setPageIndex(0);
              },
            ),
            DrawerListTileCustomize(
              icon: Icons.code_outlined,
              title: "Poster Json",
              press: () {
                Provider.of<MenuController>(context, listen: false).setPageIndex(1);
              },
            ),
            DrawerListTileCustomize(
              icon: Icons.settings_outlined,
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
