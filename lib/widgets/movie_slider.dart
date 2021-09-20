import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {

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
          Padding(
            padding: EdgeInsets.symmetric( horizontal: 20 ),
            child: Text('Populares', style: TextStyle( fontSize: 20, fontWeight: FontWeight.w600 ),),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: 20,
              scrollDirection: Axis.horizontal,
              itemBuilder: ( BuildContext context, int index ){

                return _MoviePoster();

              }
            ),
          )
          
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

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
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'Movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage( 'assets/no-image.jpg' ), 
                image: NetworkImage( 'https://via.placeholder.com/300x400' ),
                width: size.width * 0.2,
                height:  size.height * 0.14,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Text( 
            'Star Wars: El retorno del nuevo',
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )

        ],
      ),
    );
  }
}