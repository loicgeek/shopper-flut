import 'package:flutter/material.dart';
import 'package:shopapp_flut/bloc_helpers/bloc_provider.dart';
import 'package:shopapp_flut/blocs/shopping/shopping_bloc.dart';
import 'package:shopapp_flut/models/Product.dart';
import 'package:shopapp_flut/widgets/product_widget.dart';


class ShoppingCartPage extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
    ShoppingBloc shoppingBloc = BlocProvider.of<ShoppingBloc>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:  StreamBuilder<int>(
              stream: shoppingBloc.shoppingBasketSize,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot){
                return Text("Shopping Cart ${snapshot.data}");
              },
              ),
        ),
        body: Container(
          child: StreamBuilder<List<Product>>(
          stream: shoppingBloc.shoppingCart,
          builder: (BuildContext context,
              AsyncSnapshot<List<Product>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.0,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductWidget(product: snapshot.data[index]);
              },
            );
          },
        ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: StreamBuilder(
            stream: shoppingBloc.shoppingBasketTotalPrice,
            builder: (BuildContext context , AsyncSnapshot<double> snapshot){
              return Text("${snapshot.data}");
            },
          ),
        ),
      ),
    );
  }
}