import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:aani_generator/screens/zedge/side_menu_zedge.dart';
import 'package:aani_generator/screens/zedge/zedge_dashboard_screen.dart';
import 'package:provider/provider.dart';

import '../../controller/zedge_menu_controller.dart';
import '../../util/utils.dart';
import '../widgets/window_button.dart';

class ZedgePlus extends StatelessWidget {
  const ZedgePlus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ZedgeMenuController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Json Generator',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Utils.getBGColor(),
          canvasColor: Utils.getBGColor(),
        ),
        home: Consumer<ZedgeMenuController>(
          builder: (context, provider, child) {
            return Scaffold(
              body: WindowBorder(
                color: Utils.getBGColor(),
                width: 1,
                child: Row(
                  children: [const LeftSideZedgePlus(), RightSideZedgePlus(provider: provider)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LeftSideZedgePlus extends StatelessWidget {
  const LeftSideZedgePlus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.redAccent,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [WindowTitleBarBox(child: MoveWindow()), const Expanded(child: SideMenuZedgePlus())],
        ));
  }
}

class RightSideZedgePlus extends StatelessWidget {
  ZedgeMenuController? provider;

  RightSideZedgePlus({Key? key, this.provider}) : super(key: key);

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
            const Expanded(child: ZedgePlusDashboard())
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
