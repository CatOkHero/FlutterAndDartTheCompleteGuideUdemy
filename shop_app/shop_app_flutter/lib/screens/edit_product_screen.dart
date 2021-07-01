import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/providers/product.dart';
import 'package:shop_app_flutter/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = "EditProcutScreen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _product = Product(
      id: null, title: null, description: null, price: 0.0, imageUrl: null);
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(updateListener);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _product = Provider.of<Products>(context, listen: false)
            .items
            .firstWhere((element) => element.id == productId);
        _imageUrlController.text = _product.imageUrl;
      }

      _isInit = false;
    }

    super.didChangeDependencies();
  }

  void updateListener() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(updateListener);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      if (_product.id == null) {
        Provider.of<Products>(context, listen: false).addProducts(_product);
      } else {
        Provider.of<Products>(context, listen: false).updateProduct(_product);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
            ),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _product.title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (newValue) {
                  _product = Product(
                    id: _product.id,
                    isFavorite: _product.isFavorite,
                    title: newValue,
                    description: _product.description,
                    price: _product.price,
                    imageUrl: _product.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Shouldn't be empty";
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _product.price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: (newValue) {
                  _product = Product(
                    id: _product.id,
                    isFavorite: _product.isFavorite,
                    title: _product.title,
                    description: _product.description,
                    price: double.parse(newValue),
                    imageUrl: _product.imageUrl,
                  );
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Shouldn't be empty";
                  }

                  if (double.tryParse(value) == null) {
                    return 'Price should be valid number';
                  }

                  if (double.parse(value) <= 0.0) {
                    return 'Price should be grater then 0';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _product.description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
                keyboardType: TextInputType.multiline,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: (newValue) {
                  _product = Product(
                    id: _product.id,
                    isFavorite: _product.isFavorite,
                    title: _product.title,
                    description: newValue,
                    price: _product.price,
                    imageUrl: _product.imageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter url')
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image Url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onEditingComplete: () {
                        _saveForm();
                        setState(() {});
                      },
                      onSaved: (newValue) {
                        _product = Product(
                          id: _product.id,
                          isFavorite: _product.isFavorite,
                          title: _product.title,
                          description: _product.description,
                          price: _product.price,
                          imageUrl: newValue,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
