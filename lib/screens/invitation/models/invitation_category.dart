class InvitationCategory {
  List<InvitationSubCategory>? categories;

  InvitationCategory({this.categories});

  InvitationCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <InvitationSubCategory>[];
      json['categories'].forEach((v) {
        categories!.add(InvitationSubCategory.fromJson(v));
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

class InvitationSubCategory {
  String? categoryName;
  List<Categories>? categories;

  InvitationSubCategory({this.categories});

  InvitationSubCategory.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    if (json['subCategories'] != null) {
      categories = <Categories>[];
      json['subCategories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    if (categories != null) {
      data['subCategories'] = categories?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? subCategoryName;
  String? subCategoryDesc;
  String? subCategoryColor;
  String? subCategoryThumb;
  String? templateJsonUrl;
  int? subCategoryId;

  // List<Templates>? templates;

  Categories({this.subCategoryName, this.subCategoryDesc, this.subCategoryThumb, this.subCategoryId /*, this.templates*/
      });

  Categories.fromJson(Map<String, dynamic> json) {
    subCategoryName = json['subCategoryName'];
    subCategoryDesc = json['subCategoryDesc'];
    subCategoryColor = json['subCategoryColor'];
    subCategoryThumb = json['subCategoryThumb'];
    templateJsonUrl = json['templateJsonUrl'];
    subCategoryId = json['subCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subCategoryName'] = subCategoryName;
    data['subCategoryDesc'] = subCategoryDesc;
    data['subCategoryColor'] = subCategoryColor;
    data['subCategoryThumb'] = subCategoryThumb;
    data['templateJsonUrl'] = templateJsonUrl;
    data['subCategoryId'] = subCategoryId;
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
