import 'package:assignemnt/models/productModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../cartService.dart';

class ProductDetailViewMoidel with ChangeNotifier {
  late Product _product;

  //getters
  Product get product => _product;

  init(Product product) {
    _product = product;
    //Need transparent status bar for this screen
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  addToCart(Product product) async {
    bool val = await CartService.addProductToCart(product: product);
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    super.dispose();
  }
}
