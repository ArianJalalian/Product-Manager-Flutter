import 'package:flutter/material.dart';
import 'package:pro_4/providers/product.dart';
import 'package:pro_4/providers/products.dart';
import 'package:provider/provider.dart';

class EditingProductScreen extends StatefulWidget {
  static const routeName = '/editing-screen';
  @override
  _EditingProductScreenState createState() => _EditingProductScreenState();
}

class _EditingProductScreenState extends State<EditingProductScreen> {
  final _imageURlFocus = FocusNode();
  final _imageURLController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _showPreview = false;
  var _isEditingProduct = false;
  var _isinit = false;
  var _isLoading = false;
  var _editingProduct = Product(
    id: null,
    desc: '',
    imageUrl: '',
    price: 0.0,
    title: '',
  );

  Future<void> _save() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });

    if (_isEditingProduct) {
      await Provider.of<Products>(context, listen: false)
          .updateById(_editingProduct);
      Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .add(_editingProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('An error occured !'),
              content: Text('There is something wrong'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'),
                ),
              ],
            );
          },
        );
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _imageURlFocus.dispose();
    _imageURLController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (!_isinit) {
      final String _id = ModalRoute.of(context).settings.arguments as String;
      if (_id != null) {
        _isEditingProduct = true;
        _editingProduct =
            Provider.of<Products>(context, listen: false).getById(_id);
        _imageURLController.text = _editingProduct.imageUrl;
        _showPreview = true;
      }
    }
    _isinit = true;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _imageURlFocus.addListener(
      () {
        if (!_imageURLController.text.startsWith('http') &&
            !_imageURLController.text.startsWith('https')) return;
        if (!_imageURLController.text.endsWith('.png') &&
            !_imageURLController.text.endsWith('.jpg') &&
            !_imageURLController.text.endsWith('.jpeg')) return;
        if (!_imageURlFocus.hasFocus) {
          _showPreview = true;
          setState(() {});
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('Editing Product'),
            ),
            body: Padding(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue:
                          _isEditingProduct ? _editingProduct.title : '',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please enter a title for your product.';
                        return null;
                      },
                      onSaved: (value) {
                        _editingProduct = Product(
                          id: _editingProduct.id,
                          desc: _editingProduct.desc,
                          imageUrl: _editingProduct.imageUrl,
                          price: _editingProduct.price,
                          isFavourite: _editingProduct.isFavourite,
                          title: value,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                    ),
                    TextFormField(
                      initialValue: _isEditingProduct
                          ? _editingProduct.price.toString()
                          : '',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please enter a price for your product.';
                        if (double.tryParse(value) == null)
                          return 'Please enter a valid price.';
                        if (double.parse(value) < 0)
                          return 'A product \'s price , cannot be negetavive.';
                        return null;
                      },
                      onSaved: (value) {
                        _editingProduct = Product(
                          id: _editingProduct.id,
                          desc: _editingProduct.desc,
                          imageUrl: _editingProduct.imageUrl,
                          isFavourite: _editingProduct.isFavourite,
                          price: double.parse(value),
                          title: _editingProduct.title,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      initialValue:
                          _isEditingProduct ? _editingProduct.desc : '',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (value) {
                        _editingProduct = Product(
                          id: _editingProduct.id,
                          desc: value,
                          imageUrl: _editingProduct.imageUrl,
                          isFavourite: _editingProduct.isFavourite,
                          price: _editingProduct.price,
                          title: _editingProduct.title,
                        );
                      },
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please enter a description for your product.';
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: _showPreview
                              ? Image.network(
                                  _imageURLController.text,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Text(
                                    'Add an image url',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter a url for image.';
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https'))
                                return 'Please enter a valid url for image.';
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg'))
                                return 'Please enter a valid url for image.';
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              if (_imageURLController.text.isEmpty) {
                                print('here1');
                                _showPreview = false;
                                setState(() {});
                                return;
                              }
                              if (!_imageURLController.text
                                      .startsWith('http') &&
                                  !_imageURLController.text
                                      .startsWith('https')) {
                                print('here2');
                                _showPreview = false;
                                setState(() {});
                                return;
                              }
                              if (!_imageURLController.text.endsWith('.png') &&
                                  !_imageURLController.text.endsWith('.jpg') &&
                                  !_imageURLController.text.endsWith('.jpeg')) {
                                _showPreview = false;
                                setState(() {});
                                return;
                              }
                              _showPreview = true;
                              setState(() {});
                            },
                            onSaved: (value) {
                              _editingProduct = Product(
                                id: _editingProduct.id,
                                desc: _editingProduct.desc,
                                imageUrl: value,
                                price: _editingProduct.price,
                                isFavourite: _editingProduct.isFavourite,
                                title: _editingProduct.title,
                              );
                            },
                            focusNode: _imageURlFocus,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: 'Image URL',
                            ),
                            keyboardType: TextInputType.url,
                            controller: _imageURLController,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        onPressed: _save,
                        child: Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
