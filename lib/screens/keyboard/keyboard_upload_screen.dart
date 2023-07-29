import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aani_generator/screens/keyboard/model/file_status.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';

import '../../util/utils.dart';
import 'keyboard_menu_controller.dart';

class KeyboardUpload extends StatefulWidget {
  const KeyboardUpload({
    Key? key,
  }) : super(key: key);

  @override
  KeyboardUploadState createState() => KeyboardUploadState();
}

TextEditingController nameController = TextEditingController();
FocusNode nameFocusNode = FocusNode();
bool nameValid = false;

TextEditingController packageNameController = TextEditingController();
FocusNode packageNameFocusNode = FocusNode();
bool packageNameValid = false;

TextEditingController tagController = TextEditingController();
FocusNode tagFocusNode = FocusNode();
bool tagValid = false;

TextEditingController smallPreviewController = TextEditingController();
FocusNode smallPreviewFocusNode = FocusNode();
bool smallPreviewValid = false;

TextEditingController bigPreviewController = TextEditingController();
FocusNode bigPreviewFocusNode = FocusNode();
bool bigPreviewValid = false;

TextEditingController zipPreviewController = TextEditingController();
FocusNode zipPreviewFocusNode = FocusNode();
bool zipPreviewValid = false;

bool isPremium = false;
bool isNew = false;
bool isHot = false;

String uploadButtonTitle = "Upload";
double _uploadProgress = 0.0;
bool _uploading = false;

