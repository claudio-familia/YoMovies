import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:yo_movies/src/models/movie_model.dart';


class MovieProvider{
  String _apiKey = 'fdd239543577a82b54995874ecae8330';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key'   : _apiKey,
      'language'  : _language
    });
    
    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodeData['results']);        
    
    return movies.items;
  }
}