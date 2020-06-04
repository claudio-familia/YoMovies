import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:yo_movies/src/models/actor_model.dart';

import 'package:yo_movies/src/models/movie_model.dart';


class MovieProvider{
  static final _apiKey = 'fdd239543577a82b54995874ecae8330';
  static final _url = 'api.themoviedb.org';
  static final _language = 'en-US';  

  int _popularPage = 0;
  bool _isLoadingData = false;

  List<Movie> _populars = new List();

  final _popularStreamController = new StreamController<List<Movie>>.broadcast();

  void disposeStreams(){
    _popularStreamController?.close();
  }

  Function(List<Movie>) get popularSink => _popularStreamController.sink.add;
  
  Stream<List<Movie>> get popularStream => _popularStreamController.stream;

  final _apiConfig = {
      'api_key'   : _apiKey,
      'language'  : _language,      
  };

  Future<List<Movie>> getResponse(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);

    final movies = new Movies.fromJsonList(decodeData['results']);        
    
    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {    
    final url = Uri.https(_url, '/3/movie/now_playing', _apiConfig);    
    return await getResponse(url);
  }

  Future<List<Movie>> getPopularMovies() async {    
    if(this._isLoadingData) return [];                     

      this._isLoadingData = true;

      this._popularPage++;    
      
      final url = Uri.https(_url, '/3/movie/popular', {
        'api_key'   : _apiKey,
        'language'  : _language,
        'page'      : this._popularPage.toString()
      });
      
      final response = await getResponse(url);

      _populars.addAll(response);
      
      popularSink(_populars);

      this._isLoadingData = false;      

      return response;
  }

  Future<List<Actor>> getCast( String movieId) async {
    final url = Uri.https(_url, '/3/movie/$movieId/credits', _apiConfig);
    
    final resp = await http.get(url);
    
    final decodedData = json.decode(resp.body);

    final casting = new Cast.fromJsonList(decodedData['cast']);

    return casting.actors;
  }

  Future<List<Movie>> searchMovie ( String query ) async {
     final url = Uri.https(_url, '/3/search/movie', {
        'api_key'   : _apiKey,
        'language'  : _language,
        'query'     : query
      });

      return await getResponse(url);
  }
}