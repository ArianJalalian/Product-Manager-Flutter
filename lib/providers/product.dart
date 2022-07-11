import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String desc;
  final double price;
  final String imageUrl;
  final String title;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.desc,
    @required this.imageUrl,
    @required this.price,
    @required this.title,
    this.isFavourite = false,
  });

  void toggleIsFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
