import '../models/app_state.dart';
import '../models/user.dart';
import '../models/product.dart';

import 'dart:convert';
import 'dart:async';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

ThunkAction<AppState> getUser =(Store<AppState> store) async {
  final prefs =await SharedPreferences.getInstance();
  String storedUser =prefs.getString('user');
  User user =jsonDecode(storedUser);
  store.dispatch(GetUser(user));
};

ThunkAction<AppState> logoutUser=(Store<AppState> store) async {
  print('logoutUser DISPATCHED');
  final prefs =await SharedPreferences.getInstance();
  await prefs.remove('user');
  User user;
  store.dispatch(LogoutUser(user));
};

ThunkAction<AppState> getProducts =(Store<AppState> store) async {
  http.Response response =await http.get('');
  List<Product> productsList =jsonDecode(response.body);
  List<Product> products =[];
  productsList.forEach((productData){
    final Product product =Product.fromJson(productData);
    products.add(product);
  });
  store.dispatch(GetCartProducts(productsList));
};

ThunkAction<AppState> toggleCartProduct(Store<AppState> store, Product cartProduct) {
    
    final List<Product> cartProducts =store.state.cartProductsList;
    final int index =cartProducts.indexWhere((product) => product.id == cartProduct.id);
    bool isInCart =index > -1 == true;
    
    final List<Product> updatedCartProducts =List.from(cartProducts);
    
    if(isInCart){
      updatedCartProducts.remove(cartProduct);
    }else{
      updatedCartProducts.add(cartProduct);
    }

    store.dispatch(ToggleCartProduct(updatedCartProducts));
  
}

class GetUser{
  final User _user;

  User get user => this._user;

  GetUser(this._user);
}

class LogoutUser{
  final User _user;

  User get user => this._user;

  LogoutUser(this._user);
}

class GetProducts{
  final List<Product> _productsList;
  List<Product> get productsList => this._productsList;
  GetProducts(this._productsList);
}

class GetCartProducts{
  final List<Product> _cartProductsList;
  List<Product> get cartProductsList => this._cartProductsList;
  GetCartProducts(this._cartProductsList);
}

class ToggleCartProduct{

  final List<Product> _cartProducts;

  List<Product> get cartProducts => this._cartProducts;

  ToggleCartProduct(this._cartProducts);

}