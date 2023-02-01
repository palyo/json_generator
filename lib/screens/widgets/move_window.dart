import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MoveWindowPoster extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onDoubleTap;

  MoveWindowPoster({Key? key, this.child, this.onDoubleTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child == null) return _MoveWindowPoster(onDoubleTap: this.onDoubleTap);
    return _MoveWindowPoster(
      onDoubleTap: this.onDoubleTap,
      child: Column(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [Expanded(child: this.child!)]),
    );
  }
}

class _MoveWindowPoster extends StatelessWidget {
  _MoveWindowPoster({Key? key, this.child, this.onDoubleTap}) : super(key: key);
  final Widget? child;
  final VoidCallback? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          appWindow.startDragging();
        },
        onDoubleTap: this.onDoubleTap ?? () => appWindow.maximizeOrRestore(),
        child: this.child ?? Container());
  }
}

class WindowTitleBarBoxPoster extends StatelessWidget {
  final Widget? child;

  WindowTitleBarBoxPoster({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container();
    }
    final titlebarHeight = appWindow.titleBarHeight;
    return SizedBox(height: titlebarHeight, child: this.child ?? Container());
  }
}
