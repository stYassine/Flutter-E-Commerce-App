import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import './models/app_state.dart';
import './store/reducers.dart';

// pages
import './pages/login.dart';
import './pages/register.dart';
import './pages/products.dart';
import './pages/products_detail.dart';
import './pages/cart_page.dart';


void main(){
  
  final store =Store<AppState>(appReducer, initialState: AppState.initial());

  runApp(
    StoreProvider(
      store: store,
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan,
        accentColor: Colors.deepOrange[400],
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0),
          body1: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic)
        )
      ),
      routes: {
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegisterPage(),
        '/products': (BuildContext context) => ProductsPage(),
        '/cart': (BuildContext context) => CartPage(),
      },
      home: ProductsPage(),
    ),
    )
  );
}

class MyApp extends StatefulWidget{
  @override
    State<StatefulWidget> createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Home App'),
      ),
      body: Container(
        child: Center(
          child: Text('Home App'),
        ),
      ),
    );
  }
}