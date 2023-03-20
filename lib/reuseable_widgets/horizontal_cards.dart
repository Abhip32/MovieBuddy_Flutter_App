import 'package:flutter/material.dart';

import 'package:flutter_app/Screens/detail.dart';

class HorizontalCards extends StatelessWidget {
  final List movieData;
  final double size;
  HorizontalCards(this.movieData,this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*size ,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieData.length,
        itemBuilder: (context, index) {
          final String posterPath = movieData[index]['poster_path'];
          String name="";
          if(movieData[index]['title']!=null)
            {
              name= movieData[index]['title'];
            }
          else
            {
              name = movieData[index]['name'];
            }
          return
            Container(
            width: MediaQuery.of(context).size.width * 0.4,

          child: Card(
            color: Colors.transparent,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return Detail(movieData:movieData[index]);
                      },
                    ),
                  );
                },
                child: Column(
                children: [
                FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                  image: 'http://image.tmdb.org/t/p/w780/$posterPath',fit: BoxFit.fill,),
                  SizedBox(height: 10,),
                  Text(
                    '$name',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                 ],
                ),
          )
            ),
          );
        },
      ),
    );
  }
}