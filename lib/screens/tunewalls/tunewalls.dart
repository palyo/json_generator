import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'extra/tunewalls_menu_controller.dart';
import '../../util/utils.dart';
import '../widgets/window_button.dart';
import 'extra/side_menu_tunewalls.dart';
import 'tunewalls_dashboard_screen.dart';
import 'tunewalls_notify_screen.dart';

class TuneWalls extends StatelessWidget {
  const TuneWalls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TuneWallsMenuController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Json Generator',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Utils.getBGColor(),
          canvasColor: Utils.getBGColor(),
        ),
        home: Consumer<TuneWallsMenuController>(
          builder: (context, provider, child) {
            return Scaffold(
              body: WindowBorder(
                color: Utils.getBGColor(),
                width: 1,
                child: Row(
                  children: [const LeftSideTuneWalls(), RightSideTuneWalls(provider: provider)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LeftSideTuneWalls extends StatelessWidget {
  const LeftSideTuneWalls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.redAccent,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [WindowTitleBarBox(child: MoveWindow()), const Expanded(child: SideMenuTuneWalls())],
        ));
  }
}

class RightSideTuneWalls extends StatelessWidget {
  TuneWallsMenuController? provider;

  RightSideTuneWalls({Key? key, this.provider}) : super(key: key);

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
            const Expanded(child: TuneWallsDashboard())
          ] else if (provider!.pageIndex == 1) ...[
            const Expanded(child: TuneWallsNotify())
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
