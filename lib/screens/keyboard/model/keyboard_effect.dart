class KeyboardEffect {
  int? id;
  String? name;
  String? file = "";
  String? previewImg = "";
  int? isPremium;

  KeyboardEffect({this.id, this.name, this.isPremium,this.file, this.previewImg});

  KeyboardEffect.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    file = json['file'];
    previewImg = json['preview_img'];
    isPremium = json['is_premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['file'] = file;
    data['preview_img'] = previewImg;
    data['is_premium'] = isPremium;
    return data;
  }
}
