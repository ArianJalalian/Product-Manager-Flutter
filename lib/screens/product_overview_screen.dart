import 'package:flutter/material.dart';
import 'package:pro_4/providers/cart.dart';
import 'package:pro_4/providers/products.dart';
import 'package:pro_4/screens/cart_screen.dart';
import 'package:pro_4/widgets/badge.dart';
import 'package:pro_4/widgets/my_drawer.dart';
import 'package:provider/provider.dart';
import '../widgets/grid_item.dart';

enum Filter {
  ShowFavourits,
  ShowAll,
}

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  var _showFav = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSet().then(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      ).catchError((error) {
        print(error);
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == Filter.ShowFavourits)
                  _showFav = true;
                else
                  _showFav = false;
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Show Favourites'),
                value: Filter.ShowFavourits,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: Filter.ShowAll,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.totalItemsCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_bag),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridItem(_showFav),
    );
  }
}
