import 'package:flutter/material.dart';
import 'package:shopapp_flut/blocs/authentication/authentication_bloc.dart';
import 'package:shopapp_flut/blocs/authentication/authentication_event.dart';
import 'package:shopapp_flut/blocs/shopping/shopping_bloc.dart';
import 'package:shopapp_flut/bloc_helpers/bloc_provider.dart';
import 'package:shopapp_flut/pages/decision_page.dart';
import 'package:shopapp_flut/pages/favorites_page.dart';
import 'package:shopapp_flut/pages/login_page.dart';

class AppDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    ShoppingBloc shoppingBloc = BlocProvider.of<ShoppingBloc>(context);
    AuthenticationBloc authBloc = BlocProvider.of<AuthenticationBloc>(context);
    
    return Drawer(
        child: ListView(
          children: <Widget>[
            //=========HEADER=============
            UserAccountsDrawerHeader(
              accountEmail: Text('loicngou@gmail.com'),
              accountName: Text('Loic Ngou'),
              currentAccountPicture: GestureDetector(
                child:CircleAvatar(
                  backgroundColor: Colors.redAccent, 
                  backgroundImage: AssetImage('images/profil.jpg'),             
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            //======BODY========================
            InkWell(
              onTap: (){
                Navigator.of(context).pop(context);
              },
              child: ListTile(
                leading: Icon(Icons.home,color: Colors.red,),
                title: Text('Home'),
              ),
            ),           
            Divider(color: Colors.black12,),
            //
            InkWell(
              onTap: (){},
              child: ListTile(
                leading: Icon(Icons.person_outline,color: Colors.red,),
                title: Text('My Account'),
              ),
            ),           
            Divider(color: Colors.black12,),
            //
            InkWell(
              onTap: (){},
              child: ListTile(
                leading: Icon(Icons.shopping_basket,color: Colors.red,),
                title: Text('My Orders'),
              ),
            ),           
            Divider(color: Colors.black12,),
            //
            InkWell(
              onTap: (){},
              child: ListTile(
                leading: Icon(Icons.category,color: Colors.red,),
                title: Text('Categories'),
              ),
            ),           
            Divider(),
            //
            InkWell(
              onTap: (){
                Navigator.of(context).pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>FavoritesPage(),
                ));
              },
              child: ListTile(
                leading: Icon(Icons.favorite,color: Colors.red,),
                title: Text('favourites'),
                trailing: StreamBuilder(
                  stream: shoppingBloc.favoriteItemsSize,
                  builder: (BuildContext context , AsyncSnapshot<int> snapshot){
                    return Text("${snapshot.data}");
                  },
                ),
              ),
            ),           
            Divider(indent: 2,),
            //
            InkWell(
              onTap: (){},
              child: ListTile(
                leading: Icon(Icons.settings,color: Colors.grey,),
                title: Text('Settings'),
              ),
            ),           
            Divider(color: Colors.black12,),
            //
            InkWell(
              onTap: (){},
              child: ListTile(
                leading: Icon(Icons.help,color: Colors.blue,),
                title: Text('About'),
              ),
            ),  

             Divider(color: Colors.black12,),
            //
            InkWell(
              onTap: (){
                authBloc.emitEvent(AuthenticationEventLogout());
                //Navigator.of(context).pushReplacementNamed('/decision');
              },
              child: ListTile(
                leading: Icon(Icons.exit_to_app,color: Colors.blue,),
                title: Text('Logout'),
              ),
            ),      

          ],
        ),
      );
  }
}