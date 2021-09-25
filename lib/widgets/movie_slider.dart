import 'package:flutter/material.dart';
import 'package:peliculas/providers/movie.dart';

class MovieSlider extends StatefulWidget {

   final List<Movie> movies;
   final String? title;
   final Function onNextPage;

  const MovieSlider({Key? key, required this.movies, this.title, required this.onNextPage}) : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      
      if( scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500 ){
        widget.onNextPage();
      }

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          (widget.title != null)
          ? Padding(
            padding: EdgeInsets.symmetric( horizontal: 20 ),
            child: Text(this.widget.title!, style: TextStyle( fontSize: 20, fontWeight: FontWeight.w600 ),),
          )
          : Container(),

          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ( BuildContext context, int index ){

                return _MoviePoster( widget.movies[index], '${widget.title}-${index}-${widget.movies[index].id}' );

              }
            ),
          )
          
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {

  final Movie movie;
  final String heroId;

  const _MoviePoster(this.movie, this.heroId );

  @override
  Widget build(BuildContext context) {

    movie.heroId = heroId;

    final size = MediaQuery.of(context).size;


    return Container(
      width: size.width * 0.2,
      height:  size.height * 0.1,
      // color: Colors.green,
      margin: EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          GestureDetector(
            onTap: (){ 
              Navigator.pushNamed(context, 'details', arguments: movie);
            },
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage( 'assets/no-image.jpg' ), 
                  image: NetworkImage( movie.fullPosterImg ),
                  width: size.width * 0.2,
                  height:  size.height * 0.14,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          Text( 
            movie.title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )

        ],
      ),
    );
  }
}