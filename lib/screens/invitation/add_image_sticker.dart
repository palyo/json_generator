import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/utils.dart';
import 'models/invitation_card.dart';

class DialogImageSticker extends StatefulWidget {
  Function(ImageSticker, int) imageSticker;
  ImageSticker? sticker;
  int? stickerPos = -1;

  DialogImageSticker({
    Key? key,
    required this.sticker,
    required this.stickerPos,
    required this.imageSticker,
  }) : super(key: key);

  @override
  DialogImageStickerState createState() => DialogImageStickerState();
}

class DialogImageStickerState extends State<DialogImageSticker> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController imageNameController = TextEditingController(text: "sticker1.png");
  FocusNode imageNameFocusNode = FocusNode();
  bool imageNameValid = false;

  TextEditingController imageMaskNameController = TextEditingController(text: "mask1.png");
  FocusNode imageMaskNameFocusNode = FocusNode();
  bool imageMaskNameValid = false;

  TextEditingController imagePointsController = TextEditingController();
  FocusNode imagePointsFocusNode = FocusNode();
  bool imagePointsValid = false;

  TextEditingController widthController = TextEditingController();
  FocusNode widthFocusNode = FocusNode();
  bool widthValid = false;

  TextEditingController heightController = TextEditingController();
  FocusNode heightFocusNode = FocusNode();
  bool heightValid = false;

  TextEditingController posXController = TextEditingController();
  FocusNode posXFocusNode = FocusNode();
  bool posXValid = false;

  TextEditingController posYController = TextEditingController();
  FocusNode posYFocusNode = FocusNode();
  bool posYValid = false;

  TextEditingController opacityController = TextEditingController(text: "255");
  FocusNode opacityFocusNode = FocusNode();
  bool opacityValid = false;

  TextEditingController rotationController = TextEditingController(text: "0");
  FocusNode rotationFocusNode = FocusNode();
  bool rotationValid = false;

  Function(ImageSticker, int)? imageSticker;
  ImageSticker? sticker;

  int? stickerPos = -1;
  String? status;

  @override
  void initState() {
    super.initState();
    imageSticker = widget.imageSticker;

    sticker = widget.sticker;
    stickerPos = widget.stickerPos;
    if (sticker == null) {
      status = "Add";
    } else {
      imageNameController = TextEditingController(text: sticker!.stickerPath);
      imageMaskNameController = TextEditingController(text: sticker!.maskPath);
      widthController = TextEditingController(text: sticker!.width.toString());
      heightController = TextEditingController(text: sticker!.height.toString());
      posXController = TextEditingController(text: sticker!.posX.toString());
      posYController = TextEditingController(text: sticker!.posY.toString());
      opacityController = TextEditingController(text: sticker!.stcOpacity.toString());
      rotationController = TextEditingController(text: sticker!.rotation.toString());
      status = "Update";
    }
  }

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 200.0),
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: heightSize * 0.80,
            width: widthSize * 0.65,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              color: Utils.getCardColor(),
              child: Stack(
                children: [
                  Opacity(opacity: 0.02, child: Image.asset("assets/images/ic_banner_bg.png", fit: BoxFit.cover)),
                  Padding(
                    padding: EdgeInsets.only(left: widthSize * 0.05, right: widthSize * 0.05, top: heightSize * 0, bottom: heightSize * 0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$status Image Sticker',
                              style: const TextStyle(fontSize: 36.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, color: Colors.pinkAccent),
                            ),
                          ),
                          SizedBox(height: heightSize * 0.01),
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
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: imageNameFocusNode,
                                  controller: imageNameController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && imageNameValid) {
                                      setState(() {
                                        imageNameValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Image Name",
                                    errorText: imageNameValid ? "Image Name" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: imageNameValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: imageNameFocusNode.hasFocus
                                            ? imageNameValid
                                                ? Utils.getErrorColor()
                                                : Colors.pinkAccent
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
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(imageNameFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: imageMaskNameFocusNode,
                                  controller: imageMaskNameController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && imageMaskNameValid) {
                                      setState(() {
                                        imageMaskNameValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Image Mask Name",
                                    errorText: imageMaskNameValid ? "Image Mask Name" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: imageMaskNameValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: imageMaskNameFocusNode.hasFocus
                                            ? imageMaskNameValid
                                                ? Utils.getErrorColor()
                                                : Colors.pinkAccent
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
                                      borderSide: const BorderSide(color: Colors.pinkAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(imageMaskNameFocusNode);
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
                                  focusNode: imagePointsFocusNode,
                                  controller: imagePointsController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && imagePointsValid) {
                                      setState(() {
                                        imagePointsValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Points",
                                    errorText: imagePointsValid ? "Enter Points" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: imagePointsValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: imagePointsFocusNode.hasFocus
                                            ? imagePointsValid
                                                ? Utils.getErrorColor()
                                                : Colors.pinkAccent
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
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(imagePointsFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              MaterialButton(
                                color: Colors.pinkAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                                padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
                                onPressed: () async {
                                  String points = imagePointsController.text;
                                  var split = points.split(";");
                                  var height, width, left, top;
                                  for (String value in split) {
                                    if (value.contains("height")) {
                                      height = value.split(":")[1].replaceAll("px", "");
                                    }
                                    if (value.contains("width")) {
                                      width = value.split(":")[1].replaceAll("px", "");
                                    }
                                    if (value.contains("left")) {
                                      left = value.split(":")[1].replaceAll("px", "");
                                    }
                                    if (value.contains("top")) {
                                      top = value.split(":")[1].replaceAll("px", "");
                                    }
                                  }
                                  setState(() {
                                    widthController = TextEditingController(text: double.parse(width).toStringAsFixed(2).toString());
                                    heightController = TextEditingController(text: double.parse(height).toStringAsFixed(2).toString());
                                    posXController = TextEditingController(text: double.parse(left).toStringAsFixed(2).toString());
                                    posYController = TextEditingController(text: double.parse(top).toStringAsFixed(2).toString());
                                  });
                                },
                                child: Text(
                                  'Evaluate',
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
                                  focusNode: widthFocusNode,
                                  controller: widthController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                                  ],
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && widthValid) {
                                      setState(() {
                                        widthValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Width",
                                    errorText: widthValid ? "Enter Width" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: widthValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: widthFocusNode.hasFocus
                                            ? widthValid
                                                ? Utils.getErrorColor()
                                                : Colors.pinkAccent
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
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(widthFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: heightFocusNode,
                                  controller: heightController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                                  ],
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && heightValid) {
                                      setState(() {
                                        heightValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Height",
                                    errorText: heightValid ? "Enter Height" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: heightValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: heightFocusNode.hasFocus
                                            ? heightValid
                                                ? Utils.getErrorColor()
                                                : Colors.pinkAccent
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
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(heightFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: posYFocusNode,
                                  controller: posYController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                                  ],
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && posYValid) {
                                      setState(() {
                                        posYValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "PosY",
                                    errorText: posYValid ? "Enter PosY" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: posYValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: posYFocusNode.hasFocus
                                            ? posYValid
                                                ? Utils.getErrorColor()
                                                : Colors.pinkAccent
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
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(posYFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: posXFocusNode,
                                  controller: posXController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                                  ],
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && posXValid) {
                                      setState(() {
                                        posXValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "PosX",
                                    errorText: posXValid ? "Enter PosX" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: posXValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: posXFocusNode.hasFocus
                                            ? posXValid
                                                ? Utils.getErrorColor()
                                                : Colors.pinkAccent
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
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(posXFocusNode);
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
                                  focusNode: opacityFocusNode,
                                  controller: opacityController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                                  ],
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && opacityValid) {
                                      setState(() {
                                        opacityValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Opacity",
                                    errorText: opacityValid ? "Enter Opacity" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: opacityValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: opacityFocusNode.hasFocus
                                            ? opacityValid
                                                ? Utils.getErrorColor()
                                                : Colors.pinkAccent
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
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(opacityFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: rotationFocusNode,
                                  controller: rotationController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                                  ],
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && rotationValid) {
                                      setState(() {
                                        rotationValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Rotation",
                                    errorText: rotationValid ? "Enter Rotation" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: rotationValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: rotationFocusNode.hasFocus
                                            ? rotationValid
                                                ? Utils.getErrorColor()
                                                : Colors.pinkAccent
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
                                      borderSide: BorderSide(color: Colors.pinkAccent, width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(rotationFocusNode);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: heightSize * 0.02),
                          SizedBox(height: heightSize * 0.04),
                          MaterialButton(
                            color: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                            padding: const EdgeInsets.fromLTRB(100, 18, 100, 18),
                            onPressed: () async {
                              var image = ImageSticker(stickerPath: imageNameController.text, maskPath: imageMaskNameController.text, width: double.parse(widthController.text), height: double.parse(heightController.text), posY: double.parse(posYController.text), posX: double.parse(posXController.text), stcOpacity: int.parse(opacityController.text), rotation: int.parse(rotationController.text), colorType: "colored", type: "STICKER", stcColor: 0, stcHue: 0);
                              imageSticker!(image, stickerPos!);
                              Navigator.pop(context, true);
                            },
                            child: Text(
                              '$status Sticker',
                              style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w500, color: Utils.getTextColor()),
                            ),
                          ),
                          SizedBox(height: heightSize * 0.04),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
