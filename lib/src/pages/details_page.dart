import 'package:flutter/material.dart';
import 'package:yo_movies/src/models/actor_model.dart';
import 'package:yo_movies/src/models/movie_model.dart';
import 'package:yo_movies/src/providers/movie_provider.dart';

class DetailsPage extends StatelessWidget {  

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    print(movie.uniqueId);

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _getAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _getMoviePoster(movie, context),
                SizedBox(height: 5.0,),
                _getMovieDescription(movie),
                _getMovieDescription(movie),
                _getMovieDescription(movie),
                _getMovieDescription(movie),
                _setCasting(movie)
              ]
            ),
          )
        ],
      ),
    );
  }

  Widget _getAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      floating: false,
      pinned: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(movie.title, style: TextStyle(fontSize: 16, color: Colors.white), overflow: TextOverflow.ellipsis,),
        background: FadeInImage(
          placeholder: AssetImage('lib/assets/img/loading.gif'), 
          image: NetworkImage(movie.getBackDrop()), 
          fit: BoxFit.cover,
          fadeInDuration: Duration(milliseconds: 150),),
        centerTitle: true,
      ),
    );
  }

  Widget _getMoviePoster(Movie movie, BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(image: NetworkImage(movie.getPoster()), height: 150,)
            ),
          ),       
          SizedBox(width: 5,),
          Flexible(            
            child: Column(
              children: <Widget>[
                Text(movie.title, style: Theme.of(context).textTheme.title,),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subhead,),
                Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subhead,),
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _getMovieDescription(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Text(movie.overview, textAlign: TextAlign.justify,),
    );
  }

  Widget _setCasting ( Movie movie ) {

    final movieProvider = new MovieProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),      
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActorsPageView( snapshot.data );
        }else {
          return Center(child: CircularProgressIndicator());
        }
      });
  }
          
  Widget _createActorsPageView(List<Actor> actors) {

    return SizedBox(
      height: 200.0, 
      child: PageView.builder(     
        pageSnapping: false,   
        itemCount: actors.length,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
        itemBuilder: (context, i) {
          return _actorCard(actors[i]);
        },
      ),
    );
  }

  Widget _actorCard (Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPhoto()),
              placeholder: AssetImage('lib/assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}