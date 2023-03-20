import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/trending.dart';
import './horizontal_cards.dart';


final Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: "application/json",
  "Connection": "Keep-Alive",
  "Keep-Alive": "timeout=5, max=1000"
};




class DiscoverMovies extends StatefulWidget {
  const DiscoverMovies({Key? key,required this.type}) : super(key: key);
  final String type;
  @override
  _DiscoverMoviesState createState() => _DiscoverMoviesState();
}

class _DiscoverMoviesState extends State<DiscoverMovies> {
  Future<Trending> fetchMovies() async {
    final String keyVar = "caf2a248e122b28ea4be65ccc7d381b7";;
    final response = await http
        .get(Uri.parse("https://api.themoviedb.org/3/discover/${widget.type}?api_key=$keyVar&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"),headers: headers);
    if (response.statusCode == 200) {
      return Trending.fromJson(json.decode(response.body));
    } else {
      throw Exception('not able to Fetch the trening Movies');
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
          return HorizontalCards(snapshot.data.movies,0.38);
        }
      },
    );
  }
}