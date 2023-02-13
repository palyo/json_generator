class InvitationCategory {
  List<Categories>? categories;

  InvitationCategory({this.categories});

  InvitationCategory.fromJson(Map<String, dynamic> json) {
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
      data['categories'] = categories?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? categoryName;
  String? categoryDesc;
  String? categoryThumb;
  int? categoryId;

  // List<Templates>? templates;

  Categories({this.categoryName, this.categoryDesc, this.categoryThumb, this.categoryId /*, this.templates*/
      });

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryDesc = json['categoryDesc'];
    categoryThumb = json['categoryThumb'];
    categoryId = json['categoryId'];
    // if (json['templates'] != null) {
    //   templates = <Templates>[];
    //   json['templates'].forEach((v) {
    //     templates!.add(new Templates.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryDesc'] = categoryDesc;
    data['categoryThumb'] = categoryThumb;
    data['categoryId'] = categoryId;
    // if (this.templates != null) {
    //   data['templates'] = this.templates!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Templates {
  String? templateThumb;
  String? templateZip;
  int? templateId;

  Templates({this.templateThumb, this.templateZip, this.templateId});

  Templates.fromJson(Map<String, dynamic> json) {
    templateThumb = json['templateThumb'];
    templateZip = json['templateZip'];
    templateId = json['templateId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['templateThumb'] = templateThumb;
    data['templateZip'] = templateZip;
    data['templateId'] = templateId;
    return data;
  }
}
