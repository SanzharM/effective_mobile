import 'dart:convert';

class CartItem {
  final int? id;
  final String? image;
  final double? price;
  final String? title;
  final int quantity;

  const CartItem({
    this.id,
    this.image,
    this.price,
    this.title,
    this.quantity = 1,
  });

  CartItem copyWith({
    int? id,
    String? image,
    double? price,
    String? title,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      image: image ?? this.image,
      price: price ?? this.price,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (image != null) {
      result.addAll({'image': image});
    }
    if (price != null) {
      result.addAll({'price': price});
    }
    if (title != null) {
      result.addAll({'title': title});
    }
    result.addAll({'quantity': quantity});

    return result;
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: int.tryParse('${map['id']}'),
      image: map['images'],
      price: double.tryParse('${map['price']}'),
      title: map['title'],
      quantity: int.tryParse('${map['quantity']}') ?? 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItem(id: $id, image: $image, price: $price, title: $title, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.id == id &&
        other.image == image &&
        other.price == price &&
        other.title == title &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^ image.hashCode ^ price.hashCode ^ title.hashCode ^ quantity.hashCode;
  }
}
