import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:max_cours_shop_app/model/product_model.dart';
import 'package:max_cours_shop_app/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descritpionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _editproduct =
      ProductModel(id: null, title: '', description: '', price: 0);
  var _initValue={
    'title' : '',
    'price':'',
    'description':'',
    'imageUrl':''
  };    
  var _isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    
    super.initState();
  }

  @override
  void didChangeDependencies(){
    if(_isInit){
      final productId = ModalRoute.of(context).settings.arguments as String;
      if(productId != null){
        _editproduct = Provider.of<ProductsProvider>(context).findById(productId);
        _initValue = {
           'title' : _editproduct.title,
    'price':_editproduct.price.toString(),
    'description':_editproduct.description.toString(),
    'imageUrl':_editproduct.imageUrl
        };
      }
      _imageUrlController.text=_editproduct.imageUrl;
      
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descritpionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if(!_imageUrlController.text.startsWith('http') &&
                            !_imageUrlController.text.startsWith('https')||!_imageUrlController.text.endsWith('.png') &&
                            !_imageUrlController.text.endsWith('.jpg') &&
                            !_imageUrlController.text.endsWith('.jpeg')){
                              return;
                            }
      
    }
    setState(() {});
  }

  void _saveForm() {
    final valdit = _formKey.currentState.validate();
    if (!valdit) {
      return;
    }
    _formKey.currentState.save();
    if(_editproduct.id!=null){
      Provider.of<ProductsProvider>(context,listen: false).editproduct(_editproduct.id, _editproduct);
    }else{
      Provider.of<ProductsProvider>(context,listen: false).addproduct(_editproduct);
    }
    
    
    Navigator.of(context).pop();
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
      body: Padding(
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
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_descritpionFocusNode),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageUrlController.text.isEmpty
                          ? Center(child: Text('Enter the Url'))
                          : FittedBox(
                              child: Image.network(
                              _imageUrlController.text.toString(),
                              fit: BoxFit.cover,
                            ))),
                  Expanded(
                    child: TextFormField(
                      
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter yout Url image';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Enter a valid Url';
                        }
                        if (!value.endsWith('.png') &&
                            !value.endsWith('.jpg') &&
                            !value.endsWith('.jpeg')) {
                          return 'Enter a valid Image Url';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Image Url',
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      controller: _imageUrlController,
                      onSaved: (value) {
                        _editproduct = ProductModel(
                           id: _editproduct.id,
                      isFavorite: _editproduct.isFavorite,
                            title: _editproduct.title,
                            description: _editproduct.description,
                            price: _editproduct.price,
                            imageUrl: _imageUrlController.text);
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
