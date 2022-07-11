import 'package:flutter/material.dart';
import 'package:pro_4/providers/products.dart';
import 'package:pro_4/screens/editing_product_screen.dart';
import 'package:pro_4/widgets/my_drawer.dart';
import 'package:pro_4/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class ManagingProductsScreen extends StatelessWidget {
  static const routeName = '/managing-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditingProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: MyDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await Provider.of<Products>(context, listen: false).fetchAndSet();
        },
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemBuilder: (_, i) {
            return Column(
              key: ValueKey(productsData[i].id),
              children: [
                UserProductItem(
                  id: productsData[i].id,
                  imageUrl: productsData[i].imageUrl,
                  title: productsData[i].title,
                  indexOfProduct: i,
                ),
                Divider(),
              ],
            );
          },
          itemCount: productsData.length,
        ),
      ),
    );
  }
}
