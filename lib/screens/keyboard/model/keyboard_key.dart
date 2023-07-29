class KeyboardKey {
  int? id;
  String? name;
  String? keyData = "";
  String? previewImg = "";
  int? isPremium;

  KeyboardKey({this.id, this.name, this.isPremium,this.keyData, this.previewImg});

  KeyboardKey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    keyData = json['key_data'];
    previewImg = json['preview_img'];
    isPremium = json['is_premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['key_data'] = keyData;
    data['preview_img'] = previewImg;
    data['is_premium'] = isPremium;
    return data;
  }
}
