import 'package:flutter/material.dart';

import 'package:flutter_app/Screens/detail.dart';

class StackCards extends StatelessWidget {
  final List movieData;
  StackCards(this.movieData);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.70,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // number of items per row
          crossAxisCount: 2,
          // vertical spacing bet
          // ween the items
          mainAxisSpacing: 4.0,
          // horizontal spacing between the items
          crossAxisSpacing: 4.0,

          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height ),
        ),
        // number of items in your list
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
              width: MediaQuery.of(context).size.width * 0.6,

              child: Card(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return Detail(movieData: movieData[index]);
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: 'http://image.tmdb.org/t/p/w780/$posterPath',fit: BoxFit.fill,),

                        Column(
                          children:[
                            Container(
                                height: 22,
                                child: Padding(
                                  padding:EdgeInsets.only(top: 10),
                                  child: Text(
                                    '$name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                )
                            ),
                          ] ,)

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