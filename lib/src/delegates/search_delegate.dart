import 'package:flutter/material.dart';
import 'package:yo_movies/src/models/movie_model.dart';
import 'package:yo_movies/src/providers/movie_provider.dart';

class DataSearch extends SearchDelegate {
  
  final movieProvider = new MovieProvider();

  @override
  List<Widget> buildActions(BuildContext context) {    
    // ALl actions in the appbar
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }  

  @override
  Widget buildLeading(BuildContext context) {
    // Icon to the left in the appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,  
          progress: transitionAnimation,        
        ),
        onPressed: () {
          close(context, null);
        },
    ); 
  }

  @override
  Widget buildResults(BuildContext context) {
    // Create the results to show
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Search suggestion that appears while writting

    if( query.isEmpty ) return Container();

    return FutureBuilder(
      future: movieProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if( snapshot.hasData ) {
          final movies = snapshot.data;
          return ListView(
            children: movies.map((item) {
              return ListTile(
                title: Text(item.title),
                leading: FadeInImage(placeholder: AssetImage('lib/assets/img/no-image.jpg'), 
                                      image: NetworkImage(item.getPoster()),
                                      width: 50.0,
                                      fit: BoxFit.contain,
                ),
                subtitle: Text(item.originalTitle),
                onTap: () {
                  close(context, null);
                  item.uniqueId = '';
                  Navigator.pushNamed(context, 'details', arguments: item);
                },                
              );
              }).toList()
            );
        } else {
          return Center(child: CircularProgressIndicator(),);
        }

      },
    );
  }

}