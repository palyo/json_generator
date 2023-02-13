

class RingerStickerCategory {
  List<RingerSticker>? categories;

  RingerStickerCategory({this.categories});

  RingerStickerCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <RingerSticker>[];
      json['categories'].forEach((v) {
        categories!.add(RingerSticker.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RingerSticker {
  String? categoryName;
  String? categoryThumb = "";
  int? categoryId;
  int? stickerCount;
  List<Sticker>? stickers;

  RingerSticker({this.categoryName, this.categoryId, this.stickers});

  RingerSticker.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryThumb = json['categoryThumb'];
    categoryId = json['categoryId'];
    stickerCount = json['stickerCount'];
    if (json['templates'] != null) {
      stickers = <Sticker>[];
      json['stickers'].forEach((v) {
        stickers!.add(Sticker.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryThumb'] = categoryThumb;
    data['categoryId'] = categoryId;
    data['stickerCount'] = stickerCount;
    if (stickers != null) {
      data['stickers'] = stickers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sticker {
  String? stickerTitle;
  String? stickerUrl;
  int? stickerId = 0;

  Sticker({this.stickerTitle, this.stickerUrl, this.stickerId});

  Sticker.fromJson(Map<String, dynamic> json) {
    stickerTitle = json['stickerTitle'];
    stickerUrl = json['stickerUrl'];
    stickerId = json['stickerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stickerTitle'] = stickerTitle;
    data['stickerUrl'] = stickerUrl;
    data['stickerId'] = stickerId;
    return data;
  }
}
