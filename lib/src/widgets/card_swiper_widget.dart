import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yo_movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {  
  final List<Movie> movies;  

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return  Container(
      padding: EdgeInsets.only(top: 15.0),
      child: Swiper(            
        itemBuilder: (BuildContext context,int index){          
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
                image: NetworkImage(movies[index].getPoster()),
                placeholder: AssetImage('lib/assets/img/loading.gif'),
                fit: BoxFit.cover,
              )
          );
        },
        itemCount: movies.length,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}