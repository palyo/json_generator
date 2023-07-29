

class TuneStickerCategory {
  List<TuneSticker>? categories;

  TuneStickerCategory({this.categories});

  TuneStickerCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <TuneSticker>[];
      json['categories'].forEach((v) {
        categories!.add(TuneSticker.fromJson(v));
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

class TuneSticker {
  String? categoryName;
  String? categoryThumb = "";
  String? categoryBanner = "";
  String? sourceData = "";
  int? categoryId;
  String? categoryColor = "";
  int? stickerCount;
  List<Sticker>? previews;

  TuneSticker({this.categoryName, this.categoryId, this.previews});

  TuneSticker.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryThumb = json['categoryThumb'];
    categoryBanner = json['categoryBanner'];
    sourceData = json['sourceData'];
    categoryId = json['categoryId'];
    categoryColor = json['categoryColor'];
    stickerCount = json['stickerCount'];
    if (json['templates'] != null) {
      previews = <Sticker>[];
      json['previews'].forEach((v) {
        previews!.add(Sticker.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryThumb'] = categoryThumb;
    data['categoryBanner'] = categoryBanner;
    data['sourceData'] = sourceData;
    data['categoryId'] = categoryId;
    data['categoryColor'] = categoryColor;
    data['stickerCount'] = stickerCount;
    if (previews != null) {
      data['previews'] = previews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sticker {
  String? stickerUrl;

  Sticker({this.stickerUrl});

  Sticker.fromJson(Map<String, dynamic> json) {
    stickerUrl = json['stickerUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stickerUrl'] = stickerUrl;
    return data;
  }
}
