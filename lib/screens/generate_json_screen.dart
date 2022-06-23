import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_poster_studio_json_generator/screens/add_image_sticker.dart';
import 'package:provider/provider.dart';

import '../controller/menu_controller.dart';
import '../model/template.dart';
import '../util/utils.dart';
import 'add_text_sticker.dart';

class GenerateJsonScreen extends StatefulWidget {
  const GenerateJsonScreen({
    Key? key,
  }) : super(key: key);

  @override
  GenerateJsonState createState() => GenerateJsonState();
}

class GenerateJsonState extends State<GenerateJsonScreen> {
  final _formKey = GlobalKey<FormState>();

  final _bgImageController = TextEditingController(text: "bg.png");
  final _bgColorController = TextEditingController();
  final _posterTypeController = TextEditingController(text: "template");
  final _posterWidthController = TextEditingController();
  final _posterHeightController = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  final FocusNode _bgImageFocusNode = FocusNode();
  final FocusNode _bgColorFocusNode = FocusNode();
  final FocusNode _posterTypeFocusNode = FocusNode();
  final FocusNode _posterWidthFocusNode = FocusNode();
  final FocusNode _posterHeightFocusNode = FocusNode();

  bool _isBgImageValid = false;
  bool _isBgColorValid = false;
  bool _isPosterTypeValid = false;
  bool _isPosterWidthValid = false;
  bool _isPosterHeightValid = false;

  List<TextSticker> textStickers = [];
  List<ImageSticker> imageStickers = [];

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    final scText = ScrollController(initialScrollOffset: 0);
    final scImage = ScrollController(initialScrollOffset: 0);
    return Scaffold(
        key: context.read<MenuController>().scaffoldKey,
        body: SafeArea(
            child: Container(
          decoration:
              BoxDecoration(color: Utils.getCardColor(), borderRadius: const BorderRadius.all(Radius.circular(2.0))),
          child: SizedBox(
              height: heightSize,
              width: widthSize ,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Opacity(
                          opacity: 0.02,
                          child: Image.asset("assets/images/ic_banner_bg.png", fit: BoxFit.cover)),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: widthSize * 0.05,
                          right: widthSize * 0.05,
                          top: heightSize * 0,
                          bottom: heightSize * 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(height: 100.0,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Generate Json',
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
                                  focusNode: _bgImageFocusNode,
                                  controller: _bgImageController,
                                  cursorColor: Utils.getAccentColor(),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _isBgImageValid) {
                                      setState(() {
                                        _isBgImageValid = false;
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
                                    labelText: "Background Image",
                                    errorText: _isBgImageValid ? "Enter Background Image" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color:
                                            _isBgImageValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _bgImageFocusNode.hasFocus
                                            ? _isBgImageValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
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
                                      borderSide: BorderSide(color: Utils.getAccentColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(_bgImageFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: _bgColorFocusNode,
                                  controller: _bgColorController,
                                  cursorColor: Utils.getAccentColor(),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _isBgColorValid) {
                                      setState(() {
                                        _isBgColorValid = false;
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
                                    labelText: "Background Color",
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _bgColorFocusNode.hasFocus
                                            ? Utils.getAccentColor()
                                            : Utils.getHintColor()),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Utils.getHintColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Utils.getAccentColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(_bgColorFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  focusNode: _posterTypeFocusNode,
                                  controller: _posterTypeController,
                                  cursorColor: Utils.getAccentColor(),
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _isPosterTypeValid) {
                                      setState(() {
                                        _isPosterTypeValid = false;
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
                                    labelText: "Poster Type",
                                    errorText: _isPosterTypeValid ? "Enter Poster Type!" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _isPosterTypeValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _posterTypeFocusNode.hasFocus
                                            ? _isPosterTypeValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
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
                                      borderSide: BorderSide(color: Utils.getAccentColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(_posterTypeFocusNode);
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
                                  focusNode: _posterWidthFocusNode,
                                  controller: _posterWidthController,
                                  cursorColor: Utils.getAccentColor(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                                  ],
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _isPosterWidthValid) {
                                      setState(() {
                                        _isPosterWidthValid = false;
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
                                    labelText: "Poster Width",
                                    errorText: _isPosterWidthValid ? "Enter valid Poster Width" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _isPosterWidthValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _posterWidthFocusNode.hasFocus
                                            ? _isPosterWidthValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
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
                                      borderSide: BorderSide(color: Utils.getAccentColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(_posterWidthFocusNode);
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: widthSize * 0.01),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: _posterHeightFocusNode,
                                  controller: _posterHeightController,
                                  cursorColor: Utils.getAccentColor(),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0.0-9.9]')),
                                  ],
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _isPosterHeightValid) {
                                      setState(() {
                                        _isPosterHeightValid = false;
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
                                    labelText: "Poster Height",
                                    errorText: _isPosterHeightValid ? "Enter valid Poster Height!" : null,
                                    errorStyle: TextStyle(
                                        fontSize: 12.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _isPosterHeightValid
                                            ? Utils.getErrorColor()
                                            : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _posterHeightFocusNode.hasFocus
                                            ? _isPosterHeightValid
                                                ? Utils.getErrorColor()
                                                : Utils.getAccentColor()
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
                                      borderSide: BorderSide(color: Utils.getAccentColor(), width: 2.0),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      FocusScope.of(context).requestFocus(_posterHeightFocusNode);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: heightSize * 0.02),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                color: Utils.getHintColor(),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 4.0, top: 4.0, bottom: 4.0),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Text Stickers',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'Sans',
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w500,
                                                  color: Utils.getTextColor()),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.centerRight,
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
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return DialogTextSticker(
                                                          sticker: null,
                                                          stickerPos: -1,
                                                          textSticker: (TextSticker val, int pos) {
                                                            if (kDebugMode) {
                                                              print("Print: ${val.toString()}");
                                                            }
                                                            setState(() {
                                                              textStickers.add(val);
                                                            });
                                                          },
                                                        );
                                                      });
                                                },
                                                icon: const Icon(Icons.add, size: 20.0),
                                                label: Text(
                                                  "Add",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontFamily: 'Sans',
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.w300,
                                                      color: Utils.getTextColor()),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                                if (textStickers.isNotEmpty) ...[
                                  Container(
                                    height: 2.0,
                                    color: Utils.getHintColor(),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 150),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Scrollbar(
                                        thickness: 8,
                                        thumbVisibility: true,
                                        interactive: true,
                                        controller: scText,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          controller: scText,
                                          scrollDirection: Axis.vertical,
                                          itemCount: textStickers.length,
                                          itemBuilder: (context, index) => Row(
                                            children: [
                                              Expanded(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Container(
                                                          height: 42.0,
                                                          decoration: BoxDecoration(
                                                            color: Utils.getBGColor().withOpacity(0.5),
                                                            borderRadius:
                                                                const BorderRadius.all(Radius.circular(4.0)),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                              horizontal: 24.0,
                                                              vertical: 10.0,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                textStickers[index].textString!,
                                                                style: TextStyle(
                                                                    fontSize: 16.0,
                                                                    fontFamily: 'Sans',
                                                                    fontStyle: FontStyle.normal,
                                                                    fontWeight: FontWeight.w300,
                                                                    color: Utils.getTextColor()),
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                    context: context,
                                                                    builder: (BuildContext context) {
                                                                      return DialogTextSticker(
                                                                        sticker: textStickers[index],
                                                                        stickerPos: index,
                                                                        textSticker:
                                                                            (TextSticker val, int pos) {
                                                                          if (kDebugMode) {
                                                                            print("Print: ${val.toString()}");
                                                                          }
                                                                          setState(() {
                                                                            textStickers[pos] = val;
                                                                          });
                                                                        },
                                                                      );
                                                                    });
                                                              },
                                                              child: Container(
                                                                width: 32,
                                                                height: 32,
                                                                decoration: BoxDecoration(
                                                                  color: Utils.getAccentColor(),
                                                                  borderRadius: const BorderRadius.all(
                                                                      Radius.circular(4.0)),
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
                                                                  textStickers.removeAt(index);
                                                                });
                                                              },
                                                              child: Container(
                                                                width: 32,
                                                                height: 32,
                                                                decoration: const BoxDecoration(
                                                                  color: Colors.redAccent,
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(4.0)),
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          separatorBuilder: (BuildContext context, int index) {
                                            return Container(height: 4.0, color: Colors.transparent);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: heightSize * 0.02),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                color: Utils.getHintColor(),
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 4.0, top: 4.0, bottom: 4.0),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Image Stickers',
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'Sans',
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w500,
                                                  color: Utils.getTextColor()),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.centerRight,
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
                                                  showDialog(
                                                      context: context,
                                                      useSafeArea: true,
                                                      builder: (BuildContext context) {
                                                        return DialogImageSticker(
                                                          sticker: null,
                                                          stickerPos: -1,
                                                          imageSticker: (ImageSticker val, int pos) {
                                                            if (kDebugMode) {
                                                              print("Print: ${val.toString()}");
                                                            }
                                                            setState(() {
                                                              imageStickers.add(val);
                                                            });
                                                          },
                                                        );
                                                      });
                                                },
                                                icon: const Icon(Icons.add, size: 20.0),
                                                label: Text(
                                                  "Add",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontFamily: 'Sans',
                                                      fontStyle: FontStyle.normal,
                                                      fontWeight: FontWeight.w300,
                                                      color: Utils.getTextColor()),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                                if (imageStickers.isNotEmpty) ...[
                                  Container(
                                    height: 2.0,
                                    color: Utils.getHintColor(),
                                  ),
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 150),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Scrollbar(
                                        thickness: 8,
                                        thumbVisibility: true,
                                        interactive: true,
                                        controller: scImage,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          controller: scImage,
                                          scrollDirection: Axis.vertical,
                                          itemCount: imageStickers.length,
                                          itemBuilder: (context, index) => Row(
                                            children: [
                                              Expanded(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: Container(
                                                          height: 42.0,
                                                          decoration: BoxDecoration(
                                                            color: Utils.getBGColor().withOpacity(0.5),
                                                            borderRadius:
                                                                const BorderRadius.all(Radius.circular(4.0)),
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                              horizontal: 24.0,
                                                              vertical: 10.0,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                imageStickers[index].stickerPath!,
                                                                style: TextStyle(
                                                                    fontSize: 16.0,
                                                                    fontFamily: 'Sans',
                                                                    fontStyle: FontStyle.normal,
                                                                    fontWeight: FontWeight.w300,
                                                                    color: Utils.getTextColor()),
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.centerRight,
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          InkWell(
                                                              onTap: () {
                                                                showDialog(
                                                                    context: context,
                                                                    useSafeArea: true,
                                                                    builder: (BuildContext context) {
                                                                      return DialogImageSticker(
                                                                        sticker: imageStickers[index],
                                                                        stickerPos: index,
                                                                        imageSticker: (ImageSticker val, int pos) {
                                                                          if (kDebugMode) {
                                                                            print("Print: ${val.toString()}");
                                                                          }
                                                                          setState(() {
                                                                            imageStickers[pos] = val;
                                                                          });
                                                                        },
                                                                      );
                                                                    });
                                                              },
                                                              child: Container(
                                                                width: 32,
                                                                height: 32,
                                                                decoration: BoxDecoration(
                                                                  color: Utils.getAccentColor(),
                                                                  borderRadius: const BorderRadius.all(
                                                                      Radius.circular(4.0)),
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
                                                                  imageStickers.removeAt(index);
                                                                });
                                                              },
                                                              child: Container(
                                                                width: 32,
                                                                height: 32,
                                                                decoration: const BoxDecoration(
                                                                  color: Colors.redAccent,
                                                                  borderRadius: BorderRadius.all(
                                                                      Radius.circular(4.0)),
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          separatorBuilder: (BuildContext context, int index) {
                                            return Container(height: 4.0, color: Colors.transparent);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: heightSize * 0.04),
                          Align(
                              alignment: Alignment.centerRight,
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
                                  var template = Template(
                                    bgImage: _bgImageController.text,
                                    bgColor: _bgColorController.text,
                                    posterWidth: double.parse(_posterWidthController.text),
                                    posterHeight: double.parse(_posterHeightController.text),
                                    posterType: _posterTypeController.text,
                                    textSticker: textStickers,
                                    imageSticker: imageStickers,
                                  );
                                  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                                  String prettyprint = encoder.convert(template.toJson());

                                  String? outputFile = await FilePicker.platform.saveFile(
                                      dialogTitle: 'Save your json to desire location',
                                      fileName: "index.json");

                                  try {
                                    File returnedFile = File('$outputFile');
                                    await returnedFile.writeAsString(prettyprint);
                                  } catch (e) {}
                                  if (kDebugMode) {
                                    print("TEMPLATE: $prettyprint");
                                  }
                                },
                                icon: const Icon(Icons.save_outlined, size: 20.0),
                                label: Text(
                                  "Save To Json",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontFamily: 'Sans',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w300,
                                      color: Utils.getTextColor()),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        )));
  }
}
