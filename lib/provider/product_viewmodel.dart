import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nepal_wanderer/models/category_model.dart';
import 'package:nepal_wanderer/models/product_model.dart';
import 'package:nepal_wanderer/models/user_model.dart';
import 'package:nepal_wanderer/repo/auth_repositories.dart';
import 'package:nepal_wanderer/repo/favorite_repositories.dart';
import 'package:nepal_wanderer/services/firebase_service.dart';
import 'package:nepal_wanderer/provider/global_ui_viewmodel.dart';

import '../models/favorite_model.dart';
import '../repo/category_repositories.dart';
import '../repo/product_repositories.dart';

class ProductViewModel with ChangeNotifier {
  ProductRepository _productRepository = ProductRepository();
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> getProducts() async{
    _products=[];
    notifyListeners();
    try{
      var response = await _productRepository.getAllProducts();
      for (var element in response) {
        print(element.id);
        _products.add(element.data());
      }
      notifyListeners();
    }catch(e){
      print(e);
      _products = [];
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
