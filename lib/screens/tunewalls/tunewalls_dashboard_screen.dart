import 'dart:convert';
import 'dart:io';

import 'package:aani_generator/controller/tunewalls_menu_controller.dart';
import 'package:aani_generator/model/ringer_stickers.dart';
import 'package:aani_generator/model/ringer_wallpaper.dart';
import 'package:aani_generator/views/flutter_highlight.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:provider/provider.dart';

import '../../model/zedge_ringtone.dart';
import '../../util/utils.dart';

class TuneWallsDashboard extends StatefulWidget {
  const TuneWallsDashboard({
    Key? key,
  }) : super(key: key);

  @override
  TuneWallsDashboardState createState() => TuneWallsDashboardState();
}

class TuneWallsDashboardState extends State<TuneWallsDashboard> {
  String prettyprint = "";
  String language = 'json';
  String theme = 'androidstudio';
  final scText = ScrollController(initialScrollOffset: 0);
  String saveFileName = "ringerTone.json";

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Scaffold(
        key: context.read<TuneWallsMenuController>().scaffoldKey,
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
                            'Make Json',
                            style: TextStyle(fontSize: 36.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, color: Colors.redAccent),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 36.0,
                              height: 4.0,
                              decoration: const BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.all(Radius.circular(2.0))),
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
                                  backgroundColor: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var ringtoneCategory = ZedgeRingtoneCategory();
                                    var categories = <ZedgeRingtone>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/Ringer";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    int categoryId = 0;
                                    for (FileSystemEntity file in files) {
                                      var category = ZedgeRingtone();
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        categoryId++;
                                        var path = file.path;
                                        var filename = path.split("\\").last;
                                        category.categoryName = filename;
                                        category.categoryId = categoryId;
                                        var ringtones = <Ringtone>[];
                                        Directory subDirs = Directory(file.path);
                                        List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                        int itemId = 0;
                                        for (FileSystemEntity file in subFiles) {
                                          itemId++;
                                          var path = file.path;

                                          var filename = path.split("\\").last;
                                          var fileNameWithoutExtension = filename.substring(0, filename.indexOf('.'));

                                          var ringtone = Ringtone();
                                          var imageUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                          var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                          var imageFinalURL = parentUrl + imageChildUrl;
                                          ringtone.ringtoneTitle = fileNameWithoutExtension;
                                          ringtone.ringtoneUrl = Uri.encodeFull(imageFinalURL);
                                          ringtone.ringtoneId = itemId;
                                          ringtone.ringtoneTitle = ringtone.ringtoneTitle ?? "";
                                          ringtone.ringtoneUrl = ringtone.ringtoneUrl ?? "";
                                          ringtone.ringtoneId = ringtone.ringtoneId ?? 1;
                                          ringtones.add(ringtone);
                                        }
                                        category.categoryThumb = "";
                                        category.ringtoneCount = itemId;
                                        category.ringtones = ringtones;
                                        categories.add(category);
                                      }
                                    }
                                    ringtoneCategory.categories = categories;
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    setState(() {
                                      saveFileName = "ringerRingtones.json";
                                      prettyprint = encoder.convert(ringtoneCategory.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.music_note_rounded, size: 20.0),
                                label: Text(
                                  "Tune Json",
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
                                  backgroundColor: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var stickerCategory = RingerStickerCategory();
                                    var categories = <RingerSticker>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/Ringer";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    int categoryId = 0;
                                    for (FileSystemEntity file in files) {
                                      var category = RingerSticker();
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        categoryId++;
                                        var path = file.path;
                                        var filename = path.split("\\").last;
                                        category.categoryName = filename;
                                        category.categoryId = categoryId;
                                        var stickers = <Sticker>[];
                                        Directory subDirs = Directory(file.path);
                                        List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                        int itemId = 0;
                                        for (FileSystemEntity file in subFiles) {
                                          var path = file.path;
                                          var filename = path.split("\\").last;
                                          var fileNameWithoutExtension = filename.substring(0, filename.indexOf('.'));

                                          var sticker = Sticker();
                                          var imageUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                          var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                          var imageFinalURL = parentUrl + imageChildUrl;
                                          if (itemId == 0) {
                                            category.categoryThumb = Uri.encodeFull(imageFinalURL);
                                          }
                                          itemId++;

                                          sticker.stickerTitle = fileNameWithoutExtension;
                                          sticker.stickerUrl = Uri.encodeFull(imageFinalURL);
                                          sticker.stickerId = itemId;
                                          sticker.stickerTitle = sticker.stickerTitle ?? "";
                                          sticker.stickerUrl = sticker.stickerUrl ?? "";
                                          sticker.stickerId = sticker.stickerId ?? 1;
                                          stickers.add(sticker);
                                        }

                                        category.stickerCount = itemId;
                                        category.stickers = stickers;
                                        categories.add(category);
                                      }
                                    }
                                    stickerCategory.categories = categories;
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    setState(() {
                                      saveFileName = "ringerStickers.json";
                                      prettyprint = encoder.convert(stickerCategory.toJson());
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
                            Expanded(
                              child: ElevatedButton.icon(
                                style: TextButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var wallpaperCategory = RingerWallpaperCategory();
                                    var categories = <RingerWallpaper>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/Ringer";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    int categoryId = 0;
                                    for (FileSystemEntity file in files) {
                                      var category = RingerWallpaper();
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        categoryId++;
                                        var path = file.path;
                                        var filename = path.split("\\").last;
                                        category.categoryName = filename;
                                        category.categoryId = categoryId;
                                        // var wallpapers = <Wallpaper>[];
                                        Directory subDirs = Directory(file.path);
                                        List<FileSystemEntity> subFiles = subDirs.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                        int itemId = 0;
                                        for (FileSystemEntity file in subFiles) {
                                          var path = file.path;
                                          var filename = path.split("\\").last;
                                          var fileNameWithoutExtension = filename.substring(0, filename.indexOf('.'));

                                          // var wallpaper = Wallpaper();
                                          var imageUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                          var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                          var imageFinalURL = parentUrl + imageChildUrl;
                                          if (category.categoryThumb == "" && !imageFinalURL.endsWith("json")) {
                                            category.categoryThumb = Uri.encodeFull(imageFinalURL);
                                          }
                                          if (imageFinalURL.endsWith("json")) {
                                            category.categoryJson = Uri.encodeFull(imageFinalURL);
                                          }
                                          itemId++;

                                          // wallpaper.wallpaperTitle = fileNameWithoutExtension;
                                          // wallpaper.wallpaperUrl = Uri.encodeFull(imageFinalURL);
                                          // wallpaper.wallpaperId = itemId;
                                          // wallpaper.wallpaperTitle = wallpaper.wallpaperTitle ?? "";
                                          // wallpaper.wallpaperUrl = wallpaper.wallpaperUrl ?? "";
                                          // wallpaper.wallpaperId = wallpaper.wallpaperId ?? 1;
                                          // wallpaper.isPremium = 0;
                                          // wallpapers.add(wallpaper);
                                        }

                                        category.wallpaperCount = itemId;
                                        // category.wallpapers = wallpapers;
                                        categories.add(category);
                                      }
                                    }
                                    wallpaperCategory.categories = categories;
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    setState(() {
                                      saveFileName = "ringerWallpapers.json";
                                      prettyprint = encoder.convert(wallpaperCategory.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.photo, size: 20.0),
                                label: Text(
                                  "Wallpaper Json",
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
                                  backgroundColor: Colors.redAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                    vertical: 18.0,
                                  ),
                                ),
                                onPressed: () async {
                                  String? outputFile = await FilePicker.platform.getDirectoryPath(dialogTitle: 'Select Directory', lockParentWindow: false);
                                  try {
                                    var wallpaperCategory = Wallpapers();
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/Ringer";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false)..sort((l, r) => r.statSync().modified.compareTo(l.statSync().modified));
                                    var wallpapers = <Wallpaper>[];
                                    int itemId = 0;
                                    for (FileSystemEntity file in files) {
                                      var path = file.path;
                                      var filename = path.split("\\").last;
                                      var fileNameWithoutExtension = filename.substring(0, filename.indexOf('.'));
                                      if (!filename.endsWith("json")) {
                                        itemId++;
                                        var wallpaper = Wallpaper();
                                        var imageUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                        var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                        var imageFinalURL = parentUrl + imageChildUrl;

                                        wallpaper.wallpaperTitle = fileNameWithoutExtension;
                                        wallpaper.wallpaperUrl = Uri.encodeFull(imageFinalURL);
                                        wallpaper.wallpaperId = itemId;
                                        wallpaper.wallpaperTitle = wallpaper.wallpaperTitle ?? "";
                                        wallpaper.wallpaperUrl = wallpaper.wallpaperUrl ?? "";
                                        wallpaper.wallpaperId = wallpaper.wallpaperId ?? 1;
                                        wallpaper.isPremium = 0;
                                        wallpapers.add(wallpaper);
                                      }
                                    }
                                    wallpaperCategory.wallpapers = wallpapers;
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    var path = directory.path;
                                    var filename = path.split("\\").last;
                                    setState(() {
                                      saveFileName = "${filename.toLowerCase().replaceAll(" ", "_")}.json";
                                      prettyprint = encoder.convert(wallpaperCategory.toJson());
                                    });
                                  } catch (e) {}
                                },
                                icon: const Icon(Icons.photo, size: 20.0),
                                label: Text(
                                  "Sub Wallpaper",
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
                                          backgroundColor: Colors.redAccent,
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
                                        label: Text(
                                          "Save",
                                          style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
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
