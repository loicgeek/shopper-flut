import 'dart:async';

import 'package:shopapp_flut/bloc_helpers/bloc_provider.dart';
import 'package:shopapp_flut/models/Product.dart';
import 'package:rxdart/rxdart.dart';

class ShoppingBloc implements BlocBase {
  // List of all items, part of the shopping basket
  Set<Product> _shoppingCart = Set<Product>();

  // List of all favorite items
  Set<Product> _favoriteItems = Set<Product>();


  // Stream to list of all possible items
  BehaviorSubject<List<Product>> _itemsController = BehaviorSubject<List<Product>>();
  Stream<List<Product>> get items => _itemsController;

  BehaviorSubject<int> _shoppingCartSizeController = BehaviorSubject<int>(seedValue:0);
  Stream<int> get shoppingBasketSize => _shoppingCartSizeController;

  BehaviorSubject<double> _shoppingCartPriceController = BehaviorSubject<double>(seedValue:0.0);
  Stream<double> get shoppingBasketTotalPrice => _shoppingCartPriceController;

  // Stream to list the items part of the shopping basket
  BehaviorSubject<List<Product>> _shoppingCartController = BehaviorSubject<List<Product>>(seedValue: <Product>[]);
  Stream<List<Product>> get shoppingCart=> _shoppingCartController;

    // Stream to list favorite items
  BehaviorSubject<List<Product>> _favoriteItemsController = BehaviorSubject<List<Product>>(seedValue: <Product>[] );
  Stream<List<Product>> get favoriteItems=> _favoriteItemsController;

  BehaviorSubject<int> _favorieItemsSizeController = BehaviorSubject<int>(seedValue:0);
  Stream<int> get favoriteItemsSize => _favorieItemsSizeController;


  @override
  void dispose() {
    _itemsController?.close();
    _shoppingCartSizeController?.close();
    _shoppingCartController?.close();
    _shoppingCartPriceController?.close();
    _favoriteItemsController?.close();
    _favorieItemsSizeController?.close();
  }

  // Constructor
  ShoppingBloc() {
    _loadProducts();
  }

/* Manage favorites items on shop  */
  void addToFavorites(Product item){
    _favoriteItems.add(item);
    _postActionOnFavorites();
  }

  void removeFromFavorites(Product item){
    _favoriteItems.remove(item);
    _postActionOnFavorites();
  }

  void  _postActionOnFavorites(){
    _favoriteItemsController.sink.add(_favoriteItems.toList());
    _favorieItemsSizeController.sink.add(_favoriteItems.length);
  }


/*Manage shopping cart */
  void addToShoppingBasket(Product item){
    _shoppingCart.add(item);
    _postActionOnCart();
  }


  void removeFromShoppingBasket(Product item){
    _shoppingCart.remove(item);
    _postActionOnCart();
  }

  void _postActionOnCart(){
    _shoppingCartController.sink.add(_shoppingCart.toList());
    _shoppingCartSizeController.sink.add(_shoppingCart.length);
    _computeShoppingBasketTotalPrice();
  }

  void _computeShoppingBasketTotalPrice(){
    double total = 0.0;

    _shoppingCart.forEach((Product item){
      total += item.price;
    });

    _shoppingCartPriceController.sink.add(total);
  }

  //
  // Generates a series of Shopping Items
  // Normally this should come from a call to the server
  // but for this sample, we simply simulate
  //
  void _loadProducts() {
    
    _itemsController.sink.add([
              new Product(id:1,name: 'P 1',price: 20,old_price: 10,picture: 'images/cats/fastfood.jpg'),
              new Product(id:2,name: 'P 2',price: 20,old_price: 10,picture: 'images/cats/fastfood.jpg'),
              new Product(id:3,name: 'P 3',price: 20,old_price: 10,picture: 'images/cats/fastfood.jpg'),
              new Product(id:4,name: 'P 4',price: 20,old_price: 10,picture: 'images/cats/fastfood.jpg')
            ].toList());
  }
}
