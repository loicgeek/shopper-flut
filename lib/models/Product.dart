import 'package:flutter/material.dart';
import 'package:shopapp_flut/bloc_helpers/bloc_provider.dart';
import 'package:shopapp_flut/blocs/shopping/shopping_bloc.dart';
import 'package:shopapp_flut/widgets/product_widget.dart';

class Product extends Object{
  int id;
  String name;
  String picture;
  String description;
  double price;
  int old_price;
  bool is_favorite=false;

  Product({
    this.id,
    this.name,
    this.picture,
    this.description,
    this.price,
    this.old_price
  });

    @override
  bool operator==(Object other) => identical(this, other) || this.hashCode == other.hashCode;

  @override
  int get hashCode => id;
}


class ProductsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);
    return Expanded(
      child:StreamBuilder<List<Product>>(
          stream: bloc.items,
          builder: (BuildContext context,
              AsyncSnapshot<List<Product>> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductWidget(
                  product: snapshot.data[index],
                );
              },
            );
          },
        )
    );
  }
}

