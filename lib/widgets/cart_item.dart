import 'package:flutter/material.dart';
import 'package:pro_4/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String cartItemId;
  final String productId;
  final double price;
  final String title;
  final int quantity;

  CartItem(
      {this.price, this.quantity, this.title, this.cartItemId, this.productId});
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItemId),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delete',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ],
          ),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).deleteCartItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Are you sure ?'),
              content: Text('Do you want to delete this item from the cart ?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(true);
                  },
                  child: Text(
                    'Yes',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(false);
                  },
                  child: Text(
                    'No',
                  ),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text('\$${(price)}'),
                ),
              ),
            ),
            subtitle: Text('Total : ${price * quantity}'),
            title: Text(title),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
