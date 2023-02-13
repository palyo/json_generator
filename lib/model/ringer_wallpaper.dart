

class RingerWallpaperCategory {
  List<RingerWallpaper>? categories;

  RingerWallpaperCategory({this.categories});

  RingerWallpaperCategory.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <RingerWallpaper>[];
      json['categories'].forEach((v) {
        categories!.add(RingerWallpaper.fromJson(v));
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

class RingerWallpaper {
  String? categoryName;
  String? categoryThumb = "";
  int? categoryId;
  int? wallpaperCount;
  List<Wallpaper>? wallpapers;

  RingerWallpaper({this.categoryName, this.categoryId, this.wallpapers});

  RingerWallpaper.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryThumb = json['categoryThumb'];
    categoryId = json['categoryId'];
    wallpaperCount = json['wallpaperCount'];
    if (json['templates'] != null) {
      wallpapers = <Wallpaper>[];
      json['wallpapers'].forEach((v) {
        wallpapers!.add(Wallpaper.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryName'] = categoryName;
    data['categoryThumb'] = categoryThumb;
    data['categoryId'] = categoryId;
    data['wallpaperCount'] = wallpaperCount;
    if (wallpapers != null) {
      data['wallpapers'] = wallpapers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallpaper {
  String? wallpaperTitle;
  String? wallpaperUrl;
  int? wallpaperId = 0;
  int? isPremium = 0;

  Wallpaper({this.wallpaperTitle, this.wallpaperUrl, this.wallpaperId});

  Wallpaper.fromJson(Map<String, dynamic> json) {
    wallpaperTitle = json['wallpaperTitle'];
    wallpaperUrl = json['wallpaperUrl'];
    wallpaperId = json['wallpaperId'];
    isPremium = json['isPremium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallpaperTitle'] = wallpaperTitle;
    data['wallpaperUrl'] = wallpaperUrl;
    data['wallpaperId'] = wallpaperId;
    data['isPremium'] = isPremium;
    return data;
  }
}
