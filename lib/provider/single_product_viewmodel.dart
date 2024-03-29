import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepal_wanderer/models/category_model.dart';
import 'package:nepal_wanderer/models/product_model.dart';
import 'package:nepal_wanderer/models/user_model.dart';
import 'package:nepal_wanderer/repo/auth_repositories.dart';
import 'package:nepal_wanderer/services/firebase_service.dart';
import 'package:nepal_wanderer/provider/global_ui_viewmodel.dart';

import '../repo/category_repositories.dart';
import '../repo/product_repositories.dart';

class SingleProductViewModel with ChangeNotifier {
  ProductRepository _productRepository = ProductRepository();
  ProductModel? _product = ProductModel();
  ProductModel? get product => _product;

  Future<void> getProducts(String productId) async{
    _product=ProductModel();
    notifyListeners();
    try{
      var response = await _productRepository.getOneProduct(productId);
      _product = response.data();
      notifyListeners();
    }catch(e){
      _product = null;
      notifyListeners();
    }
  }

  Future<void> addProduct(ProductModel product) async{
    try{
      var response = await _productRepository.addProducts(product: product);
    }catch(e){
      notifyListeners();
    }
  }

}
