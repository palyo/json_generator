import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:aani_generator/util/utils.dart';
import 'package:provider/provider.dart';

import 'controller/dashboard_controller.dart';
import 'screens/battery_animation/battery_animation.dart';
import 'screens/invitation/invitation.dart';
import 'screens/poster_studio/poster_studio.dart';
import 'screens/widgets/window_button.dart';
import 'screens/zedge/zedge.dart';

void main() {
  runApp(const MainApp());
  if (Platform.isFuchsia || Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    doWhenWindowReady(() {
      final win = appWindow;
      const initialSize = Size(700, 800);
      win.minSize = initialSize;
      win.alignment = Alignment.center;
      win.title = "Aani Generator";
      win.show();
    });
  }
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Json Generator',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Utils.getBGColor(),
          canvasColor: Utils.getBGColor(),
        ),
        home: Consumer<DashboardController>(
          builder: (context, provider, child) {
            final double widthSize = MediaQuery.of(context).size.width;
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
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Welcome to\nAanibrothers Infotech",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 36.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Text(
                                  "\"Beyond Tomorrow\"",
                                  textAlign: TextAlign.end,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 14.0, fontFamily: 'Sans', letterSpacing: 1, fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 36.0,
                            ),
                            SizedBox(
                              width: widthSize * 0.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(
                                    width: 36.0,
                                  ),
                                  Expanded(
                                    child: InkWell(
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
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                              style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 36.0,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const BatteryAnimation()),
                                        );
                                      },
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      child: Ink(
                                        padding: const EdgeInsets.all(24.0),
                                        decoration: BoxDecoration(
                                          color: Colors.green.withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              height: 56.0,
                                              width: 56.0,
                                              decoration: const BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  child: Icon(
                                                    Icons.battery_charging_full_rounded,
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
                                              "Battery Animation",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 36.0,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 36.0,
                            ),
                            SizedBox(
                              width: widthSize * 0.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const SizedBox(
                                    width: 36.0,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const ZedgePlus()),
                                        );
                                      },
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      child: Ink(
                                        padding: const EdgeInsets.all(24.0),
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent.withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              height: 56.0,
                                              width: 56.0,
                                              decoration: const BoxDecoration(
                                                color: Colors.redAccent,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  child: Icon(
                                                    Icons.music_note_rounded,
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
                                              "Ringer",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 36.0,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const Invitation()),
                                        );
                                      },
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      child: Ink(
                                        padding: const EdgeInsets.all(24.0),
                                        decoration: BoxDecoration(
                                          color: Colors.pinkAccent.withOpacity(0.2),
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              height: 56.0,
                                              width: 56.0,
                                              decoration: const BoxDecoration(
                                                color: Colors.pinkAccent,
                                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.0),
                                                child: SizedBox(
                                                  child: Icon(
                                                    Icons.insert_invitation_rounded,
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
                                              "Invitation",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 36.0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      color: Utils.getAccentColor().withOpacity(0.2),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  "@ Created by Honted House",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
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
                                  "@ 2023 Aanibrothers Infotech. All rights reserved",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
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
