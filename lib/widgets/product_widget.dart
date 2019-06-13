import 'dart:async';

import 'package:shopapp_flut/bloc_helpers/bloc_provider.dart';
import 'package:shopapp_flut/blocs/shopping/shopping_bloc.dart';
import 'package:shopapp_flut/blocs/shopping/product_item_bloc.dart';
import 'package:shopapp_flut/models/Product.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  ProductWidget({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  StreamSubscription _subscription;
  StreamSubscription _fav_subscription;
  ProductItemBloc _bloc;
  ShoppingBloc _shoppingBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // As the context should not be used in the "initState()" method,
    // prefer using the "didChangeDependencies()" when you need
    // to refer to the context at initialization time
    _initBloc();
  }

  @override
  void didUpdateWidget(ProductWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // as Flutter might decide to reorganize the Widgets tree
    // it is preferable to recreate the links
    _disposeBloc();
    _initBloc();
  }

  @override
  void dispose() {
    _disposeBloc();
    super.dispose();
  }

  // This routine is reponsible for creating the links
  void _initBloc() {
    // Create an instance of the ShoppingItemBloc
    _bloc = ProductItemBloc(widget.product);

    // Retrieve the BLoC that handles the Shopping Basket content 
    _shoppingBloc = BlocProvider.of<ShoppingBloc>(context);

    // Simple pipe that transfers the content of the shopping
    // basket to the ShoppingItemBloc
    _subscription = _shoppingBloc.shoppingCart.listen(_bloc.shoppingCart);

      // Simple pipe that transfers the content of the fvorites
    // items to the ProductItemBloc
    _fav_subscription = _shoppingBloc.favoriteItems.listen(_bloc.favoriteItems);
  }

  void _disposeBloc() {
    _subscription?.cancel();
    _fav_subscription?.cancel();
    _bloc?.dispose();
  }

  Widget _buildButton() {
    return StreamBuilder<bool>(
      stream: _bloc.isInShoppingCart,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return snapshot.data
            ? _buildRemoveFromShoppingBasket()
            : _buildAddToShoppingBasket();
      },
    );
  }



  Widget _buildAddToShoppingBasket(){
    return InkWell(
      onTap: (){
        _shoppingBloc.addToShoppingBasket(widget.product);
      },
      child: Icon(Icons.add_circle_outline ,color: Colors.red),

    );

  }

  Widget _buildRemoveFromShoppingBasket(){
    return InkWell(
      onTap: (){
        _shoppingBloc.removeFromShoppingBasket(widget.product);
      },
      child: Icon(Icons.remove_circle_outline,color: Colors.red),

    );
  }

    Widget _buildFavoriteButton() {
    return StreamBuilder<bool>(
      stream: _bloc.isInFavorites,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        return snapshot.data
            ? _buildRemoveFromFavorite()
            : _buildAddToFavorite();
      },
    );
  }

    Widget _buildAddToFavorite(){
    return InkWell(
      onTap: (){
        _shoppingBloc.addToFavorites(widget.product);
      },
      child: Icon(Icons.favorite_border ,color: Colors.red),

    );

  }

  Widget _buildRemoveFromFavorite(){
    return InkWell(
      onTap: (){
        _shoppingBloc.removeFromFavorites(widget.product);
      },
      child: Icon(Icons.favorite,color: Colors.red),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: widget.product.name,
        child: Material(
          child:  GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading:_buildFavoriteButton(),// Text(widget.product.name,style: TextStyle(fontWeight: FontWeight.bold)),
                  trailing:_buildButton() ,
                  title: Text(widget.product.price.toString(),style: TextStyle(color:Colors.red,fontWeight: FontWeight.w800)),
                  subtitle: Text(widget.product.old_price.toString(),style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w800, decoration: TextDecoration.lineThrough)),
                ),
              ),
              child: Image.asset(
                widget.product.picture,
                fit: BoxFit.cover
              ),
            ),
          ),
        ),
    );
  }
}
