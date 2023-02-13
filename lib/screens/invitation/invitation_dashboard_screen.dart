import 'dart:convert';
import 'dart:io';

import 'package:aani_generator/controller/invitation_menu_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:provider/provider.dart';

import '../../model/invitation_category.dart';
import '../../util/utils.dart';
import '../../views/flutter_highlight.dart';

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
                                    var categories = <Categories>[];
                                    var parentUrl = "https://filedn.eu/lT5MTrPP9oSbL8W0tjWsva5/InvitationCard";
                                    Directory directory = Directory('$outputFile');
                                    List<FileSystemEntity> files = directory.listSync(recursive: false);
                                    int categoryId = 0;
                                    for (FileSystemEntity file in files) {
                                      var category = Categories();
                                      FileStat fileStat = file.statSync();
                                      if (fileStat.type.toString() == "directory") {
                                        categoryId++;
                                        category.categoryId = categoryId;
                                        Directory invitationDirectory = Directory(file.path);
                                        List<FileSystemEntity> invitationDirectories = invitationDirectory.listSync(recursive: false);
                                        for (FileSystemEntity file in invitationDirectories) {
                                          var path = file.path;
                                          var filename = path.split("\\").last;
                                          if(filename.endsWith(".title")){
                                            category.categoryName = filename.replaceAll(".title", "");
                                          }
                                          if(filename.endsWith(".desc")){
                                            category.categoryDesc = filename.replaceAll(".desc", "");
                                          }
                                          if(filename.startsWith("thumb.")){
                                            var imageUrl = file.path.replaceAll(file.parent.parent.parent.path, "");
                                            var imageChildUrl = imageUrl.replaceAll("\\", "/");
                                            var imageFinalURL = parentUrl + imageChildUrl;
                                            category.categoryThumb = Uri.encodeFull(imageFinalURL);
                                          }
                                        }

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
