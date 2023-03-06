class Fonts {
  List<Font>? fonts;

  Fonts({this.fonts});

  Fonts.fromJson(Map<String, dynamic> json) {
    if (json['fonts'] != null) {
      fonts = <Font>[];
      json['fonts'].forEach((v) {
        fonts!.add(Font.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fonts != null) {
      data['fonts'] = fonts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Font {
  String? fontName;
  String? locale;
  int? fontId;
  String? fontUrl;
  String? thumbUrl;

  Font({this.fontName, this.fontId, this.fontUrl});

  Font.fromJson(Map<String, dynamic> json) {
    fontName = json['fontName'];
    locale = json['locale'];
    fontId = json['fontId'];
    fontUrl = json['fontUrl'];
    thumbUrl = json['thumbUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fontName'] = fontName;
    data['locale'] = locale;
    data['fontId'] = fontId;
    data['fontUrl'] = fontUrl;
    data['thumbUrl'] = thumbUrl;
    return data;
  }
}
