import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:flutter_poster_studio_json_generator/model/fonts.dart';
import 'package:flutter_poster_studio_json_generator/model/sticker_pack.dart';
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
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
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
          decoration:
              BoxDecoration(color: Utils.getCardColor(), borderRadius: const BorderRadius.all(Radius.circular(2.0))),
          child: SizedBox(
              height: heightSize,
              width: widthSize,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Opacity(
                          opacity: 0.02, child: Image.asset("assets/images/ic_banner_bg.png", fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: widthSize * 0.05, right: widthSize * 0.05, top: heightSize * 0, bottom: heightSize * 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(
                          height: 100.0,
                        ),
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
                            Expanded(
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
                                  setState(() {
                                    saveFileName = "";
                                    prettyprint = "";
                                  });
                                  String? outputFile = await FilePicker.platform
                                      .getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var posterTemplate = PosterCategory();
                                    var categories = <Categories>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/PosterStudio/Posters";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
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
                                        List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                        for (FileSystemEntity file in subFiles) {
                                          Directory childDirs = Directory(file.path);
                                          List<FileSystemEntity> childFiles = childDirs.listSync(recursive: false);
                                          var template = Templates();
                                          for (FileSystemEntity file in childFiles) {
                                            if (file.path.split("\\").last.startsWith("thumb")) {
                                              var imageUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                              var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                              var imageFinalURL = parentUrl + imageChildUrl;
                                              template.demoUrl = Uri.encodeFull(imageFinalURL);
                                            } else if (file.path.split("\\").last.endsWith("zip")) {
                                              var zipUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                              var zipChildUrl = zipUrl.replaceAll("\\", "/");
                                              var zipFinalURL = parentUrl + zipChildUrl;
                                              template.zipUrl = Uri.encodeFull(zipFinalURL);
                                            } else if (file.path.split("\\").last.endsWith("isPremium")) {
                                              template.isPremium = 1;
                                            } else if (file.path.split("\\").last.endsWith("isTrending")) {
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
                                  "Posters Json",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
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
                                  backgroundColor: Utils.getAccentColor(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    saveFileName = "";
                                    prettyprint = "";
                                  });
                                  String? outputFile = await FilePicker.platform
                                      .getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var backgroundCategory = BackgroundCategory();
                                    var categories = <BGCategories>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/PosterStudio";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
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
                                        List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false);
                                        int backgroundId = 0;
                                        for (FileSystemEntity file in subFiles) {
                                          FileStat subFileStat = file.statSync();
                                          if (subFileStat.type.toString() != "directory") {
                                            backgroundId++;
                                            var background = Backgrounds();
                                            background.backgroundId = backgroundId;
                                            var bgPath = file.path.replaceAll(file.parent.parent.parent.path, "");
                                            var bgChildUrl = bgPath.replaceAll("\\", "/");
                                            var bgFinalURL = parentUrl + bgChildUrl;
                                            background.backgroundImage = Uri.encodeFull(bgFinalURL);
                                            String fileName = file.path.split("\\").last;
                                            var bgThumbPath =
                                                "${file.parent.path}/thumb/${fileName.replaceAll("jpg", "png")}"
                                                    .replaceAll(file.parent.parent.parent.path, "");
                                            var bgThumbChildUrl = bgThumbPath.replaceAll("\\", "/");
                                            var bgThumbFinalURL = parentUrl + bgThumbChildUrl;
                                            background.backgroundThumbImage = Uri.encodeFull(bgThumbFinalURL);
                                            background.isPremium = 0;
                                            backgrounds.add(background);
                                          }
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
                                  "Backgrounds Json",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
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
                                  backgroundColor: Utils.getAccentColor(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    saveFileName = "";
                                    prettyprint = "";
                                  });
                                  String? outputFile = await FilePicker.platform
                                      .getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var stickers = Stickers();
                                    var stickerPacks = <StickerPacks>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/PosterStudio";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    int categoryId = 0;
                                    for (FileSystemEntity file in files) {
                                      var stickerPack = StickerPacks();
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        categoryId++;
                                        var path = file.path;
                                        var filename = path.split("\\").last;
                                        stickerPack.stickerPackName = filename;
                                        stickerPack.stickerPackId = categoryId;

                                        Directory subDirs = Directory(file.path);
                                        List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false);
                                        for (FileSystemEntity file in subFiles) {
                                          if (file.path.split("\\").last.startsWith("thumb")) {
                                            var imageUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                            var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                            var imageFinalURL = parentUrl + imageChildUrl;
                                            stickerPack.thumbUrl = Uri.encodeFull(imageFinalURL);
                                          } else if (file.path.split("\\").last.endsWith("zip")) {
                                            var zipUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                            var zipChildUrl = zipUrl.replaceAll("\\", "/");
                                            var zipFinalURL = parentUrl + zipChildUrl;
                                            stickerPack.zipUrl = Uri.encodeFull(zipFinalURL);
                                          } else if (file.path.split("\\").last.endsWith("isPremium")) {
                                            stickerPack.isPremium = 1;
                                          }
                                        }
                                      }

                                      stickerPack.thumbUrl = stickerPack.thumbUrl ?? "";
                                      stickerPack.zipUrl = stickerPack.zipUrl ?? "";
                                      stickerPack.isPremium = stickerPack.isPremium ?? 0;
                                      stickerPacks.add(stickerPack);
                                    }
                                    stickers.stickerPacks = stickerPacks;

                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    setState(() {
                                      saveFileName = "posterStudioStickers.json";
                                      prettyprint = encoder.convert(stickers.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.theater_comedy_rounded, size: 20.0),
                                label: Text(
                                  "Stickers Json",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
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
                                  backgroundColor: Utils.getAccentColor(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    saveFileName = "";
                                    prettyprint = "";
                                  });
                                  String? outputFile = await FilePicker.platform
                                      .getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var fonts = Fonts();
                                    var fontList = <Font>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/PosterStudio";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    int fontId = 0;
                                    for (FileSystemEntity file in files) {
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        var font = Font();
                                        fontId++;
                                        var path = file.path;
                                        var filename = path.split("\\").last;
                                        font.fontName = filename;
                                        font.fontId = fontId;
                                        Directory subDirs = Directory(file.path);
                                        List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false);
                                        for (FileSystemEntity file in subFiles) {
                                          if (file.path.split("\\").last.endsWith("png")) {
                                            var fontUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                            var fontChildUrl = fontUrl.replaceAll("\\", "/");
                                            var fontFinalURL = parentUrl + fontChildUrl;
                                            font.thumbUrl = Uri.encodeFull(fontFinalURL);
                                          }
                                          if (file.path.split("\\").last.endsWith("ttf") ||
                                              file.path.split("\\").last.endsWith("otf") ||
                                              file.path.split("\\").last.endsWith("TTF") ||
                                              file.path.split("\\").last.endsWith("OTF")) {
                                            var fontUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                            var fontChildUrl = fontUrl.replaceAll("\\", "/");
                                            var fontFinalURL = parentUrl + fontChildUrl;
                                            font.fontUrl = Uri.encodeFull(fontFinalURL);
                                          }
                                        }

                                        font.fontName = font.fontName ?? "";
                                        font.fontUrl = font.fontUrl ?? "";
                                        fontList.add(font);
                                      }
                                    }
                                    fonts.fonts = fontList;
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    setState(() {
                                      saveFileName = "posterStudioFonts.json";
                                      prettyprint = encoder.convert(fonts.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.text_fields_rounded, size: 20.0),
                                label: Text(
                                  "Fonts Json",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
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
                                  decoration: BoxDecoration(
                                      color: Utils.getBGColor(),
                                      borderRadius: const BorderRadius.all(Radius.circular(8.0))),
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
                                          String? outputFile = await FilePicker.platform.saveFile(
                                              dialogTitle: 'Save your json to desire location', fileName: saveFileName);
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
                    ),
                  )
                ],
              )),
        )));
  }
}
