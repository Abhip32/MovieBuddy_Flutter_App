import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/reuseable_widgets/card_stack.dart';
import 'package:flutter_app/reuseable_widgets/discover.dart';
import 'package:flutter_app/reuseable_widgets/trending_movies.dart';
import 'package:flutter_app/reuseable_widgets/trending_series.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/trending.dart';
import 'package:flutter_app/reuseable_widgets/horizontal_cards.dart';

class SearchMovies extends StatefulWidget {
  @override
  _SearchMoviesState createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  final searchController = TextEditingController();
  String movieName = '';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  final Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json",
    "Connection": "Keep-Alive",
    "Keep-Alive": "timeout=5, max=1000"
  };


  Future<Trending> fetchMovies() async {
    final String keyVar = "caf2a248e122b28ea4be65ccc7d381b7";
    final response = await http.get(Uri.parse("https://api.themoviedb.org/3/search/movie?api_key=$keyVar&language=en-US&query=$movieName&include_adult=false"),headers: headers);
    if (response.statusCode == 200) {
      return Trending.fromJson(json.decode(response.body));
    } else {
      throw Exception('not able to Fetch the trening Movies');
    }
  }

  // this widget shows not found image
  Widget _notFoundWidget() {
    return Container(
      child: (searchController.text == '') ? 
          Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: Text("Discover Series",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                    )
                  ),
                  DiscoverMovies(type:'tv'),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Recommended Movies",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                      )
                  ),
                  DiscoverMovies(type:'movie'),
                ],
              ),
            ),
          )
          : Text("Not Found",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
    );
  }

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
              height: 5,
            ),
            Row(children: [Padding(
              padding: const EdgeInsets.only(top: 30.0,left: 50.0),
              child: Container(
                width: MediaQuery.of(context).size.width*0.7 ,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(hintText: 'What are you looking for ?',hintStyle: (TextStyle(color:Colors.white)),),
                  controller: searchController,
                ),
              ),
            ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.1 ,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,

                    child: ElevatedButton.icon(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (searchController.text != '') {
                            setState(() {
                              movieName = searchController.text;
                              fetchMovies();
                            });
                          } else {
                            setState(() {
                              movieName = '';
                            });
                          }
                        },
                        label: Text('',style: TextStyle(height: 0),),
                        icon: Icon(Icons.search,size: 30.0,),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size.zero, // Set this
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                        ),
                    ),
                  ),
                ),
              ),
            ],),
            movieName == ''
                ? Expanded(
              child: _notFoundWidget(),
            )
                : Expanded(
              child: FutureBuilder(
                future: fetchMovies(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return _notFoundWidget();
                  } else {
                    final List movieData = snapshot.data.movies;
                    movieData.removeWhere(
                            (item) => item['poster_path'] == null);
                    if (movieData == []) {
                      return _notFoundWidget();
                    } else {
                      return StackCards(movieData);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}