import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poster_studio_json_generator/screens/generate_json_screen.dart';
import 'package:flutter_poster_studio_json_generator/screens/home_screen.dart';
import 'package:flutter_poster_studio_json_generator/screens/side_menu.dart';
import 'package:flutter_poster_studio_json_generator/util/utils.dart';
import 'package:provider/provider.dart';

import 'controller/dashboard_controller.dart';
import 'controller/menu_controller.dart';
import 'screens/widgets/window_button.dart';

void main() {
  runApp(const MainApp());
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

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DasboardController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Json Generator',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Utils.getBGColor(),
          canvasColor: Utils.getBGColor(),
        ),
        home: Consumer<DasboardController>(
          builder: (context, provider, child) {
            return Scaffold(
              body: WindowBorder(
                color: Utils.getBGColor(),
                width: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    WindowTitleBarBox(
                      child: Row(
                        children: [Expanded(child: MoveWindow()), const WindowButtons()],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: appWindow.titleBarHeight),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Welcome to\nAanibrothers Infotech",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 36.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w500,
                                        color: Utils.getTextColor()),
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Text(
                                    "\"Beyond Tomorrow\"",
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'Sans',
                                        letterSpacing: 1,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: Utils.getTextColor()),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              height: 36.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const PosterStudio()),
                                    );
                                  },
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: Ink(
                                    padding: const EdgeInsets.all(24.0),
                                    decoration: BoxDecoration(
                                      color: Utils.getAccentColor().withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          height: 56.0,
                                          width: 56.0,
                                          decoration: BoxDecoration(
                                            color: Utils.getAccentColor(),
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: SizedBox(
                                              child: Icon(
                                                Icons.dashboard_outlined,
                                                color: Utils.getIconColor(),
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16.0,
                                        ),
                                        Text(
                                          "Poster Studio",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Sans',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w500,
                                              color: Utils.getTextColor()),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 36.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                        "Featured App",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Sans',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w500,
                                            color: Utils.getTextColor()),
                                      ),
                                      backgroundColor: Utils.getAccentColor(),
                                    ));
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) => const PosterStudio()),
                                    // );
                                  },
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: Ink(
                                    padding: const EdgeInsets.all(24.0),
                                    decoration: BoxDecoration(
                                      color: Utils.getAccentColor().withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          height: 56.0,
                                          width: 56.0,
                                          decoration: BoxDecoration(
                                            color: Utils.getAccentColor(),
                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: SizedBox(
                                              child: Icon(
                                                Icons.question_mark_sharp,
                                                color: Utils.getIconColor(),
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16.0,
                                        ),
                                        Text(
                                          "Featured App",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontFamily: 'Sans',
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w500,
                                              color: Utils.getTextColor()),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                    color: Utils.getAccentColor(),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Text(
                                  "@ Created by Honted House",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.all(13.0),
                                child: Text(
                                  "@ 2022 Aanibrothers Infotech. All rights reserved",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PosterStudio extends StatelessWidget {
  const PosterStudio({Key? key}) : super(key: key);

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
                  children: [const LeftSide(), RightSide(provider: provider)],
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
          children: [WindowTitleBarBox(child: MoveWindow()), const Expanded(child: SideMenu())],
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
