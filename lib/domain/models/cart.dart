import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:effective_mobile/domain/models/cart_item.dart';

class Cart {
  final int? id;
  final List<CartItem>? basket;
  final String? delivery;
  final double? total;
  const Cart({
    this.id,
    this.basket,
    this.delivery,
    this.total,
  });

  Cart copyWith({
    int? id,
    List<CartItem>? basket,
    String? delivery,
    double? total,
  }) {
    return Cart(
      id: id ?? this.id,
      basket: basket ?? this.basket,
      delivery: delivery ?? this.delivery,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (basket != null) {
      result.addAll({'basket': basket!.map((x) => x.toMap()).toList()});
    }
    if (delivery != null) {
      result.addAll({'delivery': delivery});
    }
    if (total != null) {
      result.addAll({'total': total});
    }

    return result;
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: int.tryParse('${map['id']}'),
      basket: map['basket'] != null ? List<CartItem>.from(map['basket']?.map((x) => CartItem.fromMap(x))) : null,
      delivery: map['delivery'],
      total: double.tryParse('${map['total']}'),
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Cart(id: $id, basket: $basket, delivery: $delivery, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart && other.id == id && listEquals(other.basket, basket) && other.delivery == delivery && other.total == total;
  }

  @override
  int get hashCode {
    return id.hashCode ^ basket.hashCode ^ delivery.hashCode ^ total.hashCode;
  }

  Cart increaseQuantity(int index) {
    if (basket?.isEmpty ?? true) return this;

    final items = basket!;
    if (items[index].quantity > 100) return this;

    items[index] = items[index].copyWith(quantity: items[index].quantity + 1);
    return copyWith(basket: items);
  }

  Cart decreaseQuantity(int index) {
    if (basket?.isEmpty ?? true) return this;

    final items = basket!;
    if (items[index].quantity <= 1) return this;

    items[index] = items[index].copyWith(quantity: items[index].quantity - 1);
    return copyWith(basket: items);
  }
}
