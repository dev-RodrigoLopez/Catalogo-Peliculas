import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas/models/credits_response.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCard extends StatelessWidget {

  final int movieId;

  const CastingCard({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMoviesCast(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot){

        if( !snapshot.hasData ){
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 180,
            child:  CupertinoActivityIndicator() ,
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          margin: EdgeInsets.only( bottom: size.height * 0.02 ),
          width: double.infinity,
          height: size.height * 0.16,
          // color: Colors.red,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: ( BuildContext context, int index ){

              return _CastCard( actor: cast[index] ); 

            },
          ),
        ); 
      }
    );
    
    
  }
}


class _CastCard extends StatelessWidget {

  final Cast actor;

  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: size.width * 0.2,
      // height: size.height * 0.10,
      // color: Colors.green,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage( 'assets/no-image.jpg' ), 
              image: NetworkImage( actor.fullprofilePath ),
              height: size.height * 0.12,
              width: size.width * 0.18,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox( height:5 ),

          Text(
            actor.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}