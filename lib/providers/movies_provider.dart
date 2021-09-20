import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier {

  MoviesProvider() {
    print('Movies Provider inicializado');
    this.getOnDisplayMovies();  
  }

    getOnDisplayMovies(){
      print(' GetOnDisplayMovies ');
    }

}