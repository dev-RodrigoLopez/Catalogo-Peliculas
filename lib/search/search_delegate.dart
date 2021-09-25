

import 'package:flutter/material.dart';
import 'package:peliculas/providers/movie.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Buscar peliculas';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: (){
          query = '';
        }, 
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon( Icons.arrow_back ),
      onPressed: (){
        close(context, null );
      }, 
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   return Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   
    if(query.isEmpty){
      return _empyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionByQuery( query );

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: ( BuildContext context, AsyncSnapshot<List<Movie>> snapshot ){

        if( !snapshot.hasData ){
          return _empyContainer();
        }

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ( BuildContext context, int index ){
            return MovieItem( movie: movies[index] );
          }
        );

      }
    );


  }

  Widget _empyContainer(){

    return Container(
        child: Center(
          child: Icon( Icons.movie_creation_outlined, color: Colors.black38, size: 130 ),
        ),
      );

  }
}


class MovieItem extends StatelessWidget {
  
  final Movie movie;

  const MovieItem({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage( 'assets/no-image.jpg' ), 
          image: NetworkImage( movie.fullPosterImg ),
          width: 80,
          fit: BoxFit.contain,  
        ),
      ),
      title: Text( movie.title ),
      subtitle: Text( movie.originalTitle ),
      onTap: (){

        Navigator.pushNamed(context, 'details', arguments: movie);

      },
    );
  }
}