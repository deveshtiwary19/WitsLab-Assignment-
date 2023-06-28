import 'dart:async';

import 'package:assignemnt/cartService.dart';
import 'package:assignemnt/models/productModel.dart';
import 'package:assignemnt/services.dart';
import 'package:flutter/material.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel with ChangeNotifier {
  bool _isVieModelLoading = false;
  List<Product> _productList = [];
  List<bool> _likeList = [];
  bool _isProductLiked = false;
  int _currentCartListLength = 0;

  //GETTERS
  bool get isVieModelLoading => _isVieModelLoading;
  bool get isProductLiked => _isProductLiked;
  List<Product> get productList => _productList;
  List<bool> get likeList => _likeList;
  int get currentCartListLength => _currentCartListLength;

  init() {
    getProducts();
    getCurrentCartListLength();
  }

  addToCart(Product product) async {
    bool val = await CartService.addProductToCart(product: product);
    getCurrentCartListLength();

    notifyListeners();
  }

  getCurrentCartListLength() async {
    _currentCartListLength = 0;
    _currentCartListLength = await CartService.getCartListLength();

    notifyListeners();
  }

  getProducts() async {
    _productList.clear();
    _isVieModelLoading = true;
    notifyListeners();
    var response = await WebServices.getProducts();

    if (response.statusCode == 200 || response.statusCode == 201) {
      //GET call was sucessfull
      _productList = ProductFromJson(response.body);
      _productList.forEach((element) {
        _likeList.add(false);
      });
    } else {
      //GET call failed due to some reason, handleaccordingly
    }

    _isVieModelLoading = false;
    notifyListeners();
  }

  void likePressed(int index) {
    _likeList[index] = !_likeList[index];
    notifyListeners();
  }
}
