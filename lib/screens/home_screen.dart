import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_poster_studio_json_generator/views/flutter_highlight.dart';
import 'package:provider/provider.dart';

import '../controller/menu_controller.dart';
import '../model/backgrounds.dart';
import '../model/poster_template.dart';
import '../util/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String prettyprint = "";
  String language = 'json';
  String theme = 'androidstudio';
  final scText = ScrollController(initialScrollOffset: 0);

  String saveFileName = "posterStudioTemplates.json";

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
        key: context.read<MenuController>().scaffoldKey,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
              color: Utils.getCardColor(), borderRadius: const BorderRadius.all(Radius.circular(2.0))),
          child: Center(
            child: SizedBox(
                height: heightSize * 0.90,
                width: widthSize * 0.80,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: widthSize * 0.05,
                        right: widthSize * 0.05,
                        top: heightSize * 0,
                        bottom: heightSize * 0),
                    child: Stack(
                      children: [
                        Opacity(
                            opacity: 0.02,
                            child:
                                Image.asset("assets/images/ic_banner_bg.png", fit: BoxFit.cover)),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Make Final Json',
                                style: TextStyle(
                                    fontSize: 36.0,
                                    fontFamily: 'Sans',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                    color: Utils.getAccentColor()),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 36.0,
                                  height: 4.0,
                                  decoration: BoxDecoration(
                                      color: Utils.getAccentColor(),
                                      borderRadius: const BorderRadius.all(Radius.circular(2.0))),
                                )),
                            SizedBox(height: heightSize * 0.04),
                            Row(
                              children: [
                                ElevatedButton.icon(
                                  style: TextButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: Utils.getAccentColor(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 18.0,
                                    ),
                                  ),
                                  onPressed: () async {
                                    String? outputFile = await FilePicker.platform.getDirectoryPath(
                                        dialogTitle: 'Select Directory', lockParentWindow: false);
                                    try {
                                      var posterTemplate = PosterCategory();
                                      var categories = <Categories>[];
                                      var parentUrl =
                                          "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/PosterStudio/Posters";
                                      Directory directory = Directory('$outputFile');
                                      List<FileSystemEntity> files =
                                          directory.listSync(recursive: false);
                                      int categoryId = 0;
                                      for (FileSystemEntity file in files) {
                                        var category = Categories();
                                        FileStat fileStat = file.statSync();
                                        if (fileStat.type.toString() == "directory") {
                                          categoryId++;
                                          var path = file.path;
                                          var filename = path.split("\\").last;
                                          category.categoryName = filename;
                                          category.categoryId = categoryId;

                                          var templates = <Templates>[];
                                          Directory subDirs = Directory(file.path);
                                          List<FileSystemEntity> subFiles =
                                              subDirs.listSync(recursive: false);
                                          for (FileSystemEntity file in subFiles) {
                                            Directory childDirs = Directory(file.path);
                                            List<FileSystemEntity> childFiles =
                                                childDirs.listSync(recursive: false);
                                            var template = Templates();
                                            for (FileSystemEntity file in childFiles) {
                                              if (file.path.split("\\").last.startsWith("thumb")) {
                                                var imageUrl = file.path
                                                    .replaceAll(file.parent.parent.parent.path, "");
                                                var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                                var imageFinalURL = parentUrl + imageChildUrl;
                                                template.demoUrl = Uri.encodeFull(imageFinalURL);
                                              } else if (file.path
                                                  .split("\\")
                                                  .last
                                                  .endsWith("zip")) {
                                                var zipUrl = file.path
                                                    .replaceAll(file.parent.parent.parent.path, "");
                                                var zipChildUrl = zipUrl.replaceAll("\\", "/");
                                                var zipFinalURL = parentUrl + zipChildUrl;
                                                template.zipUrl = Uri.encodeFull(zipFinalURL);
                                              } else if (file.path
                                                  .split("\\")
                                                  .last
                                                  .endsWith("isPremium")) {
                                                template.isPremium = 1;
                                              } else if (file.path
                                                  .split("\\")
                                                  .last
                                                  .endsWith("isTrending")) {
                                                template.isTrending = 1;
                                              }
                                            }

                                            template.demoUrl = template.demoUrl ?? "";
                                            template.zipUrl = template.zipUrl ?? "";
                                            template.isPremium = template.isPremium ?? 0;
                                            template.isTrending = template.isTrending ?? 0;

                                            templates.add(template);
                                          }
                                          category.templates = templates;
                                          categories.add(category);
                                        }
                                      }
                                      posterTemplate.categories = categories;

                                      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                      setState(() {
                                        saveFileName = "posterStudioTemplates.json";
                                        prettyprint = encoder.convert(posterTemplate.toJson());
                                      });
                                    } catch (e) {}
                                  },
                                  icon: const Icon(Icons.dashboard_outlined, size: 20.0),
                                  label: Text(
                                    "Choose Poster Directory",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: Utils.getTextColor()),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                ElevatedButton.icon(
                                  style: TextButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: Utils.getAccentColor(),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 18.0,
                                    ),
                                  ),
                                  onPressed: () async {
                                    String? outputFile = await FilePicker.platform.getDirectoryPath(
                                        dialogTitle: 'Select Directory', lockParentWindow: false);
                                    try {
                                      var backgroundCategory = BackgroundCategory();
                                      var categories = <BGCategories>[];
                                      var parentUrl =
                                          "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/PosterStudio";
                                      Directory directory = Directory('$outputFile');
                                      List<FileSystemEntity> files =
                                          directory.listSync(recursive: false);
                                      int categoryId = 0;
                                      for (FileSystemEntity file in files) {
                                        var category = BGCategories();
                                        FileStat fileStat = file.statSync();
                                        if (fileStat.type.toString() == "directory") {
                                          categoryId++;
                                          var path = file.path;
                                          var filename = path.split("\\").last;
                                          category.bgCategoryName = filename;
                                          category.bgCategoryId = categoryId;

                                          var backgrounds = <Backgrounds>[];
                                          Directory subDirs = Directory(file.path);
                                          List<FileSystemEntity> subFiles =
                                              subDirs.listSync(recursive: false);
                                          int backgroundId = 0;
                                          for (FileSystemEntity file in subFiles) {
                                            backgroundId++;
                                            var background = Backgrounds();
                                            background.backgroundId = backgroundId;

                                            var bgPath = file.path
                                                .replaceAll(file.parent.parent.parent.path, "");
                                            var bgChildUrl = bgPath.replaceAll("\\", "/");
                                            var bgFinalURL = parentUrl + bgChildUrl;
                                            background.backgroundImage = Uri.encodeFull(bgFinalURL);

                                            background.isPremium = 0;
                                            backgrounds.add(background);
                                          }
                                          category.backgrounds = backgrounds;
                                        }
                                        categories.add(category);
                                      }
                                      backgroundCategory.categories = categories;

                                      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                      setState(() {
                                        saveFileName = "posterStudioBackgrounds.json";
                                        prettyprint = encoder.convert(backgroundCategory.toJson());
                                      });
                                    } catch (e) {}
                                  },
                                  icon: const Icon(Icons.image_outlined, size: 20.0),
                                  label: Text(
                                    "Choose Background Directory",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: Utils.getTextColor()),
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
                                      decoration: BoxDecoration(
                                          color: Utils.getBGColor(),
                                          borderRadius:
                                              const BorderRadius.all(Radius.circular(8.0))),
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
                                              String? outputFile = await FilePicker.platform
                                                  .saveFile(
                                                      dialogTitle:
                                                          'Save your json to desire location',
                                                      fileName: saveFileName);
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
                                            label: Text(
                                              "Save",
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontFamily: 'Sans',
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w300,
                                                  color: Utils.getTextColor()),
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
                        )
                      ],
                    ),
                  ),
                )),
          ),
        )));
  }
}
