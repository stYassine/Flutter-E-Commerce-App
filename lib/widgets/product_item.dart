import 'package:flutter/material.dart';
import '../models/app_state.dart';
import '../models/product.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../pages/products_detail.dart';
import '../store/actions.dart';

class ProductItem extends StatelessWidget{

    final Product product;

    ProductItem(this.product);

    bool _isInCart(AppState state, String id){
      final List<Product> cartProducts =state.cartProductsList;
      return cartProducts.indexWhere((product) => product.id == id) > -1;
    }

    Widget build(BuildContext context){
      return InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ProductsDetail(product);
            }
          )
        ),
        child: GridTile(
          footer: GridTileBar(
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(product.title, style: TextStyle(fontSize: 20.0)),
            ),
            subtitle: Text('\$${product.price}', style: TextStyle(fontSize: 16.0)),
            backgroundColor: Color(0xBB000000),
            trailing: StoreConnector<AppState, AppState>(
              converter: (store) => store.state,
              builder: (_, state){
                return state.user != null
                ? IconButton(
                  icon: Icon(Icons.shopping_cart, 
                  color:_isInCart(state, product.id)
                  ? Colors.cyan[700]
                  : Colors.white
                  ),
                  onPressed: () {
                    final store = StoreProvider.of<AppState>(context);
                    store.dispatch(toggleCartProduct(store, product));
                  }
                )
                : Text('');
              },
            ),
          ),
          child: Image.network(product.image, fit: BoxFit.contain),
        ),
      );
    } 


}