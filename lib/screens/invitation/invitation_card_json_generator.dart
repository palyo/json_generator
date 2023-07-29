import 'dart:convert';
import 'dart:io';

import 'package:aani_generator/screens/invitation/extra/invitation_menu_controller.dart';
import 'package:aani_generator/screens/invitation/invitation_add_page.dart';
import 'package:aani_generator/screens/invitation/models/invitation_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../util/utils.dart';

class InvitationCardJsonGenerator extends StatefulWidget {
  const InvitationCardJsonGenerator({Key? key}) : super(key: key);

  @override
  State<InvitationCardJsonGenerator> createState() => _InvitationCardJsonGeneratorState();
}

class _InvitationCardJsonGeneratorState extends State<InvitationCardJsonGenerator> {
  List<CardPage> pages = [];
  int isPagePosition = -1;

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    final scPages = ScrollController(initialScrollOffset: 0);
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
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: EdgeInsets.only(left: widthSize * 0.05, right: widthSize * 0.05, top: heightSize * 0, bottom: heightSize * 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 100.0,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Generate Json',
                          style: TextStyle(fontSize: 36.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, color: Colors.pinkAccent),
                        ),
                      ),
                      SizedBox(height: heightSize * 0.02),
                      Container(
                        decoration: BoxDecoration(
                          color: Utils.getCardColor(),
                          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12.0, right: 4.0, top: 4.0, bottom: 4.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Card Pages',
                                                style: TextStyle(fontSize: 18.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                                              ),
                                            ),
                                            Align(
                                                alignment: Alignment.centerRight,
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
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return DialogInvitationPage(
                                                            cardPage: null,
                                                            pagePos: -1,
                                                            pageListener: (CardPage val, int pos) {
                                                              setState(() {
                                                                pages.add(val);
                                                              });
                                                            },
                                                          );
                                                        });
                                                  },
                                                  icon: const Icon(Icons.add, size: 20.0),
                                                  label: Text(
                                                    "Add Page",
                                                    style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                            if (pages.isNotEmpty) ...[
                              SizedBox(height: 8.0,),
                              ConstrainedBox(
                                constraints: BoxConstraints(maxHeight: heightSize * 0.5),
                                child: Scrollbar(
                                  thickness: 8,
                                  thumbVisibility: true,
                                  interactive: true,
                                  controller: scPages,
                                  child: ReorderableListView(
                                    scrollController: scPages,
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    onReorder: (oldIndex, newIndex) {
                                      if (newIndex > oldIndex) newIndex--;
                                      final item = pages.removeAt(oldIndex);
                                      pages.insert(newIndex, item);
                                      setState(() {});
                                    },
                                    children: [
                                      for (int index = 0; index < pages.length; index++)
                                        Padding(
                                          key: ValueKey(pages[index]),
                                          padding: const EdgeInsets.symmetric(vertical:4.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Utils.getBGColor().withOpacity(0.5),
                                              borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                                            ),
                                            child: Column(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.centerLeft,
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: InkWell(
                                                        onTap: () {
                                                          if (isPagePosition == index) {
                                                            isPagePosition = -1;
                                                          } else {
                                                            isPagePosition = index;
                                                          }
                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                            child: Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                "Page ${index + 1}",
                                                                style: const TextStyle(fontSize: 18.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Colors.pinkAccent),
                                                              ),
                                                              SizedBox(height: heightSize * 0.01),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 100.0),
                                                                child: Text(
                                                                  pages[index].toString(),
                                                                  style: TextStyle(fontSize: 16.0, height: 1.8, fontFamily: 'Sans', fontStyle: FontStyle.italic, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 40.0),
                                                      child: Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            InkWell(
                                                                onTap: () {
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) {
                                                                        return DialogInvitationPage(
                                                                          cardPage: pages[index],
                                                                          pagePos: index,
                                                                          pageListener: (CardPage val, int pos) {
                                                                            setState(() {
                                                                              pages[pos] = val;
                                                                            });
                                                                          },
                                                                        );
                                                                      });
                                                                },
                                                                child: Container(
                                                                  width: 32,
                                                                  height: 32,
                                                                  decoration: const BoxDecoration(
                                                                    color: Colors.pinkAccent,
                                                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                                  ),
                                                                  child: const Center(
                                                                      child: Icon(
                                                                    Icons.edit_outlined,
                                                                    size: 22,
                                                                    color: Colors.white,
                                                                  )),
                                                                )),
                                                            const SizedBox(width: 6.0),
                                                            InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    pages.removeAt(index);
                                                                  });
                                                                },
                                                                child: Container(
                                                                  width: 32,
                                                                  height: 32,
                                                                  decoration: const BoxDecoration(
                                                                    color: Colors.redAccent,
                                                                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                                  ),
                                                                  child: const Center(
                                                                      child: Icon(
                                                                    Icons.delete_outline,
                                                                    size: 22,
                                                                    color: Colors.white,
                                                                  )),
                                                                )),
                                                            const SizedBox(width: 6.0),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ]
                          ],
                        ),
                      ),
                      SizedBox(height: heightSize * 0.02),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Spacer(),
                            Align(
                                alignment: Alignment.centerRight,
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
                                    FilePickerResult? result = await FilePicker.platform.pickFiles(lockParentWindow: true);

                                    if (result != null) {
                                      File file = File(result.files.single.path!);
                                      final contents = await file.readAsString();

                                      Map<String, dynamic> valueMap = json.decode(contents);
                                      InvitationCard template = InvitationCard.fromJson(valueMap);
                                      pages = template.pages ?? [];
                                      setState(() {});
                                    }
                                  },
                                  icon: const Icon(Icons.save_outlined, size: 20.0),
                                  label: Text(
                                    "Open Json",
                                    style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  ),
                                )),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
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
                                    var template = InvitationCard(posterType: "template", pages: pages);
                                    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                    String prettyprint = encoder.convert(template.toJson());

                                    String? outputFile = await FilePicker.platform.saveFile(dialogTitle: 'Save your json to desire location', fileName: "index.json", lockParentWindow: true);

                                    try {
                                      File returnedFile = File('$outputFile');
                                      await returnedFile.writeAsString(prettyprint);
                                    } catch (e) {
                                      if (kDebugMode) {
                                        print("ERROR: $e");
                                      }
                                    }
                                    if (kDebugMode) {
                                      print("INVITATION CARD: $prettyprint");
                                    }
                                  },
                                  icon: const Icon(Icons.save_outlined, size: 20.0),
                                  label: Text(
                                    "Save To Json",
                                    style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
