import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/reuseable_widgets/card_stack.dart';
import 'package:flutter_app/reuseable_widgets/horizontal_cards.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/trending.dart';


final Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: "application/json",
  "Connection": "Keep-Alive",
  "Keep-Alive": "timeout=1000, max=2000"
};


Future<Trending> fetchMovies(String page) async {
  final String keyVar = "caf2a248e122b28ea4be65ccc7d381b7";;
  final response = await http
      .get(Uri.parse("https://api.themoviedb.org/3/discover/tv?api_key=$keyVar&page=$page&language=en-US&sort_by=popularity.desc"),headers: headers);
  if (response.statusCode == 200) {
    return Trending.fromJson(json.decode(response.body));
  } else {
    throw Exception('not able to Fetch the trening Movies');
  }
}

class AllSeries extends StatefulWidget {
  @override
  _AllSeriesState createState() => _AllSeriesState();

}

class _AllSeriesState extends State<AllSeries> {
  String genere="action";
  String page="1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: NetworkImage("https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTkmgM7FtJ-w23J_UzEFYMAOaPkvSGLPd_Pu0F7aLDLjkvmhT8h"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Center(child: Image.asset(
                'assets/images/logo.png', width: 150, height: 100,)),
              backgroundColor: Colors.black,
            ),
            SizedBox(
              height: 25,
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(left:20), //apply padding to all four sides
                  child: Row(
                      children: [
                        Text("TV shows",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),),

                      ]
                  )
              ),
            ),

            FutureBuilder(
              future: fetchMovies(page),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Text("Not Found",style: TextStyle(color: Colors.white),);
                } else {
                  final List movieData = snapshot.data.movies;
                  movieData.removeWhere(
                          (item) => item['poster_path'] == null);
                  if (movieData == []) {
                    return Text("Not Found",style: TextStyle(color: Colors.white),);
                  } else {
                    return StackCards(movieData);
                  }
                }
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                  crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                  children: [
                    ElevatedButton.icon(
                      onPressed: ()=>{
                        setState(() {
                          page=(int.parse(page)-1).toString();
                        }),
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero, // Set this
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                      ),
                      icon: Icon(Icons.arrow_back,size: 20,),  //icon data for elevated button
                      label: Text(""), //label text
                    ),
                    Text("$page",style: TextStyle(color: Colors.white),),
                    ElevatedButton.icon(
                      onPressed: () => {
                        setState(() {
                          page=(int.parse(page)+1).toString();
                        }),
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero, // Set this
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                      ),
                      icon: Icon(Icons.arrow_forward,size: 20,),  //icon data for elevated button
                      label: Text(""), //label text
                    ),
                  ],

                ),
              ),
            ),
          ],
        ),
      ),

    );

  }
}