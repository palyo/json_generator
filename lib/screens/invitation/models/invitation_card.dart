class InvitationCard {
  String? posterType;
  List<CardPage>? pages = [];

  InvitationCard({this.posterType, this.pages});

  InvitationCard.fromJson(Map<String, dynamic> json) {
    posterType = json['posterType'];
    if (json['pages'] != null) {
      pages = <CardPage>[];
      json['pages'].forEach((v) {
        pages!.add(CardPage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['posterType'] = posterType;
    if (pages != null) {
      data['pages'] = pages!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return '$pages';
  }
}

class CardPage {
  String? bgImage;
  String? bgColor;
  double? posterWidth;
  double? posterHeight;
  List<TextSticker>? textSticker = [];
  List<ImageSticker>? imageSticker = [];

  CardPage({this.bgImage, this.bgColor, this.posterWidth, this.posterHeight, this.textSticker, this.imageSticker});

  CardPage.fromJson(Map<String, dynamic> json) {
    bgImage = json['bgImage'];
    bgColor = json['bgColor'];
    posterWidth = json['posterWidth'];
    posterHeight = json['posterHeight'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bgImage'] = bgImage;
    data['bgColor'] = bgColor;
    data['posterWidth'] = posterWidth;
    data['posterHeight'] = posterHeight;
    if (textSticker != null) {
      data['text_sticker'] = textSticker!.map((v) => v.toJson()).toList();
    }
    if (imageSticker != null) {
      data['image_sticker'] = imageSticker!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    if (bgImage?.isEmpty ?? true) {
      return 'bgColor: $bgColor, posterWidth: $posterWidth, posterHeight: $posterHeight, \nText Stickers:- ${textSticker?.length}, \Image Stickers:- ${imageSticker?.length}';
    } else if (bgColor?.isEmpty ?? true) {
      return 'bgImage: $bgImage, posterWidth: $posterWidth, posterHeight: $posterHeight, \nText Stickers:- ${textSticker?.length}, \Image Stickers:- ${imageSticker?.length}';
    } else {
      return 'bgImage: $bgImage, bgColor: $bgColor, posterWidth: $posterWidth, posterHeight: $posterHeight, \nText Stickers:- ${textSticker?.length}, \Image Stickers:- ${imageSticker?.length}';
    }
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
  String? textGravity;
  int? isBold;
  int? isItalic;

  TextSticker({this.textString, this.width, this.height, this.posY, this.posX, this.fontName, this.textAlpha, this.textColor, this.textGravity, this.type, this.rotation, this.shadowColor, this.shadowProg, this.bgColor, this.bgDrawable, this.bgAlpha, this.isBold, this.isItalic});

  TextSticker.fromJson(Map<String, dynamic> json) {
    textString = json['textString'];
    width = json['width'];
    height = json['height'];
    posY = json['posY'];
    posX = json['posX'];
    fontName = json['fontName'];
    textAlpha = json['textAlpha'];
    textColor = json['textColor'];
    textGravity = json['gravity'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['textString'] = textString;
    data['width'] = width;
    data['height'] = height;
    data['posY'] = posY;
    data['posX'] = posX;
    data['fontName'] = fontName;
    data['textAlpha'] = textAlpha;
    data['textColor'] = textColor;
    data['gravity'] = textGravity;
    data['type'] = type;
    data['rotation'] = rotation;
    data['shadowColor'] = shadowColor;
    data['shadowProg'] = shadowProg;
    data['bgColor'] = bgColor;
    data['bgDrawable'] = bgDrawable;
    data['bgAlpha'] = bgAlpha;
    data['isBold'] = isBold;
    data['isItalic'] = isItalic;
    return data;
  }

  @override
  String toString() {
    return 'width: $width, height: $height, posY: $posY, posX: $posX, fontName: $fontName, textColor: $textColor ';
  }
}

class ImageSticker {
  String? stickerPath;
  String? maskPath;
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

  ImageSticker({this.stickerPath, this.maskPath, this.width, this.height, this.posY, this.posX, this.stcOpacity, this.rotation, this.colorType, this.type, this.stcColor, this.stcHue});

  @override
  String toString() {
    return 'stickerPath: $stickerPath, maskPath: $maskPath, width: $width, height: $height, posY: $posY, posX: $posX, rotation: $rotation';
  }

  ImageSticker.fromJson(Map<String, dynamic> json) {
    stickerPath = json['stickerPath'];
    maskPath = json['maskPath'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stickerPath'] = stickerPath;
    data['maskPath'] = maskPath;
    data['width'] = width;
    data['height'] = height;
    data['posY'] = posY;
    data['posX'] = posX;
    data['stcOpacity'] = stcOpacity;
    data['rotation'] = rotation;
    data['colorType'] = colorType;
    data['type'] = type;
    data['stcColor'] = stcColor;
    data['stcHue'] = stcHue;
    return data;
  }
}
