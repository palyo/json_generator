import 'dart:convert';

import 'package:aani_generator/controller/tunewalls_menu_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../util/utils.dart';

class TuneWallsNotify extends StatefulWidget {
  const TuneWallsNotify({
    Key? key,
  }) : super(key: key);

  @override
  TuneWallsNotifyState createState() => TuneWallsNotifyState();
}

class TuneWallsNotifyState extends State<TuneWallsNotify> {
  TextEditingController titleController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  bool titleValid = false;
  TextEditingController bodyController = TextEditingController();
  FocusNode bodyFocusNode = FocusNode();
  bool bodyValid = false;

  TextEditingController previewController = TextEditingController();
  FocusNode previewFocusNode = FocusNode();
  bool previewValid = false;

  TextEditingController sourceUrlController = TextEditingController();
  FocusNode sourceUrlFocusNode = FocusNode();
  bool sourceUrlValid = false;

  var notifyType = "NORMAL";
  var notifyTopic = "general_tune";

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
                            'Push Notification',
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
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: titleFocusNode,
                                    controller: titleController,
                                    cursorColor: Colors.redAccent,
                                    keyboardType: TextInputType.text,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (value.isNotEmpty && titleValid) {
                                        setState(() {
                                          titleValid = false;
                                        });
                                      }
                                    },
                                    style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                    decoration: InputDecoration(
                                      labelText: "Title",
                                      errorText: titleValid ? "Enter Title" : null,
                                      errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: titleValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                      labelStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Sans',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w300,
                                          color: titleFocusNode.hasFocus
                                              ? titleValid
                                                  ? Utils.getErrorColor()
                                                  : Colors.redAccent
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
                                        borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        FocusScope.of(context).requestFocus(titleFocusNode);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: heightSize * 0.02),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: bodyFocusNode,
                                    controller: bodyController,
                                    cursorColor: Colors.redAccent,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                    onChanged: (value) {
                                      if (value.isNotEmpty && titleValid) {
                                        setState(() {
                                          bodyValid = false;
                                        });
                                      }
                                    },
                                    style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                    decoration: InputDecoration(
                                      labelText: "Body",
                                      errorText: bodyValid ? "Enter Body" : null,
                                      errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: bodyValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                      labelStyle: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: 'Sans',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w300,
                                          color: bodyFocusNode.hasFocus
                                              ? bodyValid
                                                  ? Utils.getErrorColor()
                                                  : Colors.redAccent
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
                                        borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                                        borderRadius: BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        FocusScope.of(context).requestFocus(bodyFocusNode);
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: heightSize * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 135,
                                  child: ListTile(
                                    dense: true,
                                    minLeadingWidth: 0,
                                    minVerticalPadding: 0,
                                    horizontalTitleGap: 10,
                                    title: Center(child: Text('NORMAL', style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: notifyType == "NORMAL" ? Colors.redAccent : Utils.getTextColor()))),
                                    leading: SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Radio(
                                        value: "NORMAL",
                                        groupValue: notifyType,
                                        activeColor: Colors.redAccent,
                                        onChanged: (String? value) {
                                          setState(() {
                                            notifyType = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 160,
                                  child: ListTile(
                                    dense: true,
                                    minLeadingWidth: 0,
                                    minVerticalPadding: 0,
                                    horizontalTitleGap: 10,
                                    title: Center(child: Text('WALLPAPER', style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: notifyType == "WALLPAPER" ? Colors.redAccent : Utils.getTextColor()))),
                                    leading: SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Radio(
                                        value: "WALLPAPER",
                                        groupValue: notifyType,
                                        activeColor: Colors.redAccent,
                                        onChanged: (String? value) {
                                          setState(() {
                                            notifyType = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 210,
                                  child: ListTile(
                                    dense: true,
                                    minLeadingWidth: 0,
                                    minVerticalPadding: 0,
                                    horizontalTitleGap: 10,
                                    title: Center(child: Text('VIDEO WALLPAPER', style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: notifyType == "VIDEO_WALLPAPER" ? Colors.redAccent : Utils.getTextColor()))),
                                    leading: SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Radio(
                                        value: "VIDEO_WALLPAPER",
                                        groupValue: notifyType,
                                        activeColor: Colors.redAccent,
                                        onChanged: (String? value) {
                                          setState(() {
                                            notifyType = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: heightSize * 0.02),
                            if (notifyType != "NORMAL") ...[
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      focusNode: previewFocusNode,
                                      controller: previewController,
                                      cursorColor: Colors.redAccent,
                                      keyboardType: TextInputType.url,
                                      maxLines: 1,
                                      onChanged: (value) {
                                        if (value.isNotEmpty && titleValid) {
                                          setState(() {
                                            previewValid = false;
                                          });
                                        }
                                      },
                                      style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                      decoration: InputDecoration(
                                        labelText: "Preview Url",
                                        errorText: previewValid ? "Enter Preview Url" : null,
                                        errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: previewValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                        labelStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Sans',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color: previewFocusNode.hasFocus
                                                ? previewValid
                                                    ? Utils.getErrorColor()
                                                    : Colors.redAccent
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
                                          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          FocusScope.of(context).requestFocus(previewFocusNode);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: heightSize * 0.02),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      focusNode: sourceUrlFocusNode,
                                      controller: sourceUrlController,
                                      cursorColor: Colors.redAccent,
                                      keyboardType: TextInputType.url,
                                      maxLines: 1,
                                      onChanged: (value) {
                                        if (value.isNotEmpty && sourceUrlValid) {
                                          setState(() {
                                            sourceUrlValid = false;
                                          });
                                        }
                                      },
                                      style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                      decoration: InputDecoration(
                                        labelText: "Source URL",
                                        errorText: sourceUrlValid ? "Enter Source URL" : null,
                                        errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: sourceUrlValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                        labelStyle: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Sans',
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w300,
                                            color: sourceUrlFocusNode.hasFocus
                                                ? sourceUrlValid
                                                    ? Utils.getErrorColor()
                                                    : Colors.redAccent
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
                                          borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
                                          borderRadius: BorderRadius.circular(4.0),
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          FocusScope.of(context).requestFocus(sourceUrlFocusNode);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: heightSize * 0.02),
                            ],
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 168,
                                  child: ListTile(
                                    dense: true,
                                    minLeadingWidth: 0,
                                    minVerticalPadding: 0,
                                    horizontalTitleGap: 20,
                                    title: Center(child: Text('General Notify', style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: notifyTopic == "general_tune" ? Colors.redAccent : Utils.getTextColor()))),
                                    leading: SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Radio(
                                        value: "general_tune",
                                        groupValue: notifyTopic,
                                        activeColor: Colors.redAccent,
                                        onChanged: (String? value) {
                                          setState(() {
                                            notifyTopic = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 140,
                                  child: ListTile(
                                    dense: true,
                                    minLeadingWidth: 0,
                                    minVerticalPadding: 0,
                                    horizontalTitleGap: 20,
                                    title: Center(child: Text('Test Notify', style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: notifyTopic == "test_tune" ? Colors.redAccent : Utils.getTextColor()))),
                                    leading: SizedBox(
                                      width: 10,
                                      height: 10,
                                      child: Radio(
                                        value: "test_tune",
                                        groupValue: notifyTopic,
                                        activeColor: Colors.redAccent,
                                        onChanged: (String? value) {
                                          setState(() {
                                            notifyTopic = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: heightSize * 0.05),
                            MaterialButton(
                              color: Colors.redAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                              padding: const EdgeInsets.fromLTRB(100, 18, 100, 18),
                              onPressed: () async {
                                if (notifyType != "NORMAL") {
                                  var pushNotification = PushNotification();
                                  pushNotification.title = titleController.text.toString() ?? "";
                                  pushNotification.body = bodyController.text.toString() ?? "";
                                  pushNotification.type = notifyType.toString() ?? "";
                                  pushNotification.imageUrl = previewController.text.toString() ?? "";
                                  pushNotification.sourceUrl = sourceUrlController.text.toString() ?? "";
                                  var map = pushNotification.toMap();
                                  sendNotification(map, notifyTopic).then((value) {
                                    if (value) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 1),
                                          backgroundColor: Colors.white,
                                          content: Text(
                                            'Send push notification successfully',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getBGColor()),
                                          )));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 1),
                                          backgroundColor: Colors.white,
                                          content: Text(
                                            'Send push notification failed due to some reason',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getBGColor()),
                                          )));
                                    }
                                  });
                                } else {
                                  var pushNotification = PushNotification();
                                  pushNotification.title = titleController.text.toString() ?? "";
                                  pushNotification.body = bodyController.text.toString() ?? "";
                                  pushNotification.type = "";
                                  pushNotification.imageUrl = "";
                                  pushNotification.sourceUrl = "";
                                  var map = pushNotification.toMap();
                                  sendNotification(map, notifyTopic).then((value) {
                                    if (value) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 1),
                                          backgroundColor: Colors.white,
                                          content: Text(
                                            'Send push notification successfully',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getBGColor()),
                                          )));
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 1),
                                          backgroundColor: Colors.white,
                                          content: Text(
                                            'Send push notification failed due to some reason',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getBGColor()),
                                          )));
                                    }
                                  });
                                }
                              },
                              child: Text(
                                'Notify',
                                style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                              ),
                            ),
                            SizedBox(height: heightSize * 0.04),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )),
        )));
  }

  Future<bool> sendNotification(Map<String, dynamic> body, String notifyTopic) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json', 'Authorization': 'key=AAAAuKjkpUw:APA91bFlTehIo_KIjHzBa6Ua24v2jGr3mwrvir-AzY1q3hSY1HV33tkJmY7EARtgiyNxYj_tq0-pr-RlbANvPcmSBEIhYgbxektzfoE2Dx45FVzNHaPuRkjb0YKM9rTM0ixRlLslTcxF'};
    var url = Uri.https('fcm.googleapis.com', 'fcm/send');
    var dynamicMap = {'to': '/topics/$notifyTopic', 'data': body};
    var encodedBody = jsonEncode(dynamicMap);
    var response = await http.post(url, headers: requestHeaders, body: encodedBody);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}

class PushNotification {
  String? title;
  String? body;
  String? type;
  String? imageUrl;
  String? sourceUrl;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'type': type,
      'imageUrl': imageUrl,
      'sourceUrl': sourceUrl,
    };
  }
}
