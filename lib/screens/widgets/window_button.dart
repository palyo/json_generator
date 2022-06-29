import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../util/utils.dart';

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  WindowButtonsState createState() => WindowButtonsState();
}

class WindowButtonsState extends State<WindowButtons> {
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