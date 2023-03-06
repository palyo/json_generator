import 'package:aani_generator/screens/invitation/add_text_sticker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../util/utils.dart';
import 'add_image_sticker.dart';
import 'models/invitation_card.dart';

class DialogInvitationPage extends StatefulWidget {
  Function(CardPage, int) pageListener;
  CardPage? cardPage;
  int? pagePos = -1;

  DialogInvitationPage({
    Key? key,
    required this.cardPage,
    required this.pagePos,
    required this.pageListener,
  }) : super(key: key);

  @override
  State<DialogInvitationPage> createState() => _DialogInvitationPageState();
}

class _DialogInvitationPageState extends State<DialogInvitationPage> {
  final _formKey = GlobalKey<FormState>();
  Function(CardPage, int)? pageListener;
  CardPage? cardPage;
  int? pagePos = -1;
  String? status;

  final _bgImageController = TextEditingController(text: "bg.png");
  final _bgColorController = TextEditingController();
  final _posterWidthController = TextEditingController();
  final _posterHeightController = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  final FocusNode _bgImageFocusNode = FocusNode();
  final FocusNode _bgColorFocusNode = FocusNode();
  final FocusNode _posterWidthFocusNode = FocusNode();
  final FocusNode _posterHeightFocusNode = FocusNode();

  bool _isBgImageValid = false;
  bool _isBgColorValid = false;
  bool _isPosterWidthValid = false;
  bool _isPosterHeightValid = false;

  List<TextSticker> textStickers = [];
  List<ImageSticker> imageStickers = [];

  int isTextPosition = -1;

  @override
  void initState() {
    super.initState();
    pageListener = widget.pageListener;
    cardPage = widget.cardPage;
    pagePos = widget.pagePos;

    if (cardPage == null) {
      status = "Add";
    } else {
      status = "Update";
      _bgImageController.text = cardPage?.bgImage ?? "";
      _bgColorController.text = cardPage?.bgColor ?? "";
      _posterWidthController.text = cardPage?.posterWidth.toString() ?? "";
      _posterHeightController.text = cardPage?.posterHeight.toString() ?? "";
      textStickers = cardPage?.textSticker ?? [];
      imageStickers = cardPage?.imageSticker ?? [];
      setState(() {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;

    final scText = ScrollController(initialScrollOffset: 0);
    final scImage = ScrollController(initialScrollOffset: 0);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.only(left: 300.0),
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: heightSize * 0.90,
            width: widthSize * 0.90,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
              color: Utils.getCardColor(),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: widthSize * 0.05, right: widthSize * 0.05, top: heightSize * 0, bottom: heightSize * 0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$status Page',
                              style: TextStyle(fontSize: 24.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w700, color: Colors.pinkAccent),
                            ),
                          ),
                          SizedBox(height: heightSize * 0.01),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 36.0,
                                height: 4.0,
                                decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: const BorderRadius.all(Radius.circular(2.0))),
                              )),
                          SizedBox(height: heightSize * 0.04),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  focusNode: _bgImageFocusNode,
                                  controller: _bgImageController,
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _isBgImageValid) {
                                      setState(() {
                                        _isBgImageValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Background Image",
                                    errorText: _isBgImageValid ? "Enter Background Image" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: _isBgImageValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _bgImageFocusNode.hasFocus
                                            ? _isBgImageValid
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
                                  cursorColor: Colors.pinkAccent,
                                  keyboardType: TextInputType.text,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _isBgColorValid) {
                                      setState(() {
                                        _isBgColorValid = false;
                                      });
                                    }
                                  },
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Background Color",
                                    labelStyle: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: _bgColorFocusNode.hasFocus ? Colors.pinkAccent : Utils.getHintColor()),
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
                                      FocusScope.of(context).requestFocus(_bgColorFocusNode);
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
                                  cursorColor: Colors.pinkAccent,
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
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Poster Width",
                                    errorText: _isPosterWidthValid ? "Enter valid Poster Width" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: _isPosterWidthValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _posterWidthFocusNode.hasFocus
                                            ? _isPosterWidthValid
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
                                  cursorColor: Colors.pinkAccent,
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
                                  style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                  decoration: InputDecoration(
                                    labelText: "Poster Height",
                                    errorText: _isPosterHeightValid ? "Enter valid Poster Height!" : null,
                                    errorStyle: TextStyle(fontSize: 12.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: _isPosterHeightValid ? Utils.getErrorColor() : Utils.getHintColor()),
                                    labelStyle: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: 'Sans',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w300,
                                        color: _posterHeightFocusNode.hasFocus
                                            ? _isPosterHeightValid
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
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12.0, right: 4.0, top: 4.0, bottom: 4.0),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Text Stickers',
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
                                                            return DialogTextSticker(
                                                              sticker: null,
                                                              stickerPos: -1,
                                                              textSticker: (value, pos) {
                                                                setState(() {
                                                                  textStickers.add(value);
                                                                });
                                                              },
                                                            );
                                                          });
                                                    },
                                                    icon: const Icon(Icons.add, size: 20.0),
                                                    label: Text(
                                                      "Add",
                                                      style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
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
                                    constraints: const BoxConstraints(maxHeight: 100),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Scrollbar(
                                        thickness: 8,
                                        thumbVisibility: true,
                                        interactive: true,
                                        controller: scText,
                                        child: ReorderableListView(
                                          scrollController: scText,
                                          padding: const EdgeInsets.only(right: 16.0),
                                          onReorder: (oldIndex, newIndex) {
                                            if (newIndex > oldIndex) newIndex--;
                                            final item = textStickers.removeAt(oldIndex);
                                            textStickers.insert(newIndex, item);
                                            setState(() {});
                                          },
                                          children: [
                                            for (int index = 0; index < textStickers.length; index++)
                                              Container(
                                                key: ValueKey(textStickers[index]),
                                                decoration: BoxDecoration(
                                                  color: Utils.getBGColor().withOpacity(0.5),
                                                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      alignment: Alignment.center,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment.center,
                                                          child: InkWell(
                                                            onTap: () {
                                                              if (isTextPosition == index) {
                                                                isTextPosition = -1;
                                                              } else {
                                                                isTextPosition = index;
                                                              }
                                                              setState(() {});
                                                            },
                                                            child: Container(
                                                                height: 42.0,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(
                                                                    horizontal: 24.0,
                                                                    vertical: 10.0,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      textStickers[index].textString!,
                                                                      style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                                                    ),
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
                                                                            return DialogTextSticker(
                                                                              sticker: textStickers[index],
                                                                              stickerPos: index,
                                                                              textSticker: (TextSticker val, int pos) {
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
                                                                        textStickers.removeAt(index);
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
                                                    Container(
                                                      height: 1.0,
                                                      color: Colors.white10,
                                                    )
                                                  ],
                                                ),
                                              )
                                          ],
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
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12.0, right: 4.0, top: 4.0, bottom: 4.0),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Image Stickers',
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
                                                      style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
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
                                    constraints: const BoxConstraints(maxHeight: 100),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Scrollbar(
                                          thickness: 8,
                                          thumbVisibility: true,
                                          interactive: true,
                                          controller: scImage,
                                          child: ReorderableListView(
                                            scrollController: scImage,
                                            padding: const EdgeInsets.only(right: 16.0),
                                            onReorder: (oldIndex, newIndex) {
                                              if (newIndex > oldIndex) newIndex--;
                                              final item = imageStickers.removeAt(oldIndex);
                                              imageStickers.insert(newIndex, item);
                                              setState(() {});
                                            },
                                            children: [
                                              for (int index = 0; index < imageStickers.length; index++)
                                                Container(
                                                  key: ValueKey(imageStickers[index]),
                                                  decoration: BoxDecoration(
                                                    color: Utils.getBGColor().withOpacity(0.5),
                                                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Stack(
                                                        alignment: Alignment.center,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment.center,
                                                            child: Container(
                                                                height: 42.0,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(
                                                                    horizontal: 24.0,
                                                                    vertical: 10.0,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      imageStickers[index].stickerPath!,
                                                                      style: TextStyle(fontSize: 16.0, fontFamily: 'Sans', fontStyle: FontStyle.normal, fontWeight: FontWeight.w300, color: Utils.getTextColor()),
                                                                    ),
                                                                  ),
                                                                )),
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
                                                                            useSafeArea: true,
                                                                            builder: (BuildContext context) {
                                                                              return DialogImageSticker(
                                                                                sticker: imageStickers[index],
                                                                                stickerPos: index,
                                                                                imageSticker: (ImageSticker val, int pos) {
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
                                                                          imageStickers.removeAt(index);
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
                                                      Container(
                                                        height: 1.0,
                                                        color: Colors.white10,
                                                      )
                                                    ],
                                                  ),
                                                )
                                            ],
                                          )),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: heightSize * 0.04),
                          MaterialButton(
                            color: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                            padding: const EdgeInsets.fromLTRB(100, 18, 100, 18),
                            onPressed: () async {
                              var template = CardPage(
                                bgImage: _bgImageController.text,
                                bgColor: _bgColorController.text,
                                posterWidth: double.parse(_posterWidthController.text),
                                posterHeight: double.parse(_posterHeightController.text),
                                textSticker: textStickers,
                                imageSticker: imageStickers,
                              );
                              pageListener!(template, pagePos ?? -1);
                              Navigator.pop(context, true);
                            },
                            child: Text(
                              '$status Page',
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