class KeyboardUploadState extends State<KeyboardUpload> {
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Upload',
                            style: TextStyle(fontSize: 36.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, color: Colors.blueAccent),
                          ),
                        ),
                        SizedBox(height: heightSize * 0.002),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              width: 36.0,
                              height: 4.0,
                              decoration: const BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.all(Radius.circular(2.0))),
                            )),
                        SizedBox(height: heightSize * 0.04),
                        TextFormField(
                          focusNode: nameFocusNode,
                          controller: nameController,
                          cursorColor: Colors.blueAccent,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty && nameValid) {
                              setState(() {
                                nameValid = false;
                              });
                            }
                          },
                          style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                          decoration: InputDecoration(
                            labelText: "Name",
                            errorText: nameValid ? "Enter Name" : null,
                            errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: nameValid ? Utils.getErrorColor() : Utils.getHintColor()),
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Sans',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300,
                                color: nameFocusNode.hasFocus
                                    ? nameValid
                                        ? Utils.getErrorColor()
                                        : Colors.blueAccent
                                    : Utils.getHintColor()),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(nameFocusNode);
                            });
                          },
                        ),
                        SizedBox(height: heightSize * 0.02),
                        TextFormField(
                          focusNode: packageNameFocusNode,
                          controller: packageNameController,
                          cursorColor: Colors.blueAccent,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty && packageNameValid) {
                              setState(() {
                                packageNameValid = false;
                              });
                            }
                          },
                          style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                          decoration: InputDecoration(
                            labelText: "Package Name",
                            errorText: packageNameValid ? "Enter Package Name" : null,
                            errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: packageNameValid ? Utils.getErrorColor() : Utils.getHintColor()),
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Sans',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300,
                                color: packageNameFocusNode.hasFocus
                                    ? packageNameValid
                                        ? Utils.getErrorColor()
                                        : Colors.blueAccent
                                    : Utils.getHintColor()),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(packageNameFocusNode);
                            });
                          },
                        ),
                        SizedBox(height: heightSize * 0.02),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                focusNode: smallPreviewFocusNode,
                                controller: smallPreviewController,
                                cursorColor: Colors.blueAccent,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                onChanged: (value) {
                                  if (value.isNotEmpty && smallPreviewValid) {
                                    setState(() {
                                      smallPreviewValid = false;
                                    });
                                  }
                                },
                                style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                decoration: InputDecoration(
                                  labelText: "Small Preview",
                                  errorText: smallPreviewValid ? "Choose Small Preview" : null,
                                  errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: smallPreviewValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                  labelStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: smallPreviewFocusNode.hasFocus
                                          ? smallPreviewValid
                                              ? Utils.getErrorColor()
                                              : Colors.blueAccent
                                          : Utils.getHintColor()),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context).requestFocus(smallPreviewFocusNode);
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: widthSize * 0.01),
                            MaterialButton(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                              padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(lockParentWindow: true);

                                if (result != null) {
                                  File file = File(result.files.single.path!!);
                                  setState(() {
                                    smallPreviewController = TextEditingController(text: file.path);
                                  });
                                }
                              },
                              child: Text(
                                'Choose File',
                                style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: heightSize * 0.02),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                focusNode: bigPreviewFocusNode,
                                controller: bigPreviewController,
                                cursorColor: Colors.blueAccent,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                onChanged: (value) {
                                  if (value.isNotEmpty && bigPreviewValid) {
                                    setState(() {
                                      bigPreviewValid = false;
                                    });
                                  }
                                },
                                style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                decoration: InputDecoration(
                                  labelText: "Big Preview",
                                  errorText: bigPreviewValid ? "Choose Big Preview" : null,
                                  errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: bigPreviewValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                  labelStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: bigPreviewFocusNode.hasFocus
                                          ? bigPreviewValid
                                              ? Utils.getErrorColor()
                                              : Colors.blueAccent
                                          : Utils.getHintColor()),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context).requestFocus(bigPreviewFocusNode);
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: widthSize * 0.01),
                            MaterialButton(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                              padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(lockParentWindow: true);

                                if (result != null) {
                                  File file = File(result.files.single.path!!);
                                  setState(() {
                                    bigPreviewController = TextEditingController(text: file.path);
                                  });
                                }
                              },
                              child: Text(
                                'Choose File',
                                style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: heightSize * 0.02),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                focusNode: zipPreviewFocusNode,
                                controller: zipPreviewController,
                                cursorColor: Colors.blueAccent,
                                keyboardType: TextInputType.text,
                                maxLines: 1,
                                onChanged: (value) {
                                  if (value.isNotEmpty && zipPreviewValid) {
                                    setState(() {
                                      zipPreviewValid = false;
                                    });
                                  }
                                },
                                style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                decoration: InputDecoration(
                                  labelText: "Zip Source",
                                  errorText: zipPreviewValid ? "Choose Zip Source" : null,
                                  errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: zipPreviewValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                  labelStyle: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: zipPreviewFocusNode.hasFocus
                                          ? zipPreviewValid
                                              ? Utils.getErrorColor()
                                              : Colors.blueAccent
                                          : Utils.getHintColor()),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    FocusScope.of(context).requestFocus(zipPreviewFocusNode);
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: widthSize * 0.01),
                            MaterialButton(
                              color: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                              padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(lockParentWindow: true);

                                if (result != null) {
                                  File file = File(result.files.single.path!!);
                                  setState(() {
                                    zipPreviewController = TextEditingController(text: file.path);
                                  });
                                }
                              },
                              child: Text(
                                'Choose File',
                                style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: heightSize * 0.02),
                        TextFormField(
                          focusNode: tagFocusNode,
                          controller: tagController,
                          cursorColor: Colors.blueAccent,
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty && tagValid) {
                              setState(() {
                                tagValid = false;
                              });
                            }
                          },
                          style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                          decoration: InputDecoration(
                            labelText: "Theme Tags",
                            errorText: tagValid ? "Enter Theme Tags" : null,
                            errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: tagValid ? Utils.getErrorColor() : Utils.getHintColor()),
                            labelStyle: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Sans',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w300,
                                color: tagFocusNode.hasFocus
                                    ? tagValid
                                        ? Utils.getErrorColor()
                                        : Colors.blueAccent
                                    : Utils.getHintColor()),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getErrorColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(tagFocusNode);
                            });
                          },
                        ),
                        SizedBox(height: heightSize * 0.02),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Utils.getWhiteColor(),
                              activeColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                              value: isPremium,
                              onChanged: (value) {
                                setState(() {
                                  isPremium = value!;
                                });
                              },
                            ),
                            Text(
                              "isPremium",
                              style: TextStyle(fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: isPremium ? Colors.blueAccent : Utils.getTextColor()),
                            ),
                            SizedBox(width: widthSize * 0.01),
                            Checkbox(
                              checkColor: Utils.getWhiteColor(),
                              activeColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                              value: isNew,
                              onChanged: (value) {
                                setState(() {
                                  isNew = value!;
                                });
                              },
                            ),
                            Text(
                              "isNew",
                              style: TextStyle(fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: isNew ? Colors.blueAccent : Utils.getTextColor()),
                            ),
                            SizedBox(width: widthSize * 0.01),
                            Checkbox(
                              checkColor: Utils.getWhiteColor(),
                              activeColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                              value: isHot,
                              onChanged: (value) {
                                setState(() {
                                  isHot = value!;
                                });
                              },
                            ),
                            Text(
                              "isHot",
                              style: TextStyle(fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: isHot ? Colors.blueAccent : Utils.getTextColor()),
                            ),
                          ],
                        ),
                        SizedBox(height: heightSize * 0.02),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ElevatedButton.icon(
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
                                      Directory directory = Directory('$outputFile');
                                      var path = directory.path;
                                      var themeTag = path.split("\\").last;
                                      List<FileSystemEntity> files = directory.listSync(recursive: false);
                                      for (FileSystemEntity file in files) {
                                        var path = file.path;
                                        var fileName = path.split("\\").last;
                                        if (fileName.endsWith(".zip")) {
                                          setState(() {
                                            nameController = TextEditingController(text: toTitleCase(fileName.replaceAll("_", " ").replaceAll(".zip", "")));
                                            packageNameController = TextEditingController(text: "my.photo.picture.keyboard.keyboard.theme.${fileName.replaceAll(".zip", "")}");
                                            zipPreviewController = TextEditingController(text: path);
                                            tagController = TextEditingController(text: themeTag);
                                          });
                                        }

                                        if (fileName.endsWith("BigPreview.webp") || fileName.endsWith("BigPreview.jpg") || fileName.endsWith("BigPreview.jpeg") || fileName.endsWith("BigPreview.png")) {
                                          bigPreviewController = TextEditingController(text: path);
                                        }

                                        if (fileName.endsWith("SmallPreview.webp") || fileName.endsWith("SmallPreview.jpg") || fileName.endsWith("SmallPreview.jpeg") || fileName.endsWith("SmallPreview.png")) {
                                          smallPreviewController = TextEditingController(text: path);
                                        }
                                      }
                                    } catch (e) {}
                                  },
                                  icon: const Icon(Icons.save_outlined, size: 20.0),
                                  label: Text(
                                    "Choose Directory",
                                    style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  ),
                                ),
                                SizedBox(width: widthSize * 0.01),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_uploading)
                                      CircularProgressIndicator(value: _uploadProgress)
                                    else
                                      ElevatedButton.icon(
                                        style: TextButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: Colors.blueAccent,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 24.0,
                                            vertical: 18.0,
                                          ),
                                        ),
                                        onPressed: () async {
                                          setState(() {
                                            _uploading = true;
                                          });
                                          File themeSmallPreviewFile = File(smallPreviewController.text);
                                          File themeBigPreviewFile = File(bigPreviewController.text);
                                          File themeZipFile = File(zipPreviewController.text);

                                          int randomNumber = 40 + Random().nextInt(100 - 40 + 1);

                                          await uploadFilesAndData(
                                            context: context,
                                            name: nameController.text ?? "",
                                            pkgName: nameController.text ?? "",
                                            themeSmallPreview: themeSmallPreviewFile,
                                            themeBigPreview: themeBigPreviewFile,
                                            themeZip: themeZipFile,
                                            isPremium: (isPremium ? "1" : "0"),
                                            isHot: (isHot ? "1" : "0"),
                                            isNew: (isHot ? "1" : "0"),
                                            themeType: "notlive",
                                            userHit: "${randomNumber}k",
                                            themeTag: tagController.text,
                                            onProgress: (FileUploadProgress progress) {
                                              setState(() {
                                                _uploadProgress = progress.sent / progress.total;
                                                uploadButtonTitle = "Uploading ${_uploadProgress}%";
                                                debugPrint("PROCESS:===>  $_uploadProgress");
                                              });
                                            },
                                          );

                                          setState(() {
                                            uploadButtonTitle = "Upload";
                                            _uploading = false;
                                            _uploadProgress = 0.0;
                                            nameController = TextEditingController(text: '');
                                            packageNameController = TextEditingController(text: '');
                                            smallPreviewController = TextEditingController(text: '');
                                            bigPreviewController = TextEditingController(text: '');
                                            zipPreviewController = TextEditingController(text: '');
                                            tagController = TextEditingController(text: '');
                                          });
                                        },
                                        icon: const Icon(Icons.save_outlined, size: 20.0),
                                        label: Text(
                                          uploadButtonTitle,
                                          style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              )),
        )));
  }

  Future<FileUploadProgress?> uploadFilesAndData({
    required BuildContext context,
    required String name,
    required String pkgName,
    required File themeSmallPreview,
    required File themeBigPreview,
    required File themeZip,
    required String isPremium,
    required String themeType,
    required String userHit,
    required String themeTag,
    required String isNew,
    required String isHot,
    required void Function(FileUploadProgress) onProgress,
  }) async {
    // Replace 'your_api_endpoint' with the actual endpoint URL where you want to upload the files and data.
    final Uri apiUrl = Uri.parse('http://phpstack-694322-3596470.cloudwaysapps.com/insertapi.php');

    // Create a multipart request
    final request = http.MultipartRequest('POST', apiUrl);

    // Attach theme_small_preview file to the request
    final themeSmallPreviewMimeData = lookupMimeType(themeSmallPreview.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final themeSmallPreviewUpload = await http.MultipartFile.fromPath(
      'theme_small_preview',
      themeSmallPreview.path,
      contentType: MediaType(themeSmallPreviewMimeData![0], themeSmallPreviewMimeData[1]),
    );
    request.files.add(themeSmallPreviewUpload);

    // Attach theme_big_preview file to the request
    final themeBigPreviewMimeData = lookupMimeType(themeBigPreview.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final themeBigPreviewUpload = await http.MultipartFile.fromPath(
      'theme_big_preview',
      themeBigPreview.path,
      contentType: MediaType(themeBigPreviewMimeData![0], themeBigPreviewMimeData[1]),
    );
    request.files.add(themeBigPreviewUpload);

    // Attach theme_zip file to the request
    final themeZipMimeData = lookupMimeType(themeZip.path, headerBytes: [0xFF, 0xD8])?.split('/');
    final themeZipUpload = await http.MultipartFile.fromPath(
      'theme_zip',
      themeZip.path,
      contentType: MediaType(themeZipMimeData![0], themeZipMimeData[1]),
    );
    request.files.add(themeZipUpload);

    // Attach other data to the request
    request.fields['name'] = name;
    request.fields['pkg_name'] = pkgName;
    request.fields['is_premium'] = isPremium;
    request.fields['theme_type'] = themeType;
    request.fields['user_hit'] = userHit;
    request.fields['theme_tag'] = themeTag;
    request.fields['is_new'] = isNew;
    request.fields['is_hot'] = isHot;

    try {
      // Send the request
      final response = await request.send();

      // Listen for the upload progress
      int totalBytes = response.contentLength!;
      int sentBytes = 0;
      response.stream.transform(utf8.decoder).listen((event) {
        sentBytes += event.length;
        final progress = FileUploadProgress(totalBytes, sentBytes);
        onProgress(progress);
      });

      // Check if the request was successful (status code 200-299)
      if (response.statusCode >= 200 && response.statusCode < 300) {
        print('Files and data uploaded successfully');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.white,
            content: Text(
              'Files and data uploaded successfully',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getBGColor()),
            )));
        // You can handle the response data here if needed.
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 1),
            backgroundColor: Colors.white,
            content: Text(
              'File upload failed with status ${response.statusCode}',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getBGColor()),
            )));
        print('File upload failed with status ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.white,
          content: Text(
            'File upload error: $e',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getBGColor()),
          )));
      print('File upload error: $e');
    }
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
