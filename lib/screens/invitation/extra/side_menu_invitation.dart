import 'package:aani_generator/screens/invitation/extra/invitation_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:aani_generator/main.dart';
import 'package:provider/provider.dart';

import '../../../util/utils.dart';
import '../../widgets/drawer_list_custom_tiles.dart';

class InvitationSideMenu extends StatelessWidget {
  const InvitationSideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 1.0,
      child: Ink(
        color: Colors.pinkAccent,
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(bottom: 36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Invitation',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, color: Utils.getWhiteColor()),
                  )
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
                Provider.of<InvitationMenuController>(context, listen: false).setPageIndex(0);
              },
            ),
            DrawerListTileCustomize(
              icon: Icons.code_outlined,
              title: "Invitation Card",
              press: () {
                Provider.of<InvitationMenuController>(context, listen: false).setPageIndex(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
