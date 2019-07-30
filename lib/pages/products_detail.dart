import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductsDetail extends StatelessWidget{
  
  final Product product;

  ProductsDetail(this.product);

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
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        decoration: _gradientBackground,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Image.network(product.image, fit: BoxFit.cover,
                width: orientation == Orientation.portrait ? 600 : 250,
                height: orientation == Orientation.portrait ? 400 : 200,
              ),
            ),
            Text(product.title, style: Theme.of(context).textTheme.title),
            Text('\$${product.price}', style: Theme.of(context).textTheme.body1),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 32.0,),
                  child: Text(product.description, style: Theme.of(context).textTheme.body1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}