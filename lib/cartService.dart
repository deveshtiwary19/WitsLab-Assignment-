import 'dart:developer';

import 'package:assignemnt/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/productModel.dart';

final String LOCAL_CART_KEY = "CART_LOCAL_LIST";

class CartService {
  static Future<bool> addProductToCart({required Product product}) async {
    List<Cart> _currentCartList = [];
    int qtyValueToAdd = 1;
    //Getting current avilablke cart list
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //Here we need to fetch the already existing list
    _currentCartList = await getCurrentCartList();

    //Checking if item already exisits, then we will juat increase the count
    for (int i = 0; i < _currentCartList.length; i++) {
      if (_currentCartList[i].id == product.id) {
        //Product already exists
        int currentQty = _currentCartList[i].qty;
        _currentCartList.removeAt(i);
        qtyValueToAdd = currentQty + 1;
      }
    }
    Cart cart = Cart(
        id: product.id,
        price: product.price,
        title: product.title,
        selected: false,
        qty: qtyValueToAdd,
        image: product.image);

    _currentCartList.add(cart);

    try {
      prefs.setString(LOCAL_CART_KEY, CartToJson(_currentCartList));
      printCart();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Cart>> getCurrentCartList() async {
    List<Cart> _currentCartList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = await prefs.getString(LOCAL_CART_KEY) ?? "";
    if (value != "") {
      _currentCartList = CartFromJson(value);
    }

    //Sorting the lis in order with IDS whenever requested
    if (_currentCartList.isNotEmpty)
      _currentCartList.sort((a, b) => a.id.compareTo(b.id));

    return _currentCartList;
  }

//Following is a debugging method just to print the cart
  static printCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = await prefs.getString(LOCAL_CART_KEY) ?? "";
    if (value != "") {
      List<Cart> _cartList = CartFromJson(value);
      print(_cartList.length);
      print(_cartList);
    } else
      print("Cant print cart. Locally null value was found");
  }

  static Future<int> getCartListLength() async {
    int listCount = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = await prefs.getString(LOCAL_CART_KEY) ?? "";
    if (value != "") {
      List<Cart> _cartList = CartFromJson(value);
      listCount = _cartList.length;
    } else {
      print("Cant print cart. Locally null value was found");
    }

    return listCount;
  }

  static Future<bool> decreaseCountQty(int index) async {
    List<Cart> _currentCartList = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentCartList = await getCurrentCartList();

    //Remove element if item is already one
    int qty = _currentCartList[index].qty;

    if (qty == 1) {
      _currentCartList.removeAt(index);
      prefs.setString(LOCAL_CART_KEY, CartToJson(_currentCartList));
      return true;
    } else {
      Cart current = _currentCartList[index];
      Cart toAdd = Cart(
          id: current.id,
          price: current.price,
          title: current.title,
          selected: current.selected,
          qty: qty - 1,
          image: current.image);

      _currentCartList.removeAt(index);

      _currentCartList.add(toAdd);
      prefs.setString(LOCAL_CART_KEY, CartToJson(_currentCartList));
    }

    return true;
  }

  static Future<bool> increaseCountQty(int index) async {
    List<Cart> _currentCartList = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentCartList = await getCurrentCartList();

    Cart current = _currentCartList[index];
    Cart toAdd = Cart(
        id: current.id,
        price: current.price,
        title: current.title,
        selected: current.selected,
        qty: current.qty + 1,
        image: current.image);

    _currentCartList.removeAt(index);

    _currentCartList.add(toAdd);
    prefs.setString(LOCAL_CART_KEY, CartToJson(_currentCartList));

    return true;
  }

  static Future<bool> selectValueChanged(int index) async {
    List<Cart> _currentCartList = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentCartList = await getCurrentCartList();

    Cart current = _currentCartList[index];
    Cart toAdd = Cart(
        id: current.id,
        price: current.price,
        title: current.title,
        selected: !(current.selected), //Chnaging to opposite of current value
        qty: current.qty,
        image: current.image);

    _currentCartList.removeAt(index);

    _currentCartList.add(toAdd);
    prefs.setString(LOCAL_CART_KEY, CartToJson(_currentCartList));

    return true;
  }

  static Future<bool> removeAllSelectedItems() async {
    List<Cart> _currentCartList = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentCartList = await getCurrentCartList();

    for (int i = 0; i < _currentCartList.length; i++) {
      if (_currentCartList[i].selected) {
        _currentCartList.removeAt(i);
      }
    }

    //Setting the list back to shared pref
    prefs.setString(LOCAL_CART_KEY, CartToJson(_currentCartList));
    return true;
  }
}
