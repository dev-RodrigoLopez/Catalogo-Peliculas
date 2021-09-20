import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:peliculas/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    //TODO: Cambiar luego por una instancia de MOVIE

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList( 
            delegate: SliverChildListDelegate([
              PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              SizedBox( height: 50 ),
              CastingCard()
            ]),
           )
        ],
      )
    );
  }
}


class _CustomAppBar extends StatelessWidget {
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
          child: Text(
            'Movie Title',
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


class PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only( top: size.height * 0.05 ),
      padding: EdgeInsets.symmetric( horizontal: size.width * 0.05 ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage( 'assets/no-image.jpg' ), 
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),

          SizedBox( width: 20 ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Movie.Title', style: Theme.of(context).textTheme.headline5 , overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text('Original.Title', style: Theme.of(context).textTheme.subtitle1 , overflow: TextOverflow.ellipsis, maxLines: 1,),

              Row(
                children: [
                  Icon( Icons.star, size: 15, color: Colors.grey, ),
                  SizedBox( width: 5 ),
                  Text( 'Movie.VoteAverege', style: Theme.of(context).textTheme.caption )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric( horizontal: size.width * 0.05, vertical: size.height * 0.01 ),
      child: Text(
        
        'Adipisicing fugiat ea deserunt Lorem cupidatat in laborum cupidatat sit consectetur cillum proident.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}