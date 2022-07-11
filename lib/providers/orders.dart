import 'package:flutter/foundation.dart';
import 'package:pro_4/providers/cart.dart';

class OrderItem {
  final String id;
  final double total;
  final DateTime date;
  final List<CartItem> products;

  OrderItem({
    @required this.id,
    @required this.total,
    @required this.products,
    @required this.date,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void add(double total, List<CartItem> products) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        total: total,
        products: products,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
