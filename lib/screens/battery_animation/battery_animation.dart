import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/battery_menu_controller.dart';
import '../../util/utils.dart';
import '../widgets/window_button.dart';
import 'battery_animation_dashboard_screen.dart';
import 'side_menu_battery_animation.dart';

class BatteryAnimation extends StatelessWidget {
  const BatteryAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BatteryMenuController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Json Generator',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Utils.getBGColor(),
          canvasColor: Utils.getBGColor(),
        ),
        home: Consumer<BatteryMenuController>(
          builder: (context, provider, child) {
            return Scaffold(
              body: WindowBorder(
                color: Utils.getBGColor(),
                width: 1,
                child: Row(
                  children: [const LeftSideBatteryAnimation(), RightSideBatteryAnimation(provider: provider)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LeftSideBatteryAnimation extends StatelessWidget {
  const LeftSideBatteryAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [WindowTitleBarBox(child: MoveWindow()), const Expanded(child: SideMenuBatteryAnimation())],
        ));
  }
}

class RightSideBatteryAnimation extends StatelessWidget {
  BatteryMenuController? provider;

  RightSideBatteryAnimation({Key? key, this.provider}) : super(key: key);

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
            const Expanded(child: BatteryAnimationDashboard())
          ] else ...[
            Expanded(
                child: Container(
              color: Utils.getBGColor(),
            ))
          ]
        ]),
      ),
    );
  }
}
