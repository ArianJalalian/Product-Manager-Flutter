import 'package:flutter/material.dart';
import 'package:pro_4/providers/products.dart';
import 'package:pro_4/screens/editing_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;
  final int indexOfProduct;

  UserProductItem({this.imageUrl, this.title, this.indexOfProduct, this.id});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditingProductScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {
                showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text('Are you sure?'),
                            content:
                                Text('Do you want to delete this product?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          );
                        })
                    .then((value) => value
                        ? Provider.of<Products>(context, listen: false)
                            .deleteByIndex(indexOfProduct)
                        : null);
              },
            ),
          ],
        ),
      ),
    );
  }
}
