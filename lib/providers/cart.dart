import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final int quantitiy;
  final String title;
  final double price;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.quantitiy,
    @required this.title,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get items {
    return {..._cartItems};
  }

  int get totalItemsCount {
    int count = 0;
    _cartItems.forEach(
      (id, item) {
        count += item.quantitiy;
      },
    );
    return count;
  }

  double get totalExpense {
    var total = 0.0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantitiy;
    });
    return total;
  }

  void deleteCartItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void deleteSingleProduct(String productId) {
    if (!_cartItems.containsKey(productId)) return;
    if (_cartItems[productId].quantitiy > 1)
      _cartItems.update(
        productId,
        (existing) => CartItem(
            id: existing.id,
            price: existing.price,
            quantitiy: existing.quantitiy - 1,
            title: existing.title),
      );
    else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  void add(String productId, String title, double price) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existing) => CartItem(
          id: existing.id,
          price: existing.price,
          quantitiy: existing.quantitiy + 1,
          title: existing.title,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          quantitiy: 1,
          title: title,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _cartItems = {};
    notifyListeners();
  }
}
