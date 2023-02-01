import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_poster_studio_json_generator/model/battery.dart';
import 'package:flutter_poster_studio_json_generator/views/flutter_highlight.dart';
import 'package:provider/provider.dart';

import '../../controller/battery_menu_controller.dart';
import '../../util/utils.dart';

class BatteryAnimationDashboard extends StatefulWidget {
  const BatteryAnimationDashboard({
    Key? key,
  }) : super(key: key);

  @override
  BatteryAnimationDashboardState createState() => BatteryAnimationDashboardState();
}

class BatteryAnimationDashboardState extends State<BatteryAnimationDashboard> {
  String prettyprint = "";
  String language = 'json';
  String theme = 'androidstudio';
  final scText = ScrollController(initialScrollOffset: 0);

  String saveFileName = "batteryAnimationTemplates.json";

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
        key: context.read<BatteryMenuController>().scaffoldKey,
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
                        const SizedBox(
                          height: 100.0,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Make Final Json',
                            style: TextStyle(fontSize: 36.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, color: Colors.green),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 36.0,
                              height: 4.0,
                              decoration: const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(2.0))),
                            )),
                        SizedBox(height: heightSize * 0.04),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var batteryAnimation = BatteryAnimationCategory();
                                    var categories = <BatteryCategories>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/BatteryAnimation";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    int categoryId = 0;
                                    for (FileSystemEntity file in files) {
                                      var category = BatteryCategories();
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        categoryId++;
                                        var path = file.path;
                                        var filename = path.split("\\").last;
                                        category.categoryName = filename;
                                        category.categoryId = categoryId;

                                        var animations = <Animations>[];
                                        Directory subDirs = Directory(file.path);
                                        List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                        for (FileSystemEntity file in subFiles) {
                                          var animation = Animations();
                                          FileStat fileStat = file.statSync();
                                          if (fileStat.type.toString() == "directory") {
                                            Directory childDirs = Directory(file.path);
                                            List<FileSystemEntity> childFiles = childDirs.listSync(recursive: false);
                                            for (FileSystemEntity file in childFiles) {
                                              if (file.path.split("\\").last.startsWith("thumb")) {
                                                var imageUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                                var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                                var imageFinalURL = parentUrl + imageChildUrl;
                                                animation.thumbUrl = Uri.encodeFull(imageFinalURL);
                                              } else if (file.path.split("\\").last.endsWith("zip")) {
                                                var zipUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                                var zipChildUrl = zipUrl.replaceAll("\\", "/");
                                                var zipFinalURL = parentUrl + zipChildUrl;
                                                animation.zipUrl = Uri.encodeFull(zipFinalURL);
                                              }
                                            }

                                            animation.thumbUrl = animation.thumbUrl ?? "";
                                            animation.zipUrl = animation.zipUrl ?? "";
                                            animations.add(animation);
                                          }
                                        }

                                        category.animations = animations;
                                        categories.add(category);
                                      }
                                    }
                                    batteryAnimation.categories = categories;
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    setState(() {
                                      saveFileName = "batteryAnimationTemplates.json";
                                      prettyprint = encoder.convert(batteryAnimation.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.dashboard_outlined, size: 20.0),
                                label: Text(
                                  "Create Json",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                ),
                              ),
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
                                          backgroundColor: Utils.getAccentColor(),
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
                                          style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Colors.green),
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
}
