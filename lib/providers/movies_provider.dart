import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/now_playing_response.dart';
import 'package:peliculas/models/popular_movie_response.dart';
import 'package:peliculas/providers/movie.dart';

class MoviesProvider extends ChangeNotifier {

  String _baseUrl = 'api.themoviedb.org';
  String _apiAkey = 'f5ac30aaaba00d3237f3fa3403d339f2';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  

  MoviesProvider() {
    print('Movies Provider inicializado');
    this.getOnDisplayMovies();  
    this.getPopularMovies();
  }

    getOnDisplayMovies() async {
      
      var url = Uri.https(_baseUrl, '3/movie/now_playing',{
        'api_key' : _apiAkey,
        'language'  :  _language,
        'page'  : '1'
      });

      final response = await http.get(url);
      final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

      // print( nowPlayingResponse.results[0].title );
      onDisplayMovies = nowPlayingResponse.results;
      notifyListeners();

    }

    getPopularMovies() async{

       var url = Uri.https(_baseUrl, '3/movie/popular',{
        'api_key' : _apiAkey,
        'language'  :  _language,
        'page'  : '1'
      });

      final response = await http.get(url);
      final popularMoviesResponse = PopularMovieResponse.fromJson(response.body);

      // print( nowPlayingResponse.results[0].title );
      popularMovies = [...popularMovies, ...popularMoviesResponse.results];
      print('PopularMovies------------------  ${popularMovies[0]}' );
      notifyListeners();


    }

}