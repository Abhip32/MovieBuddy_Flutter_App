import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/Screen.dart';
import 'package:flutter_app/Screens/allMovies.dart';
import 'package:flutter_app/Screens/allSeries.dart';

import 'package:flutter_app/Screens/home_screen.dart';
import '../Screens/search_movies.dart';

Future main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AutomaticKeepAliveClientMixin {
  var uid=FirebaseAuth.instance.currentUser?.uid.toString();
  int _selectedIndex = 0;
  final List<Widget> _childWidgets = [HomeScreen(), SearchMovies(),AllMovies(),AllSeries(),UserPage()];

  _onItemTapped(int index) {
    setState(() {
      this._selectedIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: _childWidgets[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.black,

          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.tv),
              label: '',
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      );
  }
}