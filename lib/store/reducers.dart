import '../models/app_state.dart';
import '../models/user.dart';
import '../models/product.dart';
import './actions.dart';

AppState appReducer(AppState state, dynamic action){
  return AppState(
    user: userReducer(state.user, action),
    productsList: productsReducer(state.productsList, action),
    cartProductsList: cartProductsReducer(state.cartProductsList, action)
  );
}

User userReducer(User user, dynamic action){
  if(action is GetUser){
    return action.user;
  }else if(action is LogoutUser){
    print('LOGOUT REDUCER');
    return action.user;
  }
  return user;
}

List<Product> productsReducer(List<Product> productsList, dynamic action){
  if(action is GetProducts){
    return action.productsList;
  }
  return productsList;
}

List<Product> cartProductsReducer(List<Product> cartProductsList, dynamic action){
  if(action is ToggleCartProduct){
    return action.cartProducts;
  }
  return cartProductsList;
}