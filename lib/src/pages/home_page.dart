import 'package:flutter/material.dart';
import 'package:yo_movies/src/providers/movie_provider.dart';
import 'package:yo_movies/src/widgets/card_swiper_widget.dart';
import 'package:yo_movies/src/widgets/movie_horizontal_pageview.dart';
 
class HomePage extends StatelessWidget {

  final _movieProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {

    _movieProvider.getPopularMovies();

    return Scaffold(
      appBar: AppBar(
        title: Text('YoMovies'),
        backgroundColor: Colors.indigoAccent,            
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){}),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _getSwiper(),                     
          _footer(context)
        ]
      )
    );    
  }

  _getSwiper() {            
    return StreamBuilder(
      stream: _movieProvider.popularStream,
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

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 5.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subtitle,),
          _getPopular()
        ],
      ),
    );
  }

  _getPopular() {
    return StreamBuilder(
      stream: _movieProvider.popularStream,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData){          
          return MovieHorizontalPageView(
            movies: snapshot.data,
            nextPage: _movieProvider.getPopularMovies
          );          
        }else{
          return Container(
            height: 350,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }


}