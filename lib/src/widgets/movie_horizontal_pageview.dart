import 'package:flutter/material.dart';
import 'package:yo_movies/src/models/movie_model.dart';

class MovieHorizontalPageView extends StatelessWidget {    

  final List<Movie> movies;
  final Function nextPage;
  MovieHorizontalPageView({@required this.movies, @required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        this.nextPage();
      };
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(     
        controller: _pageController,   
        // children: _getMovies(context)
        itemCount: movies.length,
        itemBuilder: (BuildContext context, index) {
          return getMovie(context, movies[index]);
        },
      ),
    );
  }

  Widget getMovie(BuildContext context, Movie movie) {
    return Column(
        children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 5.0),              
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                image: NetworkImage(movie.getPoster()),
                placeholder: AssetImage('lib/assets/img/loading.gif'),
                fit: BoxFit.cover,            
                height: 140.0,
              ),
            ),
          ),
          SizedBox(height: 5.0,),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      );
  }
}