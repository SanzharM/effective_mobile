import 'dart:convert';

class BestSeller {
  final int? id;
  final bool isFavorites;
  final String? title;
  final double? realPrice; // Without discount
  final double? currentPrice; // Including discount
  final String? imageUrl;

  const BestSeller({
    this.id,
    this.isFavorites = false,
    this.title,
    this.realPrice,
    this.currentPrice,
    this.imageUrl,
  });

  BestSeller copyWith({
    int? id,
    bool? isFavorites,
    String? title,
    double? realPrice,
    double? currentPrice,
    String? imageUrl,
  }) {
    return BestSeller(
      id: id ?? this.id,
      isFavorites: isFavorites ?? this.isFavorites,
      title: title ?? this.title,
      realPrice: realPrice ?? this.realPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'isFavorites': isFavorites});
    if (title != null) {
      result.addAll({'title': title});
    }
    if (realPrice != null) {
      result.addAll({'realPrice': realPrice});
    }
    if (currentPrice != null) {
      result.addAll({'currentPrice': currentPrice});
    }
    if (imageUrl != null) {
      result.addAll({'imageUrl': imageUrl});
    }

    return result;
  }

  factory BestSeller.fromMap(Map<String, dynamic> map) {
    return BestSeller(
      id: map['id']?.toInt(),
      isFavorites: map['is_favorites'] ?? false,
      title: map['title'],
      realPrice: map['price_without_discount']?.toDouble(),
      currentPrice: map['discount_price']?.toDouble(),
      imageUrl: map['picture'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BestSeller.fromJson(String source) => BestSeller.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BestSeller(id: $id, isFavorites: $isFavorites, title: $title, realPrice: $realPrice, currentPrice: $currentPrice, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BestSeller &&
        other.id == id &&
        other.isFavorites == isFavorites &&
        other.title == title &&
        other.realPrice == realPrice &&
        other.currentPrice == currentPrice &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^ isFavorites.hashCode ^ title.hashCode ^ realPrice.hashCode ^ currentPrice.hashCode ^ imageUrl.hashCode;
  }
}
