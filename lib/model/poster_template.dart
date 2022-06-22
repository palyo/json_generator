class PosterCategory {
  List<Categories>? categories;

  PosterCategory({this.categories});

  PosterCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
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

class Categories {
  String? categoryName;
  int? categoryId;
  List<Templates>? templates;

  Categories({this.categoryName, this.categoryId, this.templates});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryId = json['categoryId'];
    if (json['templates'] != null) {
      templates = <Templates>[];
      json['templates'].forEach((v) {
        templates!.add(Templates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryId'] = categoryId;
    if (templates != null) {
      data['templates'] = templates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Templates {
  String? demoUrl;
  String? zipUrl;
  int? isPremium = 0;
  int? isTrending = 0;

  Templates({this.demoUrl, this.zipUrl, this.isPremium, this.isTrending});

  Templates.fromJson(Map<String, dynamic> json) {
    demoUrl = json['demoUrl'];
    zipUrl = json['zipUrl'];
    isPremium = json['isPremium'];
    isTrending = json['isTrending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['demoUrl'] = demoUrl;
    data['zipUrl'] = zipUrl;
    data['isPremium'] = isPremium;
    data['isTrending'] = isTrending;
    return data;
  }
}