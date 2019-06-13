import 'package:shopapp_flut/bloc_helpers/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shopapp_flut/models/Product.dart';

class ProductItemBloc extends BlocBase{

  // Stream to notify if the ProductItemWidget is part of the shopping basket
  BehaviorSubject<bool> _isInShoppingCartController = BehaviorSubject<bool>();
  Stream<bool> get isInShoppingCart=> _isInShoppingCartController;

    // Stream that receives the list of all items, part of the shopping basket
  PublishSubject<List<Product>> _shoppingCartController = PublishSubject<List<Product>>();
  Function(List<Product>) get shoppingCart=> _shoppingCartController.sink.add;

      // Stream to notify if the ProductItemWidget is part of the favorites items
  BehaviorSubject<bool> _isInFavoritesController = BehaviorSubject<bool>();
  Stream<bool> get isInFavorites=> _isInFavoritesController;

      // Stream that receives the list of favorite items
  PublishSubject<List<Product>> _favoriteItemsController = PublishSubject<List<Product>>();
  Function(List<Product>) get favoriteItems=> _favoriteItemsController.sink.add;

  // Constructor with the 'identity' of the product
  ProductItemBloc(Product product){
    // Each time a variation of the content of the shopping cart
    _shoppingCartController.stream
                          // we check if this product is part of the shopping basket
                           .map( (list){return list.any((Product item)=>item.id==product.id);} )
                          // if it is part
                          .listen((isInShoppingCart)
                              // we notify the ProductWidget 
                            => _isInShoppingCartController.add(isInShoppingCart));

     // Each time a variation of the content of favorites items
    _favoriteItemsController.stream
                            .map( (list){return list.any((Product item)=>item.id==product.id);} )
                            .listen((isInFavorites)
                            =>_isInFavoritesController.add(isInFavorites));
  }

  @override
  void dispose() {
    _isInShoppingCartController?.close();
    _shoppingCartController?.close();
    _favoriteItemsController?.close();
    _isInFavoritesController?.close();
  }

}