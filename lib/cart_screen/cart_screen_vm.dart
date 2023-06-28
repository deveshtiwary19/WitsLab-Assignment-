import 'package:assignemnt/cartService.dart';
import 'package:assignemnt/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartScreenViewModel with ChangeNotifier {
  bool _isLoading = false;
  List<Cart> _cartList = [];
  double _total = 0.0;
  double _shippingCharge = 30.0;
  double _subTotal = 0.0;
  bool _isAnyItemSelected = false;

  //Getters
  bool get isLoading => _isLoading;
  List<Cart> get cartList => _cartList;
  double get total => _total;
  double get shipingCharge => _shippingCharge;
  double get subTotal => _subTotal;
  bool get isAnyItemSelected => _isAnyItemSelected;

  init() {
    getCartList();
  }

  getCartList() async {
    _isLoading = true;
    notifyListeners();
    _cartList = [];
    _isAnyItemSelected = false;
    _cartList = await CartService.getCurrentCartList();
    //Calculating the total, subtotal
    _total = 0.0;
    for (int i = 0; i < _cartList.length; i++) {
      double amount = _cartList[i].price * _cartList[i].qty;
      _total = _total + amount;
      //Check for item selection here only, as this loop williterate for sure everytime as it is meant to calculate the total
      if (_cartList[i].selected) _isAnyItemSelected = true;
    }
    _subTotal = _total + _shippingCharge;

    _isLoading = false;
    notifyListeners();
  }

  decreaseCartQTY(int index) async {
    _isLoading = true;
    notifyListeners();
    await CartService.decreaseCountQty(index);
    getCartList();
  }

  increaseCartQTY(int index) async {
    _isLoading = true;
    notifyListeners();
    await CartService.increaseCountQty(index);
    getCartList();
  }

  removeSelected() async {
    _isLoading = true;
    notifyListeners();
    await CartService.removeAllSelectedItems();
    getCartList();
  }

  changeSelectValue(int index) async {
    _isLoading = true;
    notifyListeners();
    await CartService.selectValueChanged(index);
    getCartList();
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
