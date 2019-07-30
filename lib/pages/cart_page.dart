import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../models/app_state.dart';
import '../widgets/product_item.dart';

class CartPage extends StatefulWidget{

  @override
    State<StatefulWidget> createState() => _CartPageState();

}

class _CartPageState extends State<CartPage>{

  Widget _cartTab(){
    
    final orientation =MediaQuery.of(context).orientation;

    return StoreConnector<AppState, AppState>(
      converter: (store) => store.state,
      builder: (_, state){
        return Column(
          children: <Widget>[
            Expanded(
              child: SafeArea(
                top: false,
                bottom: false,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait
                    ? 2
                    : 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0
                  ),
                  itemCount: state.cartProductsList.length,
                  itemBuilder: (context, i) => ProductItem(state.cartProductsList[i]),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget _cardsTab(){
    return Center(
      child: Text('User Cards Here', style: Theme.of(context).textTheme.body1),
    );
  }

  Widget _ordersTab(){
  return Center(
      child: Text('User Orders Here', style: Theme.of(context).textTheme.body1),
    );
  }


  Widget build(BuildContext context){
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
            appBar: AppBar(
              title: Text('Cart'),
              bottom: TabBar(
                tabs: <Widget>[
                  Tab(icon: Icon(Icons.shopping_cart)),
                  Tab(icon: Icon(Icons.credit_card)),
                  Tab(icon: Icon(Icons.receipt))
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                _cartTab(),
                _cardsTab(),
                _ordersTab()
              ],
            ),
      ),
    );
  }

}