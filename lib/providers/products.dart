import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _productItems = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      desc: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://images.yaoota.com/ZLCt4CElVISXaGfVndubQEkIld4=/trim/yaootaweb-production-ng/media/crawledproductimages/12a38a1b4715a348b1e8f93dbf814a61a00489e2.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      desc: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      desc: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTeiHMeJ5hg4JYXZh_DVbr-k2FV643dI5tdw&usqp=CAU',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      desc: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._productItems];
  }

  List<Product> get favProducts {
    return _productItems.where((pr) => pr.isFavourite).toList();
  }

  Future<void> fetchAndSet() async {
    const url =
        'https://flutter-pro-4-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final decodedData =
          jsonDecode(response.body) as Map<String, Map<String, String>>;
      List loadedData = [];
      decodedData.forEach(
        (id, prData) {
          loadedData.add(
            Product(
              id: id,
              desc: prData['desc'],
              imageUrl: prData['image'],
              price: double.parse(prData['price']),
              title: prData['title'],
              isFavourite: prData['isFav'] == 'false' ? false : true,
            ),
          );
        },
      );
      _productItems = loadedData;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> add(Product product) async {
    const url =
        'https://flutter-pro-4-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'desc': product.desc,
          'isFav': product.isFavourite,
          'image': product.imageUrl,
        }),
      );
      final pr = Product(
        desc: product.desc,
        id: jsonDecode(response.body)['name'],
        imageUrl: product.imageUrl,
        price: product.price,
        title: product.title,
      );
      _productItems.add(pr);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void deleteByIndex(int index) {
    if (index < 0 || index >= _productItems.length) return;
    _productItems.removeAt(index);
    notifyListeners();
  }

  Future<void> updateById(Product newProduct) async {
    final int index = _productItems.indexWhere((pr) => pr.id == newProduct.id);
    final url =
        'https://flutter-pro-4-default-rtdb.firebaseio.com/products.${newProduct.id}.json';
    await http.patch(
      url,
      body: jsonEncode(
        {
          'title': newProduct.id,
          'price': newProduct.price,
          'desc': newProduct.desc,
          'image': newProduct.imageUrl,
        },
      ),
    );
    _productItems[index] = newProduct;
    notifyListeners();
  }

  Product getById(String id) {
    return _productItems.firstWhere((pr) => pr.id == id);
  }
}
