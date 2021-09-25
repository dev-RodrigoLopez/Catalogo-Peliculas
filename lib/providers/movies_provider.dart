import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/models/now_playing_response.dart';
import 'package:peliculas/models/popular_movie_response.dart';
import 'package:peliculas/models/search_movies_response.dart';
import 'package:peliculas/providers/movie.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  String _apiAkey = 'f5ac30aaaba00d3237f3fa3403d339f2';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int , List<Cast>> moviesCast = {};
  
  int popularPage = 0;

  final debouncer = Debouncer(
    duration: Duration( milliseconds: 500 ),
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider() {
    print('Movies Provider inicializado');
    this.getOnDisplayMovies();  
    this.getPopularMovies();
  }

  Future<String>_getJsonData( String endPoint, [int page = 1 ]) async{

      final url = Uri.https(_baseUrl, endPoint ,{
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

    Future<List<Movie>> SearchMovie( String movie ) async{
         final url = Uri.https(_baseUrl, '3/search/movie' ,{
        'api_key' : _apiAkey,
        'language'  :  _language,
        'include_adult': 'true',
        'query': movie
      });

      final response = await http.get(url);
      final searchMovieResponse =  SearchMovieResponse.fromJson(  response.body );

      return searchMovieResponse.results;

    }

    void getSuggestionByQuery( String seachTerm ){

      debouncer.value = '';
      debouncer.onValue = ( value ) async{

        final results = await this.SearchMovie(value);
        this._suggestionStreamController.add(results);

      };

      final timer = Timer.periodic(Duration( milliseconds:300 ), (_) { 

        debouncer.value = seachTerm;

      });

      Future.delayed( Duration( milliseconds: 301 ) ).then((_) => timer.cancel());

    }

}