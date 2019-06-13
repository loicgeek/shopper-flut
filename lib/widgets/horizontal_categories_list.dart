import 'package:flutter/material.dart';
import 'package:shopapp_flut/models/Category.dart';

class HorizontalCatList extends StatefulWidget {
  @override
  _HorizontalCatListState createState() => _HorizontalCatListState();
}

class _HorizontalCatListState extends State<HorizontalCatList> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CategoryWidget(category: new Category(image_location: 'images/mahima1.jpg',image_caption: 'Fast Foot')),
          CategoryWidget(category: new Category(image_location: 'images/mahima1.jpg',image_caption: 'Fast Foot')),
          CategoryWidget(category: new Category(image_location: 'images/mahima1.jpg',image_caption: 'Fast Foot')),
          CategoryWidget(category: new Category(image_location: 'images/cats/pizza.jpg',image_caption: 'Fast Foot')),
        ],
      ),
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final Category category ;
  CategoryWidget({
    this.category
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width:100.0,
      height: 100.0,
      child: InkWell(
        onTap: (){},
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(2.0, 0.0, 2.0, 0.0),
          title: Image.asset(category.image_location,width: 100.0,height:80.0,fit: BoxFit.contain,),
          subtitle: Container(
            alignment: Alignment.topCenter,
            child: Text(category.image_caption),
          ),
        ),
      ),
  
    );
  }
}