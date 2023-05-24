class BackgroundCategory {
  List<BGCategories>? categories;

  BackgroundCategory({this.categories});

  BackgroundCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <BGCategories>[];
      json['categories'].forEach((v) {
        categories!.add(BGCategories.fromJson(v));
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

class BGCategories {
  int? bgCategoryId;
  String? bgCategoryName;
  List<Backgrounds>? backgrounds;

  BGCategories({this.bgCategoryId, this.bgCategoryName, this.backgrounds});

  BGCategories.fromJson(Map<String, dynamic> json) {
    bgCategoryId = json['bg_category_id'];
    bgCategoryName = json['bg_category_name'];
    if (json['backgrounds'] != null) {
      backgrounds = <Backgrounds>[];
      json['backgrounds'].forEach((v) {
        backgrounds!.add(Backgrounds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bg_category_id'] = bgCategoryId;
    data['bg_category_name'] = bgCategoryName;
    if (backgrounds != null) {
      data['backgrounds'] = backgrounds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Backgrounds {
  int? backgroundId;
  String? backgroundImage;
  String? backgroundThumbImage;
  int? isPremium;

  Backgrounds({this.backgroundId, this.backgroundImage, this.backgroundThumbImage, this.isPremium});

  Backgrounds.fromJson(Map<String, dynamic> json) {
    backgroundId = json['background_id'];
    backgroundImage = json['background_image'];
    backgroundThumbImage = json['background_thumb_image'];
    isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['background_id'] = backgroundId;
    data['background_image'] = backgroundImage;
    data['background_thumb_image'] = backgroundThumbImage;
    data['isPremium'] = isPremium;
    return data;
  }
}
