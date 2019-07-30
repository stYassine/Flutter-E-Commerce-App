import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../models/app_state.dart';
import '../models/user.dart';
import '../models/product.dart';
import '../widgets/product_item.dart';
import '../store/actions.dart';
import 'package:badges/badges.dart';

class ProductsPage extends StatefulWidget{

  final void Function() onInit;

  ProductsPage({this.onInit});

  @override
    State<StatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>{

    final _appBar =PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: StoreConnector<AppState, AppState>(
         converter: (store) => store.state,
         builder: (_, state){
          return AppBar(
            centerTitle: true,
            title: SizedBox(
              child: state.user != null
              ? Text(state.user.username)
              : FlatButton(
                child: Text('Register Here'),
                onPressed: () => Navigator.pushNamed(_, '/register'),
              )
            ),
            leading: state.user != null
            ? BadgeIconButton(
              icon: Icon(Icons.store),
              badgeColor: Colors.lime,
              badgeTextColor: Colors.black,
              itemCount: state.cartProductsList.length,
              onPressed: () => Navigator.pushNamed(_, '/cart'),
            )
            : Text(''),
            actions:[
              Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: state.user != null
                ? IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () => StoreProvider.of<AppState>(_).dispatch(logoutUser)
                )
                : Text(''),
              )
            ],
          );
         },
      )
    );

    final _gradientBackground =BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomCenter,
        stops: [0.1, 0.3, 0.5, 0.7, 0.9],
        colors: [
          Colors.deepOrange[100],
          Colors.deepOrange[200],
          Colors.deepOrange[300],
          Colors.deepOrange[400],
          Colors.deepOrange[500]
        ]
      )
    );

    Widget build(BuildContext context){
      final orientation =MediaQuery.of(context).orientation;
      return Scaffold(
        appBar: _appBar,
        body: Container(
          decoration: _gradientBackground,
          child: StoreConnector<AppState, AppState>(
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
                        itemCount: state.productsList.length,
                        itemBuilder: (context, i) => ProductItem(state.productsList[i]),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      );
    }

}