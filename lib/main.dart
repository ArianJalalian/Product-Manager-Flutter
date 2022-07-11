import 'package:flutter/material.dart';
import 'package:pro_4/providers/cart.dart';
import 'package:pro_4/providers/orders.dart';
import 'package:pro_4/providers/products.dart';
import 'package:pro_4/screens/cart_screen.dart';
import 'package:pro_4/screens/editing_product_screen.dart';
import 'package:pro_4/screens/managing_products_screen.dart';
import 'package:pro_4/screens/orders_screen.dart';
import 'package:pro_4/screens/product_detail_screen.dart';
import 'package:pro_4/screens/product_overview_screen.dart';
import 'package:pro_4/widgets/order_item.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CartScreen.routeName: (_) => CartScreen(),
          OrdersScreen.routeName: (_) => OrdersScreen(),
          ManagingProductsScreen.routeName: (_) => ManagingProductsScreen(),
          EditingProductScreen.routeName: (_) => EditingProductScreen(),
        },
      ),
    );
  }
}
