class Stickers {
  List<StickerPacks>? stickerPacks;

  Stickers({this.stickerPacks});

  Stickers.fromJson(Map<String, dynamic> json) {
    if (json['stickerPacks'] != null) {
      stickerPacks = <StickerPacks>[];
      json['stickerPacks'].forEach((v) {
        stickerPacks!.add(StickerPacks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (stickerPacks != null) {
      data['stickerPacks'] = stickerPacks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StickerPacks {
  String? stickerPackName;
  int? stickerPackId;
  int? isPremium = 0;
  String? zipUrl;
  String? thumbUrl;

  StickerPacks(
      {this.stickerPackName, this.stickerPackId, this.isPremium, this.zipUrl, this.thumbUrl});

  StickerPacks.fromJson(Map<String, dynamic> json) {
    stickerPackName = json['stickerPackName'];
    stickerPackId = json['stickerPackId'];
    isPremium = json['isPremium'];
    zipUrl = json['zipUrl'];
    thumbUrl = json['thumbUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stickerPackName'] = stickerPackName;
    data['stickerPackId'] = stickerPackId;
    data['isPremium'] = isPremium;
    data['zipUrl'] = zipUrl;
    data['thumbUrl'] = thumbUrl;
    return data;
  }
}
