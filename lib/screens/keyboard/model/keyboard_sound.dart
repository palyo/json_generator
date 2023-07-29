class KeyboardSound {
  int? id;
  String? name;
  String? mp3file = "";
  String? previewImg = "";
  int? isPremium;

  KeyboardSound({this.id, this.name, this.isPremium,this.mp3file, this.previewImg});

  KeyboardSound.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mp3file = json['mp3file'];
    previewImg = json['preview_img'];
    isPremium = json['is_premium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mp3file'] = mp3file;
    data['preview_img'] = previewImg;
    data['is_premium'] = isPremium;
    return data;
  }
}
