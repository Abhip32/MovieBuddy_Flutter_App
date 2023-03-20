import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/reuseable_widgets/navbar.dart';

import 'package:flutter_app/reuseable_widgets/trending_movies.dart';
import 'package:flutter_app/reuseable_widgets/top_rated.dart';
import 'package:flutter_app/reuseable_widgets/trending_series.dart';
import 'package:flutter_app/reuseable_widgets/upcoming_movies.dart';

import '../reuseable_widgets/Carousel.dart';
import '../utils/color_utils.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                            const SizedBox(
                height: 5,
              ),
              Carousel(),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0), //Container
              ),

              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 10.0, left: 5,),
                    child:  Container( //apply margin and padding using Container Widget.
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), //You can use EdgeInsets like above
                      margin: EdgeInsets.all(0.5),
                      child: Text("Trending Movies",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),

                    ),

                  ),
                ),
              ),

              TrendingMovies(),

              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0), //Container
              ),

              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 10.0, left: 5,),
                    child:  Container( //apply margin and padding using Container Widget.
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), //You can use EdgeInsets like above
                      margin: EdgeInsets.all(0.5),
                      child: Text("Trending TV Shows",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),

                    ),

                  ),
                ),
              ),

              TrendingSeries(),

              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0), //Container
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 10.0, left: 5,),
                    child:  Container( //apply margin and padding using Container Widget.
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), //You can use EdgeInsets like above
                      margin: EdgeInsets.all(0.5),
                      child: Text("Top Rated Movies",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),

                    ),

                  ),
                ),
              ),
              TopRated(type:'movie'),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0), //Container
              ),


              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0), //Container
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 10.0, left: 5,),
                    child:  Container( //apply margin and padding using Container Widget.
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), //You can use EdgeInsets like above
                      margin: EdgeInsets.all(0.5),
                      child: Text("Top Rated TV Shows",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),

                    ),

                  ),
                ),
              ),
              TopRated(type:'tv'),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0), //Container
              ),

              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 10.0, left: 5,),
                    child:  Container( //apply margin and padding using Container Widget.
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5), //You can use EdgeInsets like above
                      margin: EdgeInsets.all(0.5),
                      child: Text("Upcoming Movies",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),

                    ),

                  ),
                ),
              ),
              UpcomingMovies(),
              const SizedBox(
                height: 40,
              ),


            ],
          ),
        ),
      ),
    );
  }
}