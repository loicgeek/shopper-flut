
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:shopapp_flut/bloc_helpers/bloc_provider.dart';
import 'package:shopapp_flut/blocs/shopping/shopping_bloc.dart';
import 'package:shopapp_flut/widgets/app_drawer.dart';
import 'package:shopapp_flut/widgets/horizontal_categories_list.dart';
import 'package:shopapp_flut/models/Product.dart';
import 'package:shopapp_flut/pages/shopping_cart_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
   Widget image_carousel = new Container(
     height: 200.0,
     child: new Carousel(
       boxFit: BoxFit.cover,
       images: [
         AssetImage('images/dadjushow.jpg'),   
         AssetImage('images/mahima1.jpg'),
         AssetImage('images/bank_cover.jpg'),
         AssetImage('images/stadeOmnisportYde.jpg'),
       ],
       autoplay: false,
       animationDuration: Duration(milliseconds: 1000),
       animationCurve: Curves.easeInOutQuint,
       showIndicator: true,
       indicatorBgPadding: 5.0,
       dotSize: 2.0,
     ),
   );
    return  Scaffold(
          appBar: AppBar(
            title: Text('Shop App',style: TextStyle(fontFamily:"monserrat",fontStyle: FontStyle.italic),),
            backgroundColor: Colors.red,
            elevation: 0.1,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search),onPressed: (){},),
              ShoppingCartButton()
              
            ],
          ),
          drawer: AppDrawer(),
          body: Column(
            children: <Widget>[
              // carousel for ads in homescreen
              image_carousel,

              Padding(padding: const EdgeInsets.all(5.0), child: Text('Categories')),

              //my horizontal categories list
              HorizontalCatList(),

              Padding(padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0), child: Text('Recent Products')),

            // recent Products
              ProductsWidget()
            ],  
          ), 
    );
  }
}

class ShoppingCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShoppingBloc bloc = BlocProvider.of<ShoppingBloc>(context);
    return Container(
      width: 48.0,
      height: 48.0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) =>ShoppingCartPage() ,
              fullscreenDialog: true,
            ),
          );
        },
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Center(
              child: const Icon(Icons.shopping_cart),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Transform.translate(
                  offset: Offset(0.0, -5.0),
                  child: StreamBuilder<int>(
                    stream: bloc.shoppingBasketSize,
                    initialData: 0,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      return Container(
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            '${snapshot.data}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
