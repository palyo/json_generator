

class TuneRingtoneCategory {
  List<TuneRingtone>? categories;

  TuneRingtoneCategory({this.categories});

  TuneRingtoneCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <TuneRingtone>[];
      json['categories'].forEach((v) {
        categories!.add(TuneRingtone.fromJson(v));
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

class TuneRingtone {
  String? categoryName;
  String? categoryThumb;
  int? categoryId;
  int? ringtoneCount;
  List<Ringtone>? ringtones;

  TuneRingtone({this.categoryName, this.categoryId, this.ringtones});

  TuneRingtone.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryThumb = json['categoryThumb'];
    categoryId = json['categoryId'];
    ringtoneCount = json['ringtoneCount'];
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
    data['categoryThumb'] = categoryThumb;
    data['categoryId'] = categoryId;
    data['ringtoneCount'] = ringtoneCount;
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
