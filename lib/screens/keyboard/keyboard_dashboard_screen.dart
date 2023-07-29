import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aani_generator/screens/keyboard/model/keyboard_effect.dart';
import 'package:aani_generator/screens/keyboard/model/keyboard_key.dart';
import 'package:aani_generator/screens/keyboard/model/keyboard_sound.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:provider/provider.dart';

import '../../util/utils.dart';
import '../../views/flutter_highlight.dart';
import 'keyboard_menu_controller.dart';
import 'model/keyboard_font.dart';
import 'model/keyboard_theme.dart';

class KeyboardDashboard extends StatefulWidget {
  const KeyboardDashboard({
    Key? key,
  }) : super(key: key);

  @override
  KeyboardDashboardState createState() => KeyboardDashboardState();
}

class KeyboardDashboardState extends State<KeyboardDashboard> {
  String prettyprint = "";
  String language = 'json';
  String theme = 'androidstudio';
  final scText = ScrollController(initialScrollOffset: 0);

  String saveFileName = "keyboard.json";

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
        key: context.read<KeyboardMenuController>().scaffoldKey,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(color: Utils.getBGColor(), borderRadius: const BorderRadius.all(Radius.circular(2.0))),
          child: SizedBox(
              height: heightSize,
              width: widthSize,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: widthSize * 0.05, right: widthSize * 0.05, top: heightSize * 0, bottom: heightSize * 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Make Final Json',
                            style: TextStyle(fontSize: 36.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, color: Colors.blueAccent),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 36.0,
                              height: 4.0,
                              decoration: const BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.all(Radius.circular(2.0))),
                            )),
                        SizedBox(height: heightSize * 0.04),
                        Row(
                          children: [
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var fonts = <KeyboardFont>[];
                                    var parentUrl = "https://phpstack-694322-3596470.cloudwaysapps.com/Font/";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false);
                                    files.sort((l, r) {
                                      String nameL = l.path.split('/').last;
                                      String nameR = r.path.split('/').last;

                                      return compareNames(nameL, nameR);
                                    });
                                    int itemId = 0;
                                    var keyboardFont = KeyboardFont();
                                    var fontPrevName = "";
                                    for (FileSystemEntity file in files) {
                                      var path = file.path;
                                      var fileName = path.split("\\").last;
                                      if (fileName.endsWith("_preview.png")) {
                                        itemId++;
                                        keyboardFont.name = fileName.replaceAll("_preview.png", "");
                                        keyboardFont.id = itemId;
                                        keyboardFont.isPremium = 0;
                                        keyboardFont.previewImg = fileName;
                                      }
                                      if (fileName.endsWith("_preview_large.png")) {
                                        keyboardFont.largePreviewImg = fileName;
                                      }
                                      if (fileName.toLowerCase().endsWith(".ttf") || fileName.toLowerCase().endsWith(".otf")) {
                                        keyboardFont.fontFile = fileName;
                                        fontPrevName = fileName.replaceAll(RegExp(r'\.ttf', caseSensitive: false), '').replaceAll(RegExp(r'\.otf', caseSensitive: false), '');
                                      }
                                      if ((keyboardFont.previewImg?.startsWith(fontPrevName) ?? false) &&
                                          (keyboardFont.largePreviewImg?.startsWith(fontPrevName) ?? false) &&
                                          (keyboardFont.fontFile?.startsWith(fontPrevName) ?? false) &&
                                          (keyboardFont.previewImg?.isNotEmpty ?? false) &&
                                          (keyboardFont.largePreviewImg?.isNotEmpty ?? false) &&
                                          (keyboardFont.fontFile?.isNotEmpty ?? false)) {
                                        keyboardFont.name = (fontPrevName ?? "");
                                        keyboardFont.id = itemId;
                                        keyboardFont.isPremium = 0;
                                        keyboardFont.previewImg = parentUrl + (keyboardFont.previewImg ?? "");
                                        keyboardFont.largePreviewImg = parentUrl + (keyboardFont.largePreviewImg ?? "");
                                        keyboardFont.fontFile = parentUrl + (keyboardFont.fontFile ?? "");
                                        fonts.add(keyboardFont);
                                        keyboardFont = KeyboardFont();
                                      }
                                    }

                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    var path = directory.path;
                                    var filename = path.split("\\").last;
                                    setState(() {
                                      saveFileName = "${filename.toLowerCase().replaceAll(" ", "_")}.json";
                                      prettyprint = encoder.convert(fonts.map((font) => font.toJson()).toList());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.font_download, size: 20.0),
                                label: Text(
                                  "Font",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var keys = <KeyboardKey>[];
                                    var parentUrl = "https://phpstack-694322-3596470.cloudwaysapps.com/Keys/";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false);
                                    files.sort((l, r) {
                                      String nameL = l.path.split('/').last;
                                      String nameR = r.path.split('/').last;

                                      return compareNames(nameL, nameR);
                                    });
                                    int itemId = 0;
                                    var keyboardKey = KeyboardKey();
                                    var fileNewName = "";
                                    for (FileSystemEntity file in files) {
                                      var path = file.path;
                                      var fileName = path.split("\\").last;
                                      fileNewName = fileName.replaceAll(RegExp(r'\.png', caseSensitive: false), '').replaceAll(RegExp(r'\.zip', caseSensitive: false), '').replaceAll("_preview.png", '');

                                      if (fileName.endsWith(".png")) {
                                        keyboardKey.previewImg = fileName;
                                      }

                                      if (fileName.endsWith(".zip")) {
                                        itemId++;
                                        keyboardKey.name = fileNewName.replaceAll("_", " ");
                                        keyboardKey.id = itemId;
                                        keyboardKey.isPremium = 0;
                                        keyboardKey.keyData = fileName;
                                      }
                                      var newName = fileNewName.split("_")[0];
                                      if ((keyboardKey.previewImg?.startsWith(newName) ?? false) && (keyboardKey.keyData?.startsWith(newName) ?? false) && (keyboardKey.previewImg?.isNotEmpty ?? false) && (keyboardKey.keyData?.isNotEmpty ?? false)) {
                                        keyboardKey.name = keyboardKey.name?.replaceAll("_", " ");
                                        keyboardKey.id = itemId;
                                        keyboardKey.isPremium = 0;
                                        keyboardKey.previewImg = parentUrl + (keyboardKey.previewImg ?? "");
                                        keyboardKey.keyData = parentUrl + (keyboardKey.keyData ?? "");
                                        keys.add(keyboardKey);
                                        keyboardKey = KeyboardKey();
                                      }
                                    }

                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    var path = directory.path;
                                    var filename = path.split("\\").last;
                                    setState(() {
                                      saveFileName = "${filename.toLowerCase().replaceAll(" ", "_")}.json";
                                      prettyprint = encoder.convert(keys.map((font) => font.toJson()).toList());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.keyboard_alt_outlined, size: 20.0),
                                label: Text(
                                  "Keys",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var keys = <KeyboardSound>[];
                                    var parentUrl = "https://phpstack-694322-3596470.cloudwaysapps.com/Sound/";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false);
                                    files.sort((l, r) {
                                      String nameL = l.path.split('/').last;
                                      String nameR = r.path.split('/').last;

                                      return compareNames(nameL, nameR);
                                    });
                                    int itemId = 0;
                                    var keyboardSound = KeyboardSound();
                                    var fileNewName = "";
                                    for (FileSystemEntity file in files) {
                                      var path = file.path;
                                      var fileName = path.split("\\").last;
                                      fileNewName = fileName.replaceAll(RegExp(r'\.png', caseSensitive: false), '').replaceAll(RegExp(r'\.mp3', caseSensitive: false), '');
                                      if (fileName.endsWith(".png")) {
                                        itemId++;
                                        keyboardSound.name = fileNewName.replaceAll("_", " ");
                                        keyboardSound.id = itemId;
                                        keyboardSound.isPremium = 0;
                                        keyboardSound.previewImg = fileName;
                                      }

                                      if (fileName.endsWith(".mp3")) {
                                        keyboardSound.mp3file = fileName;
                                      }
                                      var newName = fileNewName.split("_")[0];
                                      if ((keyboardSound.previewImg?.startsWith(newName) ?? false) && (keyboardSound.previewImg?.isNotEmpty ?? false) && (((keyboardSound.mp3file?.startsWith(newName) ?? false) && (keyboardSound.mp3file?.isNotEmpty ?? false)) || fileNewName == "off_sound")) {
                                        keyboardSound.name = (fileNewName ?? "");
                                        keyboardSound.id = itemId;
                                        keyboardSound.isPremium = 0;
                                        keyboardSound.previewImg = parentUrl + (keyboardSound.previewImg ?? "");
                                        if (fileNewName != "off_sound") keyboardSound.mp3file = parentUrl + (keyboardSound.mp3file ?? "");
                                        keys.add(keyboardSound);
                                        keyboardSound = KeyboardSound();
                                      }
                                    }

                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    var path = directory.path;
                                    var filename = path.split("\\").last;
                                    setState(() {
                                      saveFileName = "${filename.toLowerCase().replaceAll(" ", "_")}.json";
                                      prettyprint = encoder.convert(keys.map((font) => font.toJson()).toList());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.music_note_outlined, size: 20.0),
                                label: Text(
                                  "Sound",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var keys = <KeyboardEffect>[];
                                    var parentUrl = "https://phpstack-694322-3596470.cloudwaysapps.com/Effect/";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false);
                                    int itemId = 0;
                                    var keyboardEffect = KeyboardEffect();
                                    var fileNewName = "";
                                    var fileNameChanged = "";
                                    for (FileSystemEntity file in files) {
                                      var path = file.path;
                                      var fileName = path.split("\\").last;

                                      // if (fileNameChanged.isNotEmpty && fileNameChanged != fileNewName) {
                                      //   keyboardEffect.name = (fileNewName ?? "");
                                      //   keyboardEffect.id = itemId;
                                      //   keyboardEffect.isPremium = 0;
                                      //   if (keyboardEffect.file != null) keyboardEffect.file = parentUrl + (keyboardEffect.file ?? "");
                                      //   if (keyboardEffect.previewImg != null) keyboardEffect.previewImg = parentUrl + (keyboardEffect.previewImg ?? "");
                                      //   keys.add(keyboardEffect);
                                      //   keyboardEffect = KeyboardEffect();
                                      // }

                                      if (fileName.endsWith(".png")) {
                                        keyboardEffect.previewImg = fileName;
                                      }

                                      if (fileName.endsWith(".zip")) {
                                        fileNewName = fileName.replaceAll(RegExp(r'\.png', caseSensitive: false), '').replaceAll(RegExp(r'\.zip', caseSensitive: false), '');
                                        itemId++;
                                        keyboardEffect.name = fileNewName.replaceAll("_", " ");
                                        keyboardEffect.id = itemId;
                                        keyboardEffect.isPremium = 0;
                                        keyboardEffect.file = fileName;
                                      }
                                      if ((keyboardEffect.previewImg?.toLowerCase().startsWith(fileNewName.toLowerCase()) ?? false) &&
                                          (keyboardEffect.file?.toLowerCase().startsWith(fileNewName.toLowerCase()) ?? false) &&
                                          (keyboardEffect.previewImg?.isNotEmpty ?? false) &&
                                          (keyboardEffect.file?.isNotEmpty ?? false)) {
                                        fileNameChanged = (fileNewName ?? "");
                                        keyboardEffect.name = (fileNewName ?? "");
                                        keyboardEffect.id = itemId;
                                        keyboardEffect.isPremium = 0;
                                        if (keyboardEffect.file != null) keyboardEffect.file = parentUrl + (keyboardEffect.file ?? "");
                                        if (keyboardEffect.previewImg != null) keyboardEffect.previewImg = parentUrl + (keyboardEffect.previewImg ?? "");
                                        keys.add(keyboardEffect);
                                        keyboardEffect = KeyboardEffect();
                                      }
                                    }

                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    var path = directory.path;
                                    var filename = path.split("\\").last;
                                    setState(() {
                                      saveFileName = "${filename.toLowerCase().replaceAll(" ", "_")}.json";
                                      prettyprint = encoder.convert(keys.map((font) => font.toJson()).toList());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.bubble_chart_rounded, size: 20.0),
                                label: Text(
                                  "Effect",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.blueAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var keyboardThemes = <KeyboardTheme>[];
                                    var parentUrl = "https://phpstack-694322-3596470.cloudwaysapps.com/KeyboardTheme/";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false);
                                    int itemId = 0;

                                    for (FileSystemEntity file in files) {
                                      var path = file.path;
                                      var fileName = path.split("\\").last;
                                      var keyboardTheme = KeyboardTheme();
                                      var fileNewName = "";
                                      itemId++;
                                      keyboardTheme.themeTag = fileName;
                                      keyboardTheme.id = itemId;
                                      Directory directory = Directory(file.path);

                                      List<FileSystemEntity> subFiles = directory.listSync(recursive: false);
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        for (FileSystemEntity file in subFiles) {
                                          var path = file.path;
                                          var fileName = path.split("\\").last;
                                          if (fileName.endsWith(".zip")) {
                                            keyboardTheme.pkgName = "my.photo.picture.keyboard.keyboard.theme.${fileName.replaceAll(".zip", "")}";
                                            keyboardTheme.name = toTitleCase(fileName.replaceAll("_", " ").replaceAll(".zip", ""));
                                            keyboardTheme.themeZip = parentUrl + fileName;
                                          }

                                          if (fileName.endsWith("1080.jpg") || fileName.endsWith("1080.jpeg") || fileName.endsWith("1080.png")) {
                                            keyboardTheme.themeBigPreview = parentUrl + fileName;
                                          }

                                          if (fileName.endsWith("720.jpg") || fileName.endsWith("720.jpeg") || fileName.endsWith("720.png")) {
                                            keyboardTheme.themeSmallPreview = parentUrl + fileName;
                                          }
                                        }
                                      }
                                      int randomNumber = 40 + Random().nextInt(100 - 40 + 1);
                                      keyboardTheme.userHit = "${randomNumber}k";
                                      keyboardTheme.isNew = "0";
                                      keyboardTheme.isHot = "0";
                                      keyboardTheme.themeType = "notlive";
                                      keyboardTheme.isPremium = "0";

                                      keyboardThemes.add(keyboardTheme);
                                    }

                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    var path = directory.path;
                                    var filename = path.split("\\").last;
                                    setState(() {
                                      saveFileName = "${filename.toLowerCase().replaceAll(" ", "_")}.json";
                                      prettyprint = encoder.convert(keyboardThemes.map((font) => font.toJson()).toList());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.style_rounded, size: 20.0),
                                label: Text(
                                  "Themes",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                          ],
                        ),
                        if (prettyprint.isNotEmpty) ...[
                          SizedBox(height: heightSize * 0.04),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  width: widthSize * 0.80,
                                  decoration: BoxDecoration(color: Utils.getBGColor(), borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      controller: scText,
                                      child: HighlightView(
                                        prettyprint,
                                        padding: const EdgeInsets.all(12),
                                        language: language,
                                        theme: themeMap[theme]!,
                                        textStyle: const TextStyle(
                                          fontFamily: 'Sans',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (prettyprint.isNotEmpty) ...[
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton.icon(
                                        style: TextButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: Colors.blueAccent,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0,
                                            vertical: 18.0,
                                          ),
                                        ),
                                        onPressed: () async {
                                          String? outputFile = await FilePicker.platform.saveFile(dialogTitle: 'Save your json to desire location', fileName: saveFileName);
                                          try {
                                            File returnedFile = File('$outputFile');
                                            await returnedFile.writeAsString(prettyprint);
                                          } catch (e) {
                                            if (kDebugMode) {
                                              print(e.toString());
                                            }
                                          }
                                        },
                                        icon: const Icon(Icons.save_outlined, size: 20.0),
                                        label: const Text(
                                          "Save",
                                          style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          )
                        ]
                      ],
                    ),
                  )
                ],
              )),
        )));
  }

  String toTitleCase(String input) {
    if (input.isEmpty) {
      return '';
    }

    return input.split(' ').map((word) {
      if (word.isEmpty) {
        return '';
      }
      return '${word[0].toUpperCase()}${word.substring(1)}';
    }).join(' ');
  }

  int compareNames(String name1, String name2) {
    List<String> segments1 = getSegments(name1);
    List<String> segments2 = getSegments(name2);

    for (int i = 0; i < segments1.length && i < segments2.length; i++) {
      String segment1 = segments1[i];
      String segment2 = segments2[i];

      if (isNumeric(segment1) && isNumeric(segment2)) {
        int numericComparison = compareNumericValues(segment1, segment2);
        if (numericComparison != 0) {
          return numericComparison;
        }
      } else {
        int stringComparison = segment1.compareTo(segment2);
        if (stringComparison != 0) {
          return stringComparison;
        }
      }
    }

    return segments1.length.compareTo(segments2.length);
  }

  List<String> getSegments(String name) {
    List<String> segments = [];
    String currentSegment = '';

    for (int i = 0; i < name.length; i++) {
      String char = name[i];

      if (isNumeric(char)) {
        currentSegment += char;
      } else {
        if (currentSegment.isNotEmpty) {
          segments.add(currentSegment);
          currentSegment = '';
        }
        segments.add(char);
      }
    }

    if (currentSegment.isNotEmpty) {
      segments.add(currentSegment);
    }

    return segments;
  }

  int compareNumericValues(String value1, String value2) {
    int intValue1 = int.parse(value1);
    int intValue2 = int.parse(value2);

    return intValue1.compareTo(intValue2);
  }

  bool isNumeric(String value) {
    return int.tryParse(value) != null;
  }
}
