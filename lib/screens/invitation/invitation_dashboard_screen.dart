import 'dart:convert';
import 'dart:io';

import 'package:aani_generator/screens/invitation/extra/invitation_menu_controller.dart';
import 'package:aani_generator/screens/invitation/models/invitation_bg.dart';
import 'package:aani_generator/screens/invitation/models/invitation_sticker_pack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:provider/provider.dart';

import 'models/invitation_category.dart';
import '../../util/utils.dart';
import '../../views/flutter_highlight.dart';
import 'models/invitation_fonts.dart';
import 'models/invitation_template.dart';

class InvitationDashboard extends StatefulWidget {
  const InvitationDashboard({
    Key? key,
  }) : super(key: key);

  @override
  InvitationDashboardState createState() => InvitationDashboardState();
}

class InvitationDashboardState extends State<InvitationDashboard> {
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
        key: context.read<InvitationMenuController>().scaffoldKey,
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
                            style: TextStyle(fontSize: 36.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, color: Colors.pinkAccent),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 36.0,
                              height: 4.0,
                              decoration: const BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.all(Radius.circular(2.0))),
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
                                  backgroundColor: Colors.pinkAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var invitationCategory = InvitationCategory();
                                    var categories = <InvitationSubCategory>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/InvitationCard";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false);
                                    for (FileSystemEntity file in files) {
                                      var category = InvitationSubCategory();
                                      var subCategories = <Categories>[];
                                      var path = file.path;
                                      var filename = path.split("\\").last;
                                      category.categoryName = filename;
                                      Directory directory = Directory(file.path);
                                      List<FileSystemEntity> files = directory.listSync(recursive: false);
                                      FileStat fileStat = file.statSync();

                                      if (fileStat.type.toString() == "directory") {
                                        int categoryId = 0;
                                        for (FileSystemEntity file in files) {
                                          var subCategory = Categories();
                                          FileStat fileStat = file.statSync();
                                          if (fileStat.type.toString() == "directory") {
                                            categoryId++;
                                            subCategory.subCategoryId = categoryId;
                                            Directory invitationDirectory = Directory(file.path);
                                            List<FileSystemEntity> invitationDirectories = invitationDirectory.listSync(recursive: false);
                                            for (FileSystemEntity file in invitationDirectories) {
                                              var path = file.path;
                                              var filename = path.split("\\").last;
                                              if (filename.endsWith(".title")) {
                                                subCategory.subCategoryName = filename.replaceAll(".title", "");
                                              }
                                              if (filename.endsWith(".desc")) {
                                                subCategory.subCategoryDesc = filename.replaceAll(".desc", "");
                                              }
                                              if (filename.endsWith(".color")) {
                                                subCategory.subCategoryColor = filename.replaceAll(".color", "");
                                              }
                                              if (filename == "template.json") {
                                                var imageUrl = file.path.replaceAll(file.parent.parent.parent.parent.path, "");
                                                var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                                var imageFinalURL = parentUrl + imageChildUrl;
                                                subCategory.templateJsonUrl = Uri.encodeFull(imageFinalURL);
                                              }
                                              if (filename.startsWith("thumb.")) {
                                                var imageUrl = file.path.replaceAll(file.parent.parent.parent.parent.path, "");
                                                var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                                var imageFinalURL = parentUrl + imageChildUrl;
                                                subCategory.subCategoryThumb = Uri.encodeFull(imageFinalURL);
                                              }
                                            }
                                            subCategory.templateJsonUrl = subCategory.templateJsonUrl ?? "";
                                            subCategories.add(subCategory);
                                          }
                                        }
                                        category.categories = subCategories;
                                        categories.add(category);
                                      }
                                    }
                                    invitationCategory.categories = categories;
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    setState(() {
                                      saveFileName = "invitationTemplates.json";
                                      prettyprint = encoder.convert(invitationCategory.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.card_giftcard_rounded, size: 20.0),
                                label: Text(
                                  "Category Json",
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
                                  backgroundColor: Colors.pinkAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var invitationTemplate = InvitationTemplate();
                                    var cardTemplates = <CardTemplate>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/InvitationCard";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> subFiles = directory.listSync(recursive: false);
                                    for (FileSystemEntity file in subFiles) {
                                      var template = CardTemplate();
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        Directory childDirs = Directory(file.path);
                                        List<FileSystemEntity> childFiles = childDirs.listSync(recursive: false);
                                        for (FileSystemEntity file in childFiles) {
                                          if (file.path.split("\\").last.startsWith("thumb")) {
                                            var imageUrl = file.path.replaceAll(file.parent.parent.parent.parent.parent.path, "");
                                            var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                            var imageFinalURL = parentUrl + imageChildUrl;
                                            template.demoUrl = Uri.encodeFull(imageFinalURL);
                                          } else if (file.path.split("\\").last.endsWith("zip")) {
                                            var zipUrl = file.path.replaceAll(file.parent.parent.parent.parent.parent.path, "");
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

                                        cardTemplates.add(template);
                                      } else {
                                        var path = file.path;
                                        var filePath = path.split("\\").last;
                                        if (kDebugMode) {
                                          print(filePath);
                                        }
                                      }
                                    }
                                    invitationTemplate.cardTemplate = cardTemplates;
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    setState(() {
                                      saveFileName = "template.json";
                                      prettyprint = encoder.convert(invitationTemplate.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.card_giftcard_rounded, size: 20.0),
                                label: Text(
                                  "Card Json",
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
                                  backgroundColor: Colors.pinkAccent,
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
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var backgroundCategory = InvitationBGCategories();
                                    var categories = <InvitationBGCategory>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/InvitationCard";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    int categoryId = 0;
                                    for (FileSystemEntity file in files) {
                                      var category = InvitationBGCategory();
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        categoryId++;
                                        var path = file.path;
                                        var filename = path.split("\\").last;
                                        category.bgCategoryName = filename;
                                        category.bgCategoryId = categoryId;

                                        var backgrounds = <InvitationBG>[];
                                        Directory subDirs = Directory(file.path);
                                        List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false);
                                        int backgroundId = 0;
                                        for (FileSystemEntity file in subFiles) {
                                          FileStat subFileStat = file.statSync();
                                          if (subFileStat.type.toString() != "directory") {
                                            backgroundId++;
                                            var background = InvitationBG();
                                            background.backgroundId = backgroundId;
                                            var bgPath = file.path.replaceAll(file.parent.parent.parent.path, "");
                                            var bgChildUrl = bgPath.replaceAll("\\", "/");
                                            var bgFinalURL = parentUrl + bgChildUrl;
                                            background.backgroundImage = Uri.encodeFull(bgFinalURL);
                                            String fileName = file.path.split("\\").last;
                                            var bgThumbPath = "${file.parent.path}/thumb/${fileName.replaceAll("jpg", "png")}".replaceAll(file.parent.parent.parent.path, "");
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
                                      saveFileName = "backgrounds.json";
                                      prettyprint = encoder.convert(backgroundCategory.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.image_outlined, size: 20.0),
                                label: Text(
                                  "Background Json",
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
                                  backgroundColor: Colors.pinkAccent,
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
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var fonts = InvitationFonts();
                                    var fontList = <InvitationFont>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/InvitationCard";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    for (FileSystemEntity file in files) {
                                      FileStat fileStat = file.statSync();
                                      var path = file.path;
                                      var locale = path.split("\\").last;
                                      int fontId = 0;
                                      if (fileStat.type.toString() == "directory") {
                                        Directory subFile = Directory(file.path);
                                        List<FileSystemEntity> subFiles = subFile.listSync(recursive: false);
                                        for (FileSystemEntity file in subFiles) {
                                          FileStat fileStat = file.statSync();
                                          if (fileStat.type.toString() == "directory") {
                                            var font = InvitationFont();
                                            fontId++;
                                            var path = file.path;
                                            var filename = path.split("\\").last;
                                            font.fontName = filename;
                                            font.fontId = fontId;
                                            font.locale = locale;
                                            Directory subDirs = Directory(file.path);
                                            List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false);
                                            for (FileSystemEntity file in subFiles) {
                                              if (file.path.split("\\").last.endsWith("png")) {
                                                var fontUrl = file.path.replaceAll(file.parent.parent.parent.parent.path, "");
                                                var fontChildUrl = fontUrl.replaceAll("\\", "/");
                                                var fontFinalURL = parentUrl + fontChildUrl;
                                                font.thumbUrl = Uri.encodeFull(fontFinalURL);
                                              }
                                              if (file.path.split("\\").last.endsWith("ttf") || file.path.split("\\").last.endsWith("otf") || file.path.split("\\").last.endsWith("TTF") || file.path.split("\\").last.endsWith("OTF")) {
                                                var fontUrl = file.path.replaceAll(file.parent.parent.parent.parent.path, "");
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
                                      }
                                    }
                                    fonts.fonts = fontList;
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    setState(() {
                                      saveFileName = "fonts.json";
                                      prettyprint = encoder.convert(fonts.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.card_giftcard_rounded, size: 20.0),
                                label: Text(
                                  "Font Json",
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
                                  backgroundColor: Colors.pinkAccent,
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
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var stickers = InvitationStickerPacks();
                                    var stickerPacks = <InvitationStickerPack>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/InvitationCard";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    int categoryId = 0;
                                    for (FileSystemEntity file in files) {
                                      var stickerPack = InvitationStickerPack();
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
                                      saveFileName = "stickers.json";
                                      prettyprint = encoder.convert(stickers.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.theater_comedy_rounded, size: 20.0),
                                label: Text(
                                  "Stickers Json",
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
                                          backgroundColor: Colors.pinkAccent,
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
}
