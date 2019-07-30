import 'package:meta/meta.dart';
import './user.dart';
import './product.dart';

class AppState{

  final User user;
  final List<Product> productsList;
  final List<Product> cartProductsList;

  AppState({
    @required this.user,
    @required this.productsList,
    @required this.cartProductsList
  });

  factory AppState.initial(){
    return AppState(
      user: User(id: '1', username: 'Yassine Msiah', email: 'yassine.msiah@gmail.com', jwt: 'qsdkqsjd'),
      productsList: [
        new Product(id: '1', price: 19.50, title: 'Title 1', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400'),
        new Product(id: '2', price: 9.50, title: 'Title 2', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400'),
        new Product(id: '3', price: 29.50, title: 'Title 3', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400'),
        new Product(id: '4', price: 39.50, title: 'Title 4', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400'),
        new Product(id: '5', price: 49.50, title: 'Title 5', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400'),
        new Product(id: '6', price: 59.50, title: 'Title 6', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400'),
        new Product(id: '7', price: 69.50, title: 'Title 7', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400'),
        new Product(id: '8', price: 79.50, title: 'Title 8', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400'),
        new Product(id: '9', price: 89.50, title: 'Title 9', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400'),
        new Product(id: '10', price: 99.99, title: 'Title 10', description: 'Lorem Lipsum Loooong Descrpition', image: 'https://via.placeholder.com/400')
      ],
      cartProductsList: []
    );
  }

}