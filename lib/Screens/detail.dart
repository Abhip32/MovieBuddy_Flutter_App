import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/reuseable_widgets/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_app/reuseable_widgets/actors.dart';
import 'package:flutter_app/reuseable_widgets/similar_movies.dart';
import '../models/trending.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Trailer {
  final String key;

  Trailer({required this.key});

  factory Trailer.fromJson(Map<String, dynamic> json) {
    return Trailer(key: json['key']);
  }
}


class Detail extends StatefulWidget {
  const Detail({Key? key,required this.movieData}) : super(key: key);

  final Map movieData;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final databaseReference = FirebaseDatabase.instance.reference();
  var uid=FirebaseAuth.instance.currentUser?.uid.toString();
  var data;
  bool play=false;
  String username="";
  bool idFound=false;
  final growableList = List.empty(growable: true);
  List<Trailer> _trailers = <Trailer>[];

  @override
  void initState() {
    super.initState();
    _populateAllMovies();
  }

  Future<List<Trailer>> _fetchTrailer() async {
    String id=widget.movieData['id'].toString();
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/$id/videos?api_key=caf2a248e122b28ea4be65ccc7d381b7'));

    if(response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["results"];
      return list.map((trailer) => Trailer.fromJson(trailer)).toList();
    } else {
      throw Exception("Failed to load trailer!");
    }

  }

  void _populateAllMovies() async {
    final trailers = await _fetchTrailer();
    setState(() {
      _trailers = trailers;
    });
  }
  @override
  Widget build(BuildContext context) {
    DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child(uid!);
    _databaseReference.once().then((DataSnapshot snapshot) {
        data= snapshot.value;
        setState(() {
          username=data['username'];
          for(var i = 0; i< data['favourites'].length; i++) {
             if(data['favourites'][i]['movieId']==widget.movieData['id'])
               {
                   idFound=true;
               }
          }


        });

    });
    final Size size = MediaQuery.of(context).size;
    final String _titlePath = widget.movieData['backdrop_path'];
    String movieName="";
    String type="";
    if(widget.movieData['title']!=null)
    {
      movieName= widget.movieData['title'];
      type="movie";
    }
    else
    {
      movieName= widget.movieData['name'];
      type="tv";
    }
    final String movieOverview = widget.movieData['overview'];
    final int movieId = widget.movieData['id'];
    return Scaffold(
      appBar: PreferredSize(
        child: SafeArea(

          child: (play)?VideoPlayer(id:_trailers[0].key):AppBar(
            flexibleSpace: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: "http://image.tmdb.org/t/p/w780/$_titlePath",
              fit: BoxFit.cover,
              height: size.height,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(size.height / 3),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTkmgM7FtJ-w23J_UzEFYMAOaPkvSGLPd_Pu0F7aLDLjkvmhT8h"),
                fit: BoxFit.cover),
          ),

          child:Column(children: <Widget>[
            SizedBox(height: 10.0),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.only(
                      bottom: 5.0, left: 30.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 40, // <-- Your width
                        height: 40,
                        child :ElevatedButton(
                          onPressed: () {setState(() {
                            play=!play;
                            print(play);
                          });},
                          child: Icon( //<-- SEE HERE
                            (!play)?Icons.play_arrow:Icons.pause_circle,
                            color: Colors.black,
                            size: 35,
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(), //<-- SEE HERE
                            padding: EdgeInsets.all(0),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(height: 50,width:100 , child: VerticalDivider(color: Colors.transparent,)),


                      SizedBox(
                        width: 75, // <-- Your width
                        height: 20,

                        child :Icon(Icons.add,color: Colors.white,),
                      ),

                      SizedBox(
                        width: 75, // <-- Your width
                        height: 20,

                        child :Icon(Icons.movie,color: Colors.white,),
                      ),

                      SizedBox(
                        width: 75, // <-- Your width
                        height: 20,

                        child :Icon(Icons.download,color: Colors.white,),
                      ),

                    ],
                  ),
                )
            ),
            SizedBox(height: 20,),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left:20), //apply padding to all four sides
                child: Text(movieName,style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(left:20), //apply padding to all four sides
                  child: Row(
                    children: [Icon(Icons.star,color: Colors.yellow,),Text("  "+widget.movieData['vote_average'].toString(),style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),],
                  )
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.all(15), //apply padding to all four sides
              child: Text(movieOverview,style: TextStyle(fontSize: 15,color: Colors.white),),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () {
                    growableList.add({'movieId':movieId,'poster_path':"$_titlePath",'name':movieName});
                    if(data['favourites'].runtimeType!=Null)
                      {
                        var newList = new List.from(growableList)..addAll(data['favourites']);
                        newList=newList.toSet().toList();
                        databaseReference.child(uid!).update({
                          'favourites':newList
                        });
                        growableList.clear();
                      }
                    else
                      {
                        databaseReference.child(uid!).update({
                          'favourites':growableList.toSet().toList()
                        });
                        growableList.clear();
                      }

                  },
                  icon: Icon( // <-- Icon
                    Icons.add,
                    size: 24.0,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, //background color of button
                      side: BorderSide(width:3, color:Colors.white), //border width and color
                      elevation: 1, //elevation of button
                      shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.all(10) //content padding inside button
                  ),
                  label: (!idFound)?Text("Add to Your List"):Text("Remove from your list"), // <-- Text
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left:20,bottom: 20), //apply padding to all four sides
                child: Text("Cast",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
            Actors(movieId,type),
            SizedBox(height: 10.0),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top:20,left:20,bottom: 20), //apply padding to all four sides
                child: Text("You might also like",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
            SimilarMovies(movieId,type),
            SizedBox(height: 50,)
          ],
          ),
        ),
      ),
    );
  }
}
