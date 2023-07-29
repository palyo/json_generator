import 'package:aani_generator/screens/keyboard/extra/side_menu_keyboard.dart';
import 'package:aani_generator/screens/keyboard/keyboard_dashboard_screen.dart';
import 'package:aani_generator/screens/keyboard/keyboard_upload_screen.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/utils.dart';
import '../widgets/window_button.dart';
import 'keyboard_menu_controller.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => KeyboardMenuController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Json Generator',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Utils.getBGColor(),
          canvasColor: Utils.getBGColor(),
        ),
        home: Consumer<KeyboardMenuController>(
          builder: (context, provider, child) {
            return Scaffold(
              body: WindowBorder(
                color: Utils.getBGColor(),
                width: 1,
                child: Row(
                  children: [const KeyboardLeftSide(), KeyboardRightSide(provider: provider)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class KeyboardLeftSide extends StatelessWidget {
  const KeyboardLeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blueAccent,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [WindowTitleBarBox(child: MoveWindow()), Expanded(child: SideMenuKeyboard())],
        ));
  }
}

class KeyboardRightSide extends StatelessWidget {
  KeyboardMenuController? provider;

  KeyboardRightSide({Key? key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Utils.getBGColor(),
        ),
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          ),
          if (provider!.pageIndex == 0) ...[
            const Expanded(child: KeyboardDashboard())
          ] else if (provider!.pageIndex == 1) ...[
            const Expanded(child: KeyboardUpload())
          ] else ...[
            Expanded(
                child: Container(
              color: Utils.getCardColor(),
            ))
          ]
        ]),
      ),
    );
  }
}
