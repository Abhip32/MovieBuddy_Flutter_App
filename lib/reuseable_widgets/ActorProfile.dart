import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/Actor.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import '../models/trending.dart';
import './horizontal_cards.dart';

final Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: "application/json",
  "Connection": "Keep-Alive",
  "Keep-Alive": "timeout=5, max=1000"
};

class ActorProfile extends StatefulWidget {
  const ActorProfile({Key? key, required this.castId}) : super(key: key);
  final int castId;
  @override
  _ActorProfileState createState() => _ActorProfileState();
}

class _ActorProfileState extends State<ActorProfile> {
  Future<Actor> fetchMovies() async {
    final String keyVar = "caf2a248e122b28ea4be65ccc7d381b7";
    final response = await http.get(
        Uri.parse(
            "https://api.themoviedb.org/3/person/${widget.castId.toString()}?api_key=$keyVar&language=en-US"),
        headers: headers);
    if (response.statusCode == 200) {
      return Actor.fromJson(json.decode(response.body));
    } else {
      throw Exception('not able to Fetch the Top Rated Movies');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMovies(),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Image.asset('assets/images/loading.gif'),
          );
        } else {
          return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.black,
                  ),
                  body: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,

                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTkmgM7FtJ-w23J_UzEFYMAOaPkvSGLPd_Pu0F7aLDLjkvmhT8h"),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.height*0.20,
                                child:   Image.network('http://image.tmdb.org/t/p/w780/${snapshot.data.profile_path}'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text("${snapshot.data.name}",style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 25),),
                              ),
                              Padding(padding:EdgeInsets.all(20),
                                  child:Align(
                                alignment: Alignment.bottomLeft,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Biography : ",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
                                        SizedBox(height: 10,),
                                        Text(snapshot.data.biography,style: TextStyle(color: Colors.white,fontSize: 18)),
                                        SizedBox(height: 20,),
                                        Text("Date of Birthday : ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                        SizedBox(height: 10,),
                                        Text("    "+snapshot.data.birthday,style: TextStyle(color: Colors.white,fontSize: 18)),
                                        SizedBox(height: 20,),
                                        Text("Place of Birth : ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                        Text("    "+snapshot.data.place_of_birth,style: TextStyle(color: Colors.white,fontSize: 18)),
                                        SizedBox(height: 20,),
                                        Text("Known for Department : ",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                                        Text("    "+snapshot.data.known_for_department,style: TextStyle(color: Colors.white,fontSize: 18)),
                                      ],
                                    ),
                              )
                              )
                            ],
                          )))));
        }
      },
    );
  }
}
