import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:aani_generator/screens/poster_studio/side_menu.dart';
import 'package:provider/provider.dart';

import '../../controller/menu_controller.dart';
import '../../util/utils.dart';
import '../widgets/window_button.dart';
import 'generate_json_screen.dart';
import 'home_screen.dart';

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
                  children: [const LeftSidePoster(), RightSidePoster(provider: provider)],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LeftSidePoster extends StatelessWidget {
  const LeftSidePoster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Utils.getAccentColor(),
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Column(
          children: [WindowTitleBarBox(child: MoveWindow()), Expanded(child: SideMenu())],
        ));
  }
}

class RightSidePoster extends StatelessWidget {
  MenuController? provider;

  RightSidePoster({Key? key, this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Utils.getCardColor(),
        ),
        child: Column(mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          WindowTitleBarBox(
            child: Row(
              children: [Expanded(child: MoveWindow()), const WindowButtons()],
            ),
          ),
          if (provider!.pageIndex == 0) ...[
            const Expanded(child: HomeScreen())
          ] else
            if (provider!.pageIndex == 1) ...[
              const Expanded(child: GenerateJsonScreen())
            ] else
              ...[
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