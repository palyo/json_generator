class KeyboardFont {
  int? id;
  String? name;
  int? isPremium;
  String? fontFile = "";
  String? previewImg = "";
  String? largePreviewImg = "";

  KeyboardFont({this.id, this.name, this.isPremium,this.fontFile, this.previewImg, this.largePreviewImg});

  KeyboardFont.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isPremium = json['is_premium'];
    fontFile = json['font_file'];
    previewImg = json['preview_img'];
    largePreviewImg = json['large_preview_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['is_premium'] = isPremium;
    data['font_file'] = fontFile;
    data['preview_img'] = previewImg;
    data['large_preview_img'] = largePreviewImg;
    return data;
  }
}
