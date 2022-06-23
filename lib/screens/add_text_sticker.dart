import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poster_studio_json_generator/model/template.dart';

import '../util/utils.dart';

class DialogTextSticker extends StatefulWidget {
  Function(TextSticker) textSticker;

  DialogTextSticker({
    Key? key,
    required this.textSticker,
  }) : super(key: key);

  @override
  DialogTextStickerState createState() => DialogTextStickerState();
}

class DialogTextStickerState extends State<DialogTextSticker> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController textController = TextEditingController();
  FocusNode textFocusNode = FocusNode();
  bool textValid = false;

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

  TextEditingController fontNameController = TextEditingController(text: "font1.ttf");
  FocusNode fontNameFocusNode = FocusNode();
  bool fontNameValid = false;

  TextEditingController alphaController = TextEditingController(text: "255");
  FocusNode alphaFocusNode = FocusNode();
  bool alphaValid = false;

  TextEditingController textColorController = TextEditingController(text: "#FFFFFF");
  FocusNode textColorFocusNode = FocusNode();
  bool textColorValid = false;

  TextEditingController rotationController = TextEditingController(text: "0");
  FocusNode rotationFocusNode = FocusNode();
  bool rotationValid = false;

  bool isBoldText = false;
  bool isItalicText = false;

  Function(TextSticker)? textSticker;

  @override
  void initState() {
    super.initState();
    textSticker = widget.textSticker;
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
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16.0))),
              color: Utils.getCardColor(),
              child: Stack(
                children: [
                  Opacity(
                      opacity: 0.02,
                      child: Image.asset("assets/images/ic_banner_bg.png", fit: BoxFit.cover)),
                  Padding(
                    padding: EdgeInsets.only(
                        left: widthSize * 0.05,
                        right: widthSize * 0.05,
                        top: heightSize * 0,
                        bottom: heightSize * 0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Add Text Sticker',
                              style: TextStyle(
                                  fontSize: 36.0,
                                  fontFamily: 'Sans',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w700,
                                  color: Utils.getAccentColor()),
                            ),
                          ),
                          SizedBox(height: heightSize * 0.01),
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
                                flex: 1,
                                child: TextFormField(
                                  focusNode: textFocusNode,
                                  controller: textController,
                                  cursorColor: Utils.getAccentColor(),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && textValid) {
                                      setState(() {
                                        textValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Text",
                                    errorText: textValid ? "Enter Text" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: textValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: textFocusNode.hasFocus
                                            ? textValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getAccentColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(textFocusNode);
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
                                  focusNode: widthFocusNode,
                                  controller: widthController,
                                  cursorColor: Utils.getAccentColor(),
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
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Width",
                                    errorText: widthValid ? "Enter Width" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: widthValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: widthFocusNode.hasFocus
                                            ? widthValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getAccentColor(), width: 2.0),
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
                                  cursorColor: Utils.getAccentColor(),
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
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Height",
                                    errorText: heightValid ? "Enter Height" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: heightValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: heightFocusNode.hasFocus
                                            ? heightValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getAccentColor(), width: 2.0),
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
                                  cursorColor: Utils.getAccentColor(),
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
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "PosY",
                                    errorText: posYValid ? "Enter PosY" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: posYValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: posYFocusNode.hasFocus
                                            ? posYValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getAccentColor(), width: 2.0),
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
                                  cursorColor: Utils.getAccentColor(),
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
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "PosX",
                                    errorText: posXValid ? "Enter PosX" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: posXValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: posXFocusNode.hasFocus
                                            ? posXValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getAccentColor(), width: 2.0),
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
                                  focusNode: fontNameFocusNode,
                                  controller: fontNameController,
                                  cursorColor: Utils.getAccentColor(),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && fontNameValid) {
                                      setState(() {
                                        fontNameValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Font name with extension",
                                    errorText:
                                        fontNameValid ? "Enter Font name with extension" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: fontNameValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: fontNameFocusNode.hasFocus
                                            ? fontNameValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getAccentColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(fontNameFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: alphaFocusNode,
                                  controller: alphaController,
                                  cursorColor: Utils.getAccentColor(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                                  ],
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && alphaValid) {
                                      setState(() {
                                        alphaValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Text Alpha",
                                    errorText: alphaValid ? "Text Alpha" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: alphaValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: alphaFocusNode.hasFocus
                                            ? alphaValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getAccentColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(alphaFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: textColorFocusNode,
                                  controller: textColorController,
                                  cursorColor: Utils.getAccentColor(),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && textColorValid) {
                                      setState(() {
                                        textColorValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Text Color",
                                    errorText: textColorValid ? "Enter Text Color" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: textColorValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: textColorFocusNode.hasFocus
                                            ? textColorValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getAccentColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(textColorFocusNode);
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
                                  cursorColor: Utils.getAccentColor(),
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
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Text Rotation",
                                    errorText: rotationValid ? "Enter Text Rotation" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: rotationValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: rotationFocusNode.hasFocus
                                            ? rotationValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    errorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getErrorColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Utils.getAccentColor(), width: 2.0),
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
                          Row(
                            children: [
                              Checkbox(
                                checkColor: Utils.getWhiteColor(),
                                activeColor: Utils.getAccentColor(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                                value: isBoldText,
                                onChanged: (value) {
                                  setState(() {
                                    isBoldText = value!;
                                  });
                                },
                              ),
                              Text(
                                "isBold",
                                style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isBoldText ? Utils.getAccentColor() : Utils.getTextColor()),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Checkbox(
                                checkColor: Utils.getWhiteColor(),
                                activeColor: Utils.getAccentColor(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0)),
                                value: isItalicText,
                                onChanged: (value) {
                                  setState(() {
                                    isItalicText = value!;
                                  });
                                },
                              ),
                              Text(
                                "isItalic",
                                style: TextStyle(
                                    fontFamily: 'Sans',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color: isItalicText
                                        ? Utils.getAccentColor()
                                        : Utils.getTextColor()),
                              ),
                            ],
                          ),
                          SizedBox(height: heightSize * 0.04),
                          MaterialButton(
                            color: Utils.getAccentColor(),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                            padding: const EdgeInsets.fromLTRB(100, 18, 100, 18),
                            onPressed: () async {
                              var text = TextSticker(
                                  textString: textController.text,
                                  width: double.parse(widthController.text),
                                  height: double.parse(heightController.text),
                                  posY: double.parse(posYController.text),
                                  posX: double.parse(posXController.text),
                                  fontName: fontNameController.text,
                                  textAlpha: int.parse(alphaController.text),
                                  textColor: textColorController.text,
                                  type: "TEXT",
                                  rotation: int.parse(rotationController.text),
                                  shadowColor: 0,
                                  shadowProg: 1,
                                  bgColor: 0,
                                  bgDrawable: "0",
                                  bgAlpha: 0,
                                  isBold: (isBoldText ? 1 : 0),
                                  isItalic: (isItalicText ? 1 : 0));
                              textSticker!(text);
                              Navigator.pop(context, true);
                            },
                            child: Text(
                              'Add Text',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Sans',
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: Utils.getTextColor()),
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
