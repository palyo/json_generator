import 'package:flutter/material.dart';
import 'package:aani_generator/util/utils.dart';
import 'package:highlight/highlight.dart' show highlight, Node;

class HighlightView extends StatelessWidget {
  final String source;

  final String? language;
  final Map<String, TextStyle> theme;
  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  HighlightView(
    String input, {
    Key? key,
    this.language,
    this.theme = const {},
    this.padding,
    this.textStyle,
    int tabSize = 8,
  })  : source = input.replaceAll('\t', ' ' * tabSize),
        super(key: key);

  List<TextSpan> _convert(List<Node> nodes) {
    List<TextSpan> spans = [];
    var currentSpans = spans;
    List<List<TextSpan>> stack = [];

    _traverse(Node node) {
      if (node.value != null) {
        currentSpans.add(node.className == null ? TextSpan(text: node.value) : TextSpan(text: node.value, style: theme[node.className!]));
      } else if (node.children != null) {
        List<TextSpan> tmp = [];
        currentSpans.add(TextSpan(children: tmp, style: theme[node.className!]));
        stack.add(currentSpans);
        currentSpans = tmp;

        for (var n in node.children!) {
          _traverse(n);
          if (n == node.children!.last) {
            currentSpans = stack.isEmpty ? spans : stack.removeLast();
          }
        }
      }
    }

    for (var node in nodes) {
      _traverse(node);
    }

    return spans;
  }

  static const _rootKey = 'root';
  static const _defaultFontColor = Color(0xff000000);

  static const _defaultFontFamily = 'monospace';

  @override
  Widget build(BuildContext context) {
    var textStyle = TextStyle(
      fontFamily: _defaultFontFamily,
      color: theme[_rootKey]?.color ?? _defaultFontColor,
    );
    textStyle = textStyle.merge(textStyle);

    return Container(
      decoration: BoxDecoration(color: Utils.getBGColor(), borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      padding: padding,
      child: SelectableText.rich(
        TextSpan(
          style: textStyle,
          children: _convert(highlight.parse(source, language: language).nodes!),
        ),
      ),
    );
  }
}
