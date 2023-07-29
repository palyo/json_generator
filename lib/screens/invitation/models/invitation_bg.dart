class InvitationBGCategories {
  List<InvitationBGCategory>? categories;

  InvitationBGCategories({this.categories});

  InvitationBGCategories.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <InvitationBGCategory>[];
      json['categories'].forEach((v) {
        categories!.add(InvitationBGCategory.fromJson(v));
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

class InvitationBGCategory {
  int? bgCategoryId;
  String? bgCategoryName;
  List<InvitationBG>? backgrounds;

  InvitationBGCategory({this.bgCategoryId, this.bgCategoryName, this.backgrounds});

  InvitationBGCategory.fromJson(Map<String, dynamic> json) {
    bgCategoryId = json['bg_category_id'];
    bgCategoryName = json['bg_category_name'];
    if (json['backgrounds'] != null) {
      backgrounds = <InvitationBG>[];
      json['backgrounds'].forEach((v) {
        backgrounds!.add(InvitationBG.fromJson(v));
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

class InvitationBG {
  int? backgroundId;
  String? backgroundImage;
  String? backgroundThumbImage;
  int? isPremium;

  InvitationBG({this.backgroundId, this.backgroundImage, this.backgroundThumbImage, this.isPremium});

  InvitationBG.fromJson(Map<String, dynamic> json) {
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
