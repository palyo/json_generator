class InvitationFonts {
  List<InvitationFont>? fonts;

  InvitationFonts({this.fonts});

  InvitationFonts.fromJson(Map<String, dynamic> json) {
    if (json['fonts'] != null) {
      fonts = <InvitationFont>[];
      json['fonts'].forEach((v) {
        fonts!.add(InvitationFont.fromJson(v));
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

class InvitationFont {
  String? fontName;
  String? locale;
  int? fontId;
  String? fontUrl;
  String? thumbUrl;

  InvitationFont({this.fontName, this.fontId, this.fontUrl});

  InvitationFont.fromJson(Map<String, dynamic> json) {
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
