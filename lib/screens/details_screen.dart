import 'package:flutter/material.dart';
import 'package:peliculas/providers/movie.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //TODO: Cambiar luego por una instancia de MOVIE

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( 
            movieTitle: movie.title, 
            fullBackdropPath: movie.fullBackdropPath
          ),
          SliverList( 
            delegate: SliverChildListDelegate([
              PosterAndTitle( 
                movie: movie,
              ),
              _Overview( overview: movie.overview ),
              SizedBox( height: 50 ),
              CastingCard( movieId: movie.id, )
            ]),
           )
        ],
      )
    );
  }
}


class _CustomAppBar extends StatelessWidget {

  final String movieTitle;
  final String fullBackdropPath;

  const _CustomAppBar({
    Key? key, 
    required this.movieTitle,
    required this.fullBackdropPath
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: EdgeInsets.only( bottom: 10, left: 10, right: 10 ),
          child: Text(
            movieTitle,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage(fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const PosterAndTitle({
    Key? key, 
    required this.movie,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only( top: size.height * 0.05 ),
      padding: EdgeInsets.symmetric( horizontal: size.width * 0.05 ),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage( 'assets/no-image.jpg' ), 
                image: NetworkImage(movie.fullPosterImg),
                height: 150,
              ),
            ),
          ),

          SizedBox( width: 20 ),

          ConstrainedBox(
            constraints: BoxConstraints( maxWidth: size.width - 200 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Text(movie.title, style: Theme.of(context).textTheme.headline5 , overflow: TextOverflow.ellipsis, maxLines: 2,),
          
                Text(movie.originalTitle, style: Theme.of(context).textTheme.subtitle1 , overflow: TextOverflow.ellipsis, maxLines: 1,),
          
                Row(
                  children: [
                    Icon( Icons.star, size: 15, color: Colors.grey, ),
                    SizedBox( width: 5 ),
                    Text( movie.voteAverage.toString(), style: Theme.of(context).textTheme.caption )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final String overview;

  const _Overview({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric( horizontal: size.width * 0.05, vertical: size.height * 0.01 ),
      child: Text(
        
        overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}