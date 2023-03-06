class InvitationTemplate {
  List<CardTemplate>? cardTemplate;

  InvitationTemplate({this.cardTemplate});

  InvitationTemplate.fromJson(Map<String, dynamic> json) {
    if (json['cardTemplate'] != null) {
      cardTemplate = <CardTemplate>[];
      json['cardTemplate'].forEach((v) {
        cardTemplate!.add(CardTemplate.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cardTemplate != null) {
      data['cardTemplate'] = cardTemplate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardTemplate {
  String? demoUrl;
  String? zipUrl;
  int? isPremium = 0;
  int? isTrending = 0;

  CardTemplate({this.demoUrl, this.zipUrl, this.isPremium, this.isTrending});

  CardTemplate.fromJson(Map<String, dynamic> json) {
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