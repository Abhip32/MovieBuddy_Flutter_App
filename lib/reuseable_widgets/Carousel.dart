import 'package:carousel_slider/carousel_slider.dart';
import 'package:drop_shadow_image/drop_shadow_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Screens/detail.dart';
import '../models/trending.dart';

class Movie {
  final bool adult;
  final String backdrop_path;
  final int id;
  final String name;
  final String overview;
  final double vote_average;

  Movie({required this.adult,required this.backdrop_path,required this.id,required this.name,required this.overview,required this.vote_average});

  factory Movie.fromJson(Map<String, dynamic> json) {
    String ns="";
    if(json['title']==null)
    {
      ns=json['name'];
    }
    else
    {
      ns=json['title'];
    }
    return Movie(adult: json["adult"],backdrop_path: json["backdrop_path"],id:json['id'],name:ns,overview:json["overview"],vote_average: json["vote_average"]);
  }
}

Future<List<Movie>> _fetchAllMovies() async {
  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/trending/all/day?api_key=caf2a248e122b28ea4be65ccc7d381b7'));

  if(response.statusCode == 200) {
    final result = jsonDecode(response.body);
    Iterable list = result["results"];
    return list.map((movie) => Movie.fromJson(movie)).toList();
  } else {
    throw Exception("Failed to load movies!");
  }

}


class Carousel extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}


class _CarouselState extends State<Carousel> {
  List<Movie> _movies = <Movie>[];

  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  void _populateAllMovies() async {
    final movies = await _fetchAllMovies();
    setState(() {
      _movies = movies;
    });
  }


    @override
    Widget build(BuildContext context) {
      return CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlayAnimationDuration: const Duration(milliseconds: 100),
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: _movies
            .map(
              (item) =>
              Stack(
                  children: [
                    Center(
                    child: DropShadowImage(
                      image:Image.network(
                      "https://image.tmdb.org/t/p/w500"+item.backdrop_path,
                      fit: BoxFit.fill,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.35,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width*0.95,
                    ),
                      borderRadius: 20,
                      //@blurRadius if not defined default value is
                      blurRadius: 20,
                      //@offset default value is Offset(8,8)
                      offset: Offset(5,5),
                      //@scale if not defined default value is 1
                      scale: 2,
                  ),
                  ),

                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: const EdgeInsets.only(
                            bottom: 50.0, left: 20,),
                          child:  Container( //apply margin and padding using Container Widget.
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), //You can use EdgeInsets like above
                            margin: EdgeInsets.all(0.5),
                            width: MediaQuery.of(context).size.width*0.4,
                            child: Text(item.name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold, shadows: [
                              Shadow(
                                color: Colors.deepPurple.withOpacity(1),
                                offset: Offset(1, 1),
                                blurRadius: 10,
                              ),
                            ],),),

                          ),

                        ),
                      ),
                    ),
                    Positioned.fill(
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              margin: const EdgeInsets.only(
                                bottom: 5.0, left: 30.0),
                              child: Row(
                                children: [
                                    SizedBox(
                                      width: 25, // <-- Your width
                                      height: 50,
                                      child :ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) {
                                                return Detail(movieData:{'backdrop_path':item.backdrop_path,'title':item.name,'overview':item.overview,'id':item.id,'vote_average':item.vote_average});
                                              },
                                            ),
                                          );
                                        },
                                        child: Icon( //<-- SEE HERE
                                          Icons.play_arrow,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(), //<-- SEE HERE
                                          padding: EdgeInsets.all(0),
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  Container(height: 50,width:10 , child: VerticalDivider(color: Colors.transparent,)),


                                  SizedBox(
                                    width: 75, // <-- Your width
                                    height: 20,

                                    child :ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) {
                                              return Detail(movieData:{'backdrop_path':item.backdrop_path,'title':item.name,'overview':item.overview,'id':item.id,'vote_average':item.vote_average});
                                            },
                                          ),
                                        );
                                      },
                                      child: Text("More Info",style: TextStyle(color: Colors.black,fontSize: 11),),
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.transparent)
                                        ),//<-- SEE HERE
                                        padding: EdgeInsets.all(0),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                        ))
                  ]
              ),
        ).toList(),
      );
    }
  }