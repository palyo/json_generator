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
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
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
    data['bg_category_id'] = this.bgCategoryId;
    data['bg_category_name'] = this.bgCategoryName;
    if (this.backgrounds != null) {
      data['backgrounds'] = this.backgrounds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Backgrounds {
  int? backgroundId;
  String? backgroundImage;
  int? isPremium;

  Backgrounds({this.backgroundId, this.backgroundImage, this.isPremium});

  Backgrounds.fromJson(Map<String, dynamic> json) {
    backgroundId = json['background_id'];
    backgroundImage = json['background_image'];
    isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['background_id'] = this.backgroundId;
    data['background_image'] = this.backgroundImage;
    data['isPremium'] = this.isPremium;
    return data;
  }
}
