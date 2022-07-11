import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/product_item.dart';

class GridItem extends StatelessWidget {
  final bool showFav;
  GridItem(this.showFav);
  @override
  Widget build(BuildContext context) {
    final products = showFav
        ? Provider.of<Products>(context).favProducts
        : Provider.of<Products>(context).items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products.elementAt(index),
          child: ProductItem(),
        );
      },
      itemCount: products.length,
      padding: EdgeInsets.all(10),
    );
  }
}
