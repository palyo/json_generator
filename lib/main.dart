import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poster_studio_json_generator/screens/generate_json_screen.dart';
import 'package:flutter_poster_studio_json_generator/screens/home_screen.dart';
import 'package:flutter_poster_studio_json_generator/screens/side_menu.dart';
import 'package:flutter_poster_studio_json_generator/util/utils.dart';
import 'package:provider/provider.dart';

import 'controller/menu_controller.dart';

void main() {
  runApp(const MyApp());
  if (Platform.isFuchsia || Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = Size(1200, 800);
      win.minSize = initialSize;
      win.alignment = Alignment.center;
      win.title = "Poster Studio";
      win.show();
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MenuController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Json Generator',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Utils.getBGColor(),
          canvasColor: Utils.getBGColor(),
        ),
        home: Consumer<MenuController>(
          builder: (context, provider, child) {
            return Scaffold(
              body: WindowBorder(
                color: Utils.getBGColor(),
                width: 1,
                child: Row(
                  children: [LeftSide(), RightSide(provider: provider)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Utils.getAccentColor(),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [WindowTitleBarBox(child: MoveWindow()), Expanded(child: SideMenu())],
        ));
  }
}

class RightSide extends StatelessWidget {
  MenuController? provider;

  RightSide({Key? key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Utils.getCardColor(),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WindowTitleBarBox(
                child: Row(
                  children: [Expanded(child: MoveWindow()), const WindowButtons()],
                ),
              ),
              if (provider!.pageIndex == 0) ...[
                const Expanded(child: HomeScreen())
              ] else if (provider!.pageIndex == 1) ...[
                const Expanded(child: GenerateJsonScreen())
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

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: Utils.buttonColors),
        appWindow.isMaximized
            ? RestoreWindowButton(
                colors: Utils.buttonColors,
                onPressed: maximizeOrRestore,
              )
            : MaximizeWindowButton(
                colors: Utils.buttonColors,
                onPressed: maximizeOrRestore,
              ),
        CloseWindowButton(colors: Utils.closeButtonColors),
      ],
    );
  }
}
