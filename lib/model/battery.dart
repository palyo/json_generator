class BatteryAnimationCategory {
  List<BatteryCategories>? categories;

  BatteryAnimationCategory({this.categories});

  BatteryAnimationCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <BatteryCategories>[];
      json['categories'].forEach((v) {
        categories!.add(BatteryCategories.fromJson(v));
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

class BatteryCategories {
  String? categoryName;
  int? categoryId;
  List<Animations>? animations;

  BatteryCategories({this.categoryName, this.categoryId, this.animations});

  BatteryCategories.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
    if (json['templates'] != null) {
      animations = <Animations>[];
      json['animations'].forEach((v) {
        animations!.add(Animations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryId'] = categoryId;
    if (animations != null) {
      data['animations'] = animations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Animations {
  String? thumbUrl;
  String? zipUrl;

  Animations({this.thumbUrl, this.zipUrl});

  Animations.fromJson(Map<String, dynamic> json) {
    thumbUrl = json['thumbUrl'];
    zipUrl = json['zipUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumbUrl'] = thumbUrl;
    data['zipUrl'] = zipUrl;
    return data;
  }
}
