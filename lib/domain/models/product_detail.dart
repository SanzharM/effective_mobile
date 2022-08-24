import 'dart:convert';

import 'package:effective_mobile/core/supporting/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

class ProductDetail {
  final int? id;
  final String? title;
  final bool isFavorites;
  final double? price;
  final double? rating;
  final String? sd;
  final String? ssd;
  final List<String?>? images;
  final List<Color?>? colors;
  final List<String?>? capacity;
  final String? camera;
  final String? cpu;

  const ProductDetail({
    this.id,
    this.title,
    this.isFavorites = false,
    this.price,
    this.rating,
    this.sd,
    this.ssd,
    this.images,
    this.colors,
    this.capacity,
    this.camera,
    this.cpu,
  });

  ProductDetail copyWith({
    int? id,
    String? title,
    bool? isFavorites,
    double? price,
    double? rating,
    String? sd,
    String? ssd,
    List<String?>? images,
    List<Color?>? colors,
    List<String?>? capacity,
    String? camera,
    String? cpu,
  }) {
    return ProductDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorites: isFavorites ?? this.isFavorites,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      sd: sd ?? this.sd,
      ssd: ssd ?? this.ssd,
      images: images ?? this.images,
      colors: colors ?? this.colors,
      capacity: capacity ?? this.capacity,
      camera: camera ?? this.camera,
      cpu: cpu ?? this.cpu,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    result.addAll({'isFavorites': isFavorites});
    if (price != null) {
      result.addAll({'price': price});
    }
    if (rating != null) {
      result.addAll({'rating': rating});
    }
    if (sd != null) {
      result.addAll({'sd': sd});
    }
    if (ssd != null) {
      result.addAll({'ssd': ssd});
    }
    if (images?.isNotEmpty ?? false) {
      result.addAll({'images': images});
    }
    if (colors?.isNotEmpty ?? false) {
      result.addAll({'colors': colors?.map((x) => x?.value).toList()});
    }
    if (capacity?.isNotEmpty ?? false) {
      result.addAll({'capacity': capacity});
    }
    if (camera != null) {
      result.addAll({'camera': camera});
    }
    if (cpu != null) {
      result.addAll({'cpu': cpu});
    }

    return result;
  }

  factory ProductDetail.fromMap(Map<String, dynamic> map) {
    return ProductDetail(
      id: int.tryParse('${map['id']}'),
      title: map['title'],
      isFavorites: map['isFavorites'] ?? false,
      price: double.tryParse('${map['price']}'),
      rating: double.tryParse('${map['rating']}'),
      sd: map['sd'],
      ssd: map['ssd'],
      images: List<String?>.from(map['images']),
      colors: List<Color?>.from(map['color']?.map((x) => Utils.getColorFromHex(x))),
      capacity: List<String?>.from(map['capacity']),
      camera: map['camera'],
      cpu: map['CPU'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductDetail.fromJson(String source) => ProductDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductDetail(id: $id, title: $title, isFavorites: $isFavorites, price: $price, rating: $rating, sd: $sd, ssd: $ssd, images: $images, colors: $colors, capacity: $capacity, camera: $camera, cpu: $cpu)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductDetail &&
        other.id == id &&
        other.title == title &&
        other.isFavorites == isFavorites &&
        other.price == price &&
        other.rating == rating &&
        other.sd == sd &&
        other.ssd == ssd &&
        listEquals(other.images, images) &&
        listEquals(other.colors, colors) &&
        listEquals(other.capacity, capacity) &&
        other.camera == camera &&
        other.cpu == cpu;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        isFavorites.hashCode ^
        price.hashCode ^
        rating.hashCode ^
        sd.hashCode ^
        ssd.hashCode ^
        images.hashCode ^
        colors.hashCode ^
        capacity.hashCode ^
        camera.hashCode ^
        cpu.hashCode;
  }
}
