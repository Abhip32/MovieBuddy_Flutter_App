import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/trending.dart';
import 'horizontal_cards.dart';


final Map<String, String> headers = {
  HttpHeaders.contentTypeHeader: "application/json",
  "Connection": "Keep-Alive",
  "Keep-Alive": "timeout=5, max=1000"
};


Future<Trending> fetchMovies(movieId,type) async {
  final String keyVar = "caf2a248e122b28ea4be65ccc7d381b7";
  final response = await http.get(Uri.parse("https://api.themoviedb.org/3/$type/$movieId/similar?api_key=$keyVar"),headers: headers);
  if (response.statusCode == 200) {
    return Trending.fromJson(json.decode(response.body));
  } else {
    throw Exception('not able to Fetch the Upcoming Movies');
  }
}

class SimilarMovies extends StatefulWidget {
  final int movieId;
  final String type;
  SimilarMovies(this.movieId,this.type);
  @override
  _SimilarMoviesState createState() => _SimilarMoviesState(movieId,type);
}

class _SimilarMoviesState extends State<SimilarMovies> {
  late int movieId;
  late String type;
  _SimilarMoviesState(movieId,type) {
    this.movieId = movieId;
    this.type=type;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchMovies(movieId,type),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Image.asset('assets/images/loading.gif'),
          );
        } else {
          return HorizontalCards(snapshot.data.movies,0.40);
        }
      },
    );
  }
}