import 'dart:convert';

class HotSale {
  final int? id;
  final bool isNew;
  final String? title;
  final String? subtitle;
  final String? imageUrl;
  final bool isBuy;

  const HotSale({
    this.id,
    this.isNew = false,
    this.title,
    this.subtitle,
    this.imageUrl,
    this.isBuy = false,
  });

  HotSale copyWith({
    int? id,
    bool? isNew,
    String? title,
    String? subtitle,
    String? imageUrl,
    bool? isBuy,
  }) {
    return HotSale(
      id: id ?? this.id,
      isNew: isNew ?? this.isNew,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
      isBuy: isBuy ?? this.isBuy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'isNew': isNew});
    if (title != null) {
      result.addAll({'title': title});
    }
    if (subtitle != null) {
      result.addAll({'subtitle': subtitle});
    }
    if (imageUrl != null) {
      result.addAll({'imageUrl': imageUrl});
    }
    result.addAll({'isBuy': isBuy});

    return result;
  }

  factory HotSale.fromMap(Map<String, dynamic> map) {
    return HotSale(
      id: map['id']?.toInt(),
      isNew: map['is_new'] ?? false,
      title: map['title'],
      subtitle: map['subtitle'],
      imageUrl: map['picture'],
      isBuy: map['is_buy'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotSale.fromJson(String source) => HotSale.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotSale(id: $id, isNew: $isNew, title: $title, subtitle: $subtitle, imageUrl: $imageUrl, isBuy: $isBuy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotSale &&
        other.id == id &&
        other.isNew == isNew &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.imageUrl == imageUrl &&
        other.isBuy == isBuy;
  }

  @override
  int get hashCode {
    return id.hashCode ^ isNew.hashCode ^ title.hashCode ^ subtitle.hashCode ^ imageUrl.hashCode ^ isBuy.hashCode;
  }
}
