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


Future<Trending> fetchMovies() async {
  final String keyVar = "caf2a248e122b28ea4be65ccc7d381b7";;
  final response = await http
      .get(Uri.parse("https://api.themoviedb.org/3/trending/tv/day?api_key=$keyVar"),headers: headers);
  if (response.statusCode == 200) {
    return Trending.fromJson(json.decode(response.body));
  } else {
    throw Exception('not able to Fetch the trening Movies');
  }
}

class TrendingSeries extends StatefulWidget {
  late String alignment;
  @override
  _TrendingSeriesState createState() => _TrendingSeriesState();
}

class _TrendingSeriesState extends State<TrendingSeries> {
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