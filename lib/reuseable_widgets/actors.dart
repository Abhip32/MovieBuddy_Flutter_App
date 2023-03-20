import 'package:flutter/material.dart';
import 'package:flutter_app/reuseable_widgets/ActorProfile.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Screens/detail.dart';
import '../models/cast.dart';

Future<Cast> fetchCasts(movieId,type) async {
  final String keyVar = "caf2a248e122b28ea4be65ccc7d381b7";
  final response = await http
      .get(Uri.parse("https://api.themoviedb.org/3/$type/$movieId/credits?api_key=$keyVar"));
  if (response.statusCode == 200) {
    return Cast.fromJson(json.decode(response.body));
  } else {
    throw Exception('not able to Fetch the trening Movies');
  }
}

class Actors extends StatefulWidget {
  final int movieId;
  final String type;
  Actors(this.movieId,this.type);
  @override
  _ActorsState createState() => _ActorsState(movieId,type);
}

class _ActorsState extends State<Actors> {
  late int movieId;
  late String type;
  _ActorsState(movieId,type) {
     this.movieId = movieId;
     this.type=type;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchCasts(this.movieId,this.type),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Image.asset('assets/images/loading.gif'),
          );
        } else {
          final List castData = snapshot.data.cast;
          castData.removeWhere((item) => item['profile_path'] == null);
          return Container(

            height: MediaQuery.of(context).size.height * 0.25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: castData.length,
              itemBuilder: (context, index) {
                final String actorImage = castData[index]['profile_path'];
                final String actorName = castData[index]['name'];
                return Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Card(
                    elevation: 5.0,
                    child:
                  GestureDetector(
                  onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (_) {
                  return ActorProfile(castId:castData[index]['id']);
                  },
                  ),
                  );
                  },
                child:Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/loading.gif',
                              image:
                              'http://image.tmdb.org/t/p/w780/$actorImage'),
                        ),
                        Text(
                          actorName,
                          style: TextStyle(
                              fontSize: 11.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}