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

class SingleCategoryViewModel with ChangeNotifier {
  CategoryRepository _categoryRepository = CategoryRepository();
  ProductRepository _productRepository = ProductRepository();
  CategoryModel? _category = CategoryModel();
  CategoryModel? get category => _category;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  Future<void> getProductByCategory(String categoryId) async{
    _category=CategoryModel();
    _products=[];
    notifyListeners();
    try{
      print(categoryId);
      var response = await _categoryRepository.getCategory(categoryId);
      _category = response.data();
      var productResponse = await _productRepository.getProductByCategory(categoryId);
      for (var element in productResponse) {
        _products.add(element.data());
      }

      notifyListeners();
    }catch(e){
      _category = null;
      notifyListeners();
    }
  }

}
