import 'package:flutter/material.dart';
import 'package:yo_movies/src/providers/movie_provider.dart';
import 'package:yo_movies/src/widgets/card_swiper_widget.dart';
 
class HomePage extends StatelessWidget {

  final _movieProvider = new MovieProvider();

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
          body: Column(
            children: <Widget>[
              _getSwiper()
            ]
          )
        );    
  }

  _getSwiper() {            
    return FutureBuilder(
      future: _movieProvider.getNowPlaying(),
      //initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return CardSwiper(movies: snapshot.data,);
        }else{
          return Container(
            height: 350,
            child: Center(
              child: CircularProgressIndicator(),
            )
          );
        }
      },
    );
  }
}