import 'package:flutter/material.dart';
import 'package:pro_4/screens/managing_products_screen.dart';
import 'package:pro_4/screens/orders_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
              'Products',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Orders',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Manage Your Products',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(ManagingProductsScreen.routeName);
            },
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
