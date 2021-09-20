import 'package:flutter/material.dart';

class CastingCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Container(
      margin: EdgeInsets.only( bottom: size.height * 0.02 ),
      width: double.infinity,
      height: size.height * 0.16,
      // color: Colors.red,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: ( BuildContext context, int index ){

          return _CastCard(); 

        },
      ),
    );
  }
}


class _CastCard extends StatelessWidget {

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
              image: NetworkImage( 'https://via.placeholder.com/150x300' ),
              height: size.height * 0.12,
              width: size.width * 0.18,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox( height:5 ),

          Text(
            'actor.name',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}