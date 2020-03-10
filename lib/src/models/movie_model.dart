class Movies{
  List<Movie> items = new List();
  
  Movies();

  Movies.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    for(var item in jsonList){
      final movie = new Movie.fromJsonMap(item);
      items.add(movie);
    }
  }

}

class Movie {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });


  Movie.fromJsonMap(Map<String, dynamic> jsonFromUrl ){
    popularity        =   jsonFromUrl['popularity'] / 1;
    voteCount         =   jsonFromUrl['vote_count'];
    video             =   jsonFromUrl['video'];
    posterPath        =   jsonFromUrl['poster_path'];
    id                =   jsonFromUrl['id'];
    adult             =   jsonFromUrl['adult'];
    backdropPath      =   jsonFromUrl['backdrop_path'];
    originalLanguage  =   jsonFromUrl['original_language'];
    originalTitle     =   jsonFromUrl['original_title'];
    genreIds          =   jsonFromUrl['genre_ids'].cast<int>();
    title             =   jsonFromUrl['title'];
    voteAverage       =   jsonFromUrl['vote_average'] / 1;
    overview          =   jsonFromUrl['overview'];
    releaseDate       =   jsonFromUrl['release_date'];
  }

  getPoster(){
    if(posterPath == null){
      return 'https://www.poresto.net/wp-content/uploads/CARTELERA-CARMEN.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
  }


}
