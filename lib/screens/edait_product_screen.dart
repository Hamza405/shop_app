import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:max_cours_shop_app/model/product_model.dart';
import 'package:max_cours_shop_app/providers/products_provider.dart';
import 'package:max_cours_shop_app/widgets/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descritpionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _isEdit=false;
  File _imageFile;
  void _pickedImage(File image) {
    _imageFile = image;
  }

  var _editproduct =
      ProductModel(id: null, title: '', description: '', price: 0);
  var _initValue = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': ''
  };
  var _isInit = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _isEdit=true;
        _editproduct =
            Provider.of<ProductsProvider>(context).findById(productId);
            
        _initValue = {
          'title': _editproduct.title,
          'price': _editproduct.price.toString(),
          'description': _editproduct.description.toString(),
          'imageUrl': _editproduct.imageUrl.toString()
        };
        print(_initValue['imageUrl'].toString());
      }
      _imageUrlController.text = _editproduct.imageUrl;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descritpionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final valdit = _formKey.currentState.validate();
    if (!valdit) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if(!_isEdit){
      final ref = FirebaseStorage.instance
        .ref()
        .child('products_images')
        .child(DateTime.now().toIso8601String() + '.jpg');
    await ref.putFile(_imageFile);
     final imageUrl = await ref.getDownloadURL();
     _editproduct = ProductModel(
        id: _editproduct.id,
        isFavorite: _editproduct.isFavorite,
        title: _editproduct.description,
        description: _editproduct.description,
        price: _editproduct.price,
        imageUrl: imageUrl);
        print(_editproduct.imageUrl);
    }
    
    
    if (_editproduct.id != null) {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .editproduct(_editproduct.id, _editproduct);
      } catch (e) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occurred!'),
                  content: Text(e.toString()),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addproduct(_editproduct);
      } catch (e) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occurred!'),
                  content: Text(e.toString()),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                    ),
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initValue['title'],
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter your title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editproduct = ProductModel(
                            id: _editproduct.id,
                            isFavorite: _editproduct.isFavorite,
                            title: value,
                            description: _editproduct.description,
                            price: _editproduct.price,
                            imageUrl: _editproduct.imageUrl);
                      },
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_priceFocusNode),
                    ),
                    TextFormField(
                      initialValue: _initValue['price'],
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'please enter a valid price';
                        }
                        if (double.parse(value) <= 0) {
                          return 'please enter your price';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceFocusNode,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(_descritpionFocusNode),
                      onSaved: (value) {
                        _editproduct = ProductModel(
                            id: _editproduct.id,
                            isFavorite: _editproduct.isFavorite,
                            title: _editproduct.title,
                            description: _editproduct.description,
                            price: double.parse(value),
                            imageUrl: _editproduct.imageUrl);
                      },
                    ),
                    TextFormField(
                      initialValue: _initValue['description'],
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your description';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.multiline,
                      focusNode: _descritpionFocusNode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_priceFocusNode),
                      onSaved: (value) {
                        _editproduct = ProductModel(
                            id: _editproduct.id,
                            isFavorite: _editproduct.isFavorite,
                            title: _editproduct.title,
                            description: value,
                            price: _editproduct.price,
                            imageUrl: _editproduct.imageUrl);
                      },
                    ),
                    SizedBox(height: 20,),
                    UserImagePicker(_pickedImage,_imageUrlController.text,_isEdit)
                  ],
                ),
              ),
            ),
    );
  }
}
