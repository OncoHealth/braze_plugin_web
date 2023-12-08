import 'dart:convert';

import 'package:braze_plugin/braze_plugin.dart';

class BrazeContentCardWeb {
  String? id;
  String? title;
  String? description;
  String? url;
  double? aspectRation;
  String? imageUrl;
  DateTime created = DateTime.now();
  DateTime updated = DateTime.now();
  List<dynamic>? categories;
  DateTime expiresAt = DateTime.now();
  String? linkText;
  Map<String, dynamic> extras = {};
  bool? pinned;
  bool? dismissible;
  bool? dismissed;
  bool? clicked;
  bool? isControl;
  bool? test;
  String? ka;
  String? ke;

  /// card tyme is required
  String? type;
  bool? jd;

  BrazeContentCard? _mobileContentCard;
  set mobileContentCard(BrazeContentCard card) {
    this._mobileContentCard = card;
  }

  BrazeContentCard get mobileContentCard {
    if (_mobileContentCard != null) return _mobileContentCard!;

    return BrazeContentCard('')
      ..id = id ?? ''
      ..title = title ?? ''
      ..description = description ?? ''
      ..url = url ?? ''
      ..imageAspectRatio = aspectRation?.toDouble() ?? 1.0
      ..image = imageUrl ?? ''
      ..created = created.millisecondsSinceEpoch ~/ 1000
      ..expiresAt = expiresAt.millisecondsSinceEpoch ~/ 1000
      ..linkText = linkText ?? ''
      ..extras = Map.from(extras) // Assuming that extras is a Map<String, String> in BrazeContentCard
      ..pinned = pinned ?? false
      ..dismissable = dismissible ?? false
      ..removed = dismissed ?? false // Assuming dismissed in BrazeContentCardWeb corresponds to removed in
      // BrazeContentCard
      ..clicked = clicked ?? false
      ..isControl = isControl ?? false;
  }

  BrazeContentCardWeb({
    this.id,
    this.title,
    this.description,
    this.url,
    this.aspectRation,
    this.imageUrl,
    required this.created,
    required this.updated,
    required this.categories,
    required this.expiresAt,
    this.linkText,
    required this.extras,
    this.pinned,
    this.dismissible,
    this.dismissed,
    this.clicked,
    this.isControl,
    this.test,
    this.ka,
    this.ke,
    this.type,
    this.jd,
  });

  factory BrazeContentCardWeb.fromJson(Map<String, dynamic> json) {
    return BrazeContentCardWeb(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      aspectRation: json['aspectRation']?.toDouble(),
      imageUrl: json['imageUrl'],
      created: json['created'],
      updated: json['updated'],
      categories: List<dynamic>.from(json['categories']),
      expiresAt: json['expiresAt'],
      linkText: json['linkText'],
      extras: Map<String, dynamic>.from(json['extras']),
      pinned: json['pinned'],
      dismissible: json['dismissible'],
      dismissed: json['dismissed'],
      clicked: json['clicked'],
      isControl: json['isControl'],
      test: json['test'],
      ka: json['ka'],
      ke: json['ke'],
      type: json['Yc'],
      jd: json['jd'],
    );
  }

  factory BrazeContentCardWeb.fromMap(Map<String, dynamic> map) {
    return BrazeContentCardWeb(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      url: map['url'],
      aspectRation: map['aspectRation']?.toDouble(),
      imageUrl: map['imageUrl'],
      created: map['created'] != null ? DateTime.parse(map['created']) : DateTime.now(),
      updated: map['updated'] != null ? DateTime.parse(map['updated']) : DateTime.now(),
      categories: map['categories'] ?? [],
      expiresAt: map['expiresAt'] != null ? DateTime.parse(map['expiresAt']) : DateTime.now(),
      linkText: map['linkText'],
      extras: map['extras'] ?? {},
      pinned: map['pinned'],
      dismissible: map['dismissible'],
      dismissed: map['dismissed'],
      clicked: map['clicked'],
      isControl: map['isControl'],
      test: map['test'],
      ka: map['ka'],
      ke: map['ke'],
      type: map['Yc'],
      jd: map['jd'],
    );
  }

  factory BrazeContentCardWeb.fromBrazeContentCard(BrazeContentCard originalCard) {
    final card = BrazeContentCardWeb(
      id: originalCard.id,
      title: originalCard.title,
      description: originalCard.description,
      url: originalCard.url,
      aspectRation: originalCard.imageAspectRatio.toDouble(),
      imageUrl: originalCard.image,
      created: DateTime.fromMillisecondsSinceEpoch(originalCard.created * 1000),
      updated: DateTime.fromMillisecondsSinceEpoch(originalCard.created * 1000),

      /// unimplemented for now
      categories: null,
      expiresAt: DateTime.fromMillisecondsSinceEpoch(originalCard.expiresAt * 1000),
      linkText: originalCard.linkText,
      extras: originalCard.extras,
      pinned: originalCard.pinned,
      dismissible: originalCard.dismissable,

      /// maybe wrong but there is not inaf documentation
      dismissed: originalCard.removed,
      clicked: originalCard.clicked,
      isControl: originalCard.isControl,
    );
    card.mobileContentCard = originalCard;
    return card;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'aspectRation': aspectRation,
      'imageUrl': imageUrl,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'categories': categories,
      'expiresAt': expiresAt.toIso8601String(),
      'linkText': linkText,
      'extras': extras,
      'pinned': pinned,
      'dismissible': dismissible,
      'dismissed': dismissed,
      'clicked': clicked,
      'isControl': isControl,
      'test': test,
      'ka': ka,
      'ke': ke,
      'Yc': type,
      'jd': jd,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
