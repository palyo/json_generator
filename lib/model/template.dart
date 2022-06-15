class Template {
  String? bgImage;
  String? bgColor;
  double? posterWidth;
  double? posterHeight;
  String? posterType;
  List<TextSticker>? textSticker = [];
  List<ImageSticker>? imageSticker = [];

  Template(
      {this.bgImage,
      this.bgColor,
      this.posterWidth,
      this.posterHeight,
      this.posterType,
      this.textSticker,
      this.imageSticker});

  Template.fromJson(Map<String, dynamic> json) {
    bgImage = json['bgImage'];
    bgColor = json['bgColor'];
    posterWidth = json['posterWidth'];
    posterHeight = json['posterHeight'];
    posterType = json['posterType'];
    if (json['text_sticker'] != null) {
      textSticker = <TextSticker>[];
      json['text_sticker'].forEach((v) {
        textSticker!.add(TextSticker.fromJson(v));
      });
    }
    if (json['image_sticker'] != null) {
      imageSticker = <ImageSticker>[];
      json['image_sticker'].forEach((v) {
        imageSticker!.add(ImageSticker.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bgImage'] = this.bgImage;
    data['bgColor'] = this.bgColor;
    data['posterWidth'] = this.posterWidth;
    data['posterHeight'] = this.posterHeight;
    data['posterType'] = this.posterType;
    if (this.textSticker != null) {
      data['text_sticker'] = this.textSticker!.map((v) => v.toJson()).toList();
    }
    if (this.imageSticker != null) {
      data['image_sticker'] = this.imageSticker!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TextSticker {
  String? textString;
  double? width;
  double? height;
  double? posY;
  double? posX;
  String? fontName;
  int? textAlpha;
  String? textColor;
  String? type;
  int? rotation;
  int? shadowColor;
  int? shadowProg;
  int? bgColor;
  String? bgDrawable;
  int? bgAlpha;
  int? isBold;
  int? isItalic;

  TextSticker(
      {this.textString,
      this.width,
      this.height,
      this.posY,
      this.posX,
      this.fontName,
      this.textAlpha,
      this.textColor,
      this.type,
      this.rotation,
      this.shadowColor,
      this.shadowProg,
      this.bgColor,
      this.bgDrawable,
      this.bgAlpha,
      this.isBold,
      this.isItalic});

  TextSticker.fromJson(Map<String, dynamic> json) {
    textString = json['textString'];
    width = json['width'];
    height = json['height'];
    posY = json['posY'];
    posX = json['posX'];
    fontName = json['fontName'];
    textAlpha = json['textAlpha'];
    textColor = json['textColor'];
    type = json['type'];
    rotation = json['rotation'];
    shadowColor = json['shadowColor'];
    shadowProg = json['shadowProg'];
    bgColor = json['bgColor'];
    bgDrawable = json['bgDrawable'];
    bgAlpha = json['bgAlpha'];
    isBold = json['isBold'];
    isItalic = json['isItalic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['textString'] = this.textString;
    data['width'] = this.width;
    data['height'] = this.height;
    data['posY'] = this.posY;
    data['posX'] = this.posX;
    data['fontName'] = this.fontName;
    data['textAlpha'] = this.textAlpha;
    data['textColor'] = this.textColor;
    data['type'] = this.type;
    data['rotation'] = this.rotation;
    data['shadowColor'] = this.shadowColor;
    data['shadowProg'] = this.shadowProg;
    data['bgColor'] = this.bgColor;
    data['bgDrawable'] = this.bgDrawable;
    data['bgAlpha'] = this.bgAlpha;
    data['isBold'] = this.isBold;
    data['isItalic'] = this.isItalic;
    return data;
  }

  @override
  String toString() {
    return 'TextSticker{textString: $textString, width: $width, height: $height, posY: $posY, posX: $posX, fontName: $fontName, textAlpha: $textAlpha, textColor: $textColor, type: $type, rotation: $rotation, shadowColor: $shadowColor, shadowProg: $shadowProg, bgColor: $bgColor, bgDrawable: $bgDrawable, bgAlpha: $bgAlpha, isBold: $isBold, isItalic: $isItalic}';
  }
}

class ImageSticker {
  String? stickerPath;
  double? width;
  double? height;
  double? posY;
  double? posX;
  int? stcOpacity;
  int? rotation;
  String? colorType;
  String? type;
  int? stcColor;
  int? stcHue;

  ImageSticker(
      {this.stickerPath,
      this.width,
      this.height,
      this.posY,
      this.posX,
      this.stcOpacity,
      this.rotation,
      this.colorType,
      this.type,
      this.stcColor,
      this.stcHue});

  ImageSticker.fromJson(Map<String, dynamic> json) {
    stickerPath = json['stickerPath'];
    width = json['width'];
    height = json['height'];
    posY = json['posY'];
    posX = json['posX'];
    stcOpacity = json['stcOpacity'];
    rotation = json['rotation'];
    colorType = json['colorType'];
    type = json['type'];
    stcColor = json['stcColor'];
    stcHue = json['stcHue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['stickerPath'] = this.stickerPath;
    data['width'] = this.width;
    data['height'] = this.height;
    data['posY'] = this.posY;
    data['posX'] = this.posX;
    data['stcOpacity'] = this.stcOpacity;
    data['rotation'] = this.rotation;
    data['colorType'] = this.colorType;
    data['type'] = this.type;
    data['stcColor'] = this.stcColor;
    data['stcHue'] = this.stcHue;
    return data;
  }
}
