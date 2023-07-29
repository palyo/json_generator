class KeyboardTheme {
  int? id;
  String? name;
  String? pkgName = "";
  String? themeSmallPreview = "";
  String? themeBigPreview = "";
  String? themeZip = "";
  String? isPremium;
  String? themeType = "";
  String? userHit = "";
  String? themeTag = "";
  String? isNew = "";
  String? isHot = "";

  KeyboardTheme({this.id, this.name, this.pkgName, this.themeSmallPreview, this.themeBigPreview, this.themeZip, this.isPremium, this.themeType, this.userHit, this.themeTag, this.isNew, this.isHot});

  KeyboardTheme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pkgName = json['pkg_name'];
    themeSmallPreview = json['theme_small_preview'];
    themeBigPreview = json['theme_big_preview'];
    themeZip = json['theme_zip'];
    isPremium = json['isPremium'];
    themeType = json['theme_type'];
    userHit = json['user_hit'];
    themeTag = json['theme_tag'];
    isNew = json['is_new'];
    isHot = json['is_hot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pkg_name'] = pkgName;
    data['theme_small_preview'] = themeSmallPreview;
    data['theme_big_preview'] = themeBigPreview;
    data['theme_zip'] = themeZip;
    data['isPremium'] = isPremium;
    data['theme_type'] = themeType;
    data['user_hit'] = userHit;
    data['theme_tag'] = themeTag;
    data['is_new'] = isNew;
    data['is_hot'] = isHot;
    return data;
  }
}
