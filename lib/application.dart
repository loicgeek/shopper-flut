import 'package:shopapp_flut/bloc_helpers/bloc_provider.dart';
import 'package:shopapp_flut/pages/decision_page.dart';
import 'package:shopapp_flut/pages/favorites_page.dart';
import 'package:shopapp_flut/pages/home_page.dart';
import 'package:shopapp_flut/pages/shopping_cart_page.dart';
import 'package:flutter/material.dart';

import 'blocs/authentication/authentication_bloc.dart';
import 'blocs/shopping/shopping_bloc.dart';


class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
            bloc: AuthenticationBloc(),
            child: BlocProvider<ShoppingBloc>(
              bloc: ShoppingBloc(),
              child: MaterialApp(
                title: 'BLOC Shopping App',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                routes: {
                  '/shoppingCart': (BuildContext context) => ShoppingCartPage(),
                  '/favorites': (BuildContext context) => FavoritesPage(),
                  '/decision': (BuildContext context) => DecisionPage(),
                },
                home:HomePage() //DecisionPage(),
              ),
            ),
    );
  }
}