

class ZedgeRingtoneCategory {
  List<ZedgeRingtone>? categories;

  ZedgeRingtoneCategory({this.categories});

  ZedgeRingtoneCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <ZedgeRingtone>[];
      json['categories'].forEach((v) {
        categories!.add(ZedgeRingtone.fromJson(v));
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

class ZedgeRingtone {
  String? categoryName;
  int? categoryId;
  List<Ringtone>? ringtones;

  ZedgeRingtone({this.categoryName, this.categoryId, this.ringtones});

  ZedgeRingtone.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
    if (json['templates'] != null) {
      ringtones = <Ringtone>[];
      json['ringtones'].forEach((v) {
        ringtones!.add(Ringtone.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryId'] = categoryId;
    if (ringtones != null) {
      data['ringtones'] = ringtones!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ringtone {
  String? ringtoneTitle;
  String? ringtoneUrl;
  int? ringtoneId = 0;

  Ringtone({this.ringtoneTitle, this.ringtoneUrl, this.ringtoneId});

  Ringtone.fromJson(Map<String, dynamic> json) {
    ringtoneTitle = json['ringtoneTitle'];
    ringtoneUrl = json['ringtoneUrl'];
    ringtoneId = json['ringtoneId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ringtoneTitle'] = ringtoneTitle;
    data['ringtoneUrl'] = ringtoneUrl;
    data['ringtoneId'] = ringtoneId;
    return data;
  }
}
