import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class CustomCarousel extends StatefulWidget {
  var images;
  var height;

  CustomCarousel({
    this.images,
    this.height
  });
  @override
  _CustomCarouselState createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
     height: widget.height,
     child: new Carousel(
       boxFit: BoxFit.cover,
       images: widget.images,
       autoplay: false,
       animationDuration: Duration(milliseconds: 1000),
       animationCurve: Curves.easeInOutQuint,
       showIndicator: true,
       indicatorBgPadding: 5.0,
       dotSize: 3.0,
     ),
   );
  }
}