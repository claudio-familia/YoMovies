import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('YoMovies'),
            backgroundColor: Colors.indigoAccent,            
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: (){}),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: 300.0,
            padding: EdgeInsets.only(top: 5.0),
            child: Swiper(            
              itemBuilder: (BuildContext context,int index){
                return new Image.network("http://via.placeholder.com/300x150",fit: BoxFit.fill,);
              },
              itemCount: 3,
              itemWidth: 200.0,
              layout: SwiperLayout.STACK,
              // pagination: new SwiperPagination(),
              // control: new SwiperControl(),
            ),
          ),
        );    
  }
}