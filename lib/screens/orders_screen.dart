import 'package:flutter/material.dart';
import 'package:pro_4/providers/orders.dart' show Orders;
import 'package:pro_4/widgets/my_drawer.dart';
import 'package:pro_4/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (_, i) {
          return OrderItem(
            order: ordersData.orders.elementAt(i),
          );
        },
        itemCount: ordersData.orders.length,
      ),
    );
  }
}
