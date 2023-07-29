

class TuneWallpaperCategory {
  List<TuneWallpaper>? categories;

  TuneWallpaperCategory({this.categories});

  TuneWallpaperCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <TuneWallpaper>[];
      json['categories'].forEach((v) {
        categories!.add(TuneWallpaper.fromJson(v));
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

class TuneWallpaper {
  String? categoryName;
  String? categoryThumb = "";
  String? categoryJson = "";
  int? categoryId;
  int? wallpaperCount;

  TuneWallpaper({this.categoryName, this.categoryId});

  TuneWallpaper.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryThumb = json['categoryThumb'];
    categoryJson = json['categoryJson'];
    categoryId = json['categoryId'];
    wallpaperCount = json['wallpaperCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryThumb'] = categoryThumb;
    data['categoryJson'] = categoryJson;
    data['categoryId'] = categoryId;
    data['wallpaperCount'] = wallpaperCount;
    return data;
  }
}

class Wallpapers {
  List<Wallpaper>? wallpapers;

  Wallpapers({this.wallpapers});

  Wallpapers.fromJson(Map<String, dynamic> json) {
    if (json['wallpapers'] != null) {
      wallpapers = <Wallpaper>[];
      json['wallpapers'].forEach((v) {
        wallpapers?.add(Wallpaper.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wallpapers != null) {
      data['wallpapers'] = wallpapers?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallpaper {
  String? categoryName;
  String? wallpaperTitle;
  String? wallpaperUrl;
  String? userName;
  int? wallpaperId = 0;
  int? isPremium = 0;

  Wallpaper({this.wallpaperTitle, this.wallpaperUrl, this.wallpaperId});

  Wallpaper.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    wallpaperTitle = json['wallpaperTitle'];
    wallpaperUrl = json['wallpaperUrl'];
    userName = json['userName'];
    wallpaperId = json['wallpaperId'];
    isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['wallpaperTitle'] = wallpaperTitle;
    data['wallpaperUrl'] = wallpaperUrl;
    data['userName'] = userName;
    data['wallpaperId'] = wallpaperId;
    data['isPremium'] = isPremium;
    return data;
  }
}
