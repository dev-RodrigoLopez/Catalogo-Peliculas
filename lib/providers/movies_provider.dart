import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/now_playing_response.dart';
import 'package:peliculas/models/popular_movie_response.dart';
import 'package:peliculas/providers/movie.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  String _apiAkey = 'f5ac30aaaba00d3237f3fa3403d339f2';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int , List<Cast>> moviesCast = {};
  
  int popularPage = 0;

  MoviesProvider() {
    print('Movies Provider inicializado');
    this.getOnDisplayMovies();  
    this.getPopularMovies();
  }

  Future<String>_getJsonData( String endPoint, [int page = 1 ]) async{

      var url = Uri.https(_baseUrl, endPoint ,{
        'api_key' : _apiAkey,
        'language'  :  _language,
        'page'  : '$page'
      });

      final response = await http.get(url);
      return response.body;

  }

    getOnDisplayMovies() async {
      
      final jsonData = await _getJsonData('3/movie/now_playing', 1);
      final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

      // print( nowPlayingResponse.results[0].title );
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();
    }

    getPopularMovies() async{

      popularPage++;
     
      final jsonData = await _getJsonData('3/movie/popular', popularPage);

      final popularMoviesResponse = PopularMovieResponse.fromJson(jsonData);

      // print( nowPlayingResponse.results[0].title );
      popularMovies = [...popularMovies, ...popularMoviesResponse.results];
      notifyListeners();
    }

    Future<List<Cast>> getMoviesCast ( int movieId ) async {
      
      if( moviesCast.containsKey(movieId) ) return moviesCast[movieId]!;

       final jsonData = await _getJsonData('3/movie/$movieId/credits');
       final creditsResponse = CreditResponse.fromJson( jsonData );

       moviesCast[ movieId ] = creditsResponse.cast;

       return creditsResponse.cast;


    }

}