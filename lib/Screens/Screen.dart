import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/reuseable_widgets/horizontal_cards.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}


class _UserPageState extends State<UserPage> {
  final databaseReference = FirebaseDatabase.instance.reference();
  var uid=FirebaseAuth.instance.currentUser?.uid.toString();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var data;
  late var list=[];
  bool edit=false;
  String username="";
  String email="";

  @override
  Widget build(BuildContext context) {
    DatabaseReference _databaseReference = FirebaseDatabase.instance.reference().child(uid!);
    _databaseReference.once().then((DataSnapshot snapshot) {
      data= snapshot.value;
      setState(() {
        username=data['username'];
        list=data['favourites'];
        email=data['email'];
        _userNameTextController.text=data['username'];
        _emailTextController.text=data['email'];
        _passwordTextController.text=data['password'];
      });
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTkmgM7FtJ-w23J_UzEFYMAOaPkvSGLPd_Pu0F7aLDLjkvmhT8h"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Center(
                    child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 100,
                )),
                backgroundColor: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(width:MediaQuery.of(context).size.width*0.05),
                Text("Account Information",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(width:MediaQuery.of(context).size.width*0.28),
                (!edit)?  ElevatedButton(onPressed: () {setState(() {
                  edit=true;
                });}, child: Text("Edit",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.normal),
                ),
                ):ElevatedButton(onPressed: () {setState(() {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }

                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value) {
                    var uid=FirebaseAuth.instance.currentUser?.uid.toString();
                    print(uid);
                    databaseReference.child(uid!).set({
                      'username':_userNameTextController.text,
                      'email':_emailTextController.text,
                      'password':_passwordTextController.text,
                    });
                    edit=false;

                  }).onError((error, stackTrace) {
                        print(error);
                  });
                });},
                    child: Text("Submit",style: TextStyle(fontSize: 15,fontWeight:FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontStyle: FontStyle.normal),
                  ),
                ),
                ],)

              ,
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.25,
                child: ClipRRect(
                  child: Image.network('https://images.thedirect.com/media/article_full/hbo-max-cancelling-shows.jpg')
              )
              ),
             Align(
               alignment: Alignment.bottomLeft,
               child: (!edit)?Padding(
                 padding: EdgeInsets.all(20),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("User Info".toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                     SizedBox(height: 5,),

                     Container(
                       padding: const EdgeInsets.all(10.0),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("Username : ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                           Text(
                           username,
                           style: TextStyle(fontSize: 20.0,color: Colors.white),
                         ),],
                       )
                     ),
                     Container(
                         padding: const EdgeInsets.all(10.0),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Email : ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                             Text(
                               email,
                               style: TextStyle(fontSize: 20.0,color: Colors.white),
                             ),],
                         )
                     ),
                     SizedBox(height: 20,),
                     
                     Text("Your Favourites".toString(),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                     (list.runtimeType==Null)?Padding(padding: EdgeInsets.all(10),child: Text("No Favourites Yet",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),):Padding(
                       padding: EdgeInsets.all(10),child: HorizontalCards(list,0.20),)],
                 )
               ):Container(
                 padding: EdgeInsets.all(20),
                 child: Form(
                   key: _formKey,
                   child: Column(
                     children:[
                       Text("Edit Information",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                       const SizedBox(
                         height: 20,
                       ),
                       TextFormField(
                         // The validator receives the text that the user has entered.
                         controller: _userNameTextController,
                         obscureText: false,
                         enableSuggestions: true,
                         autocorrect: true,
                         cursorColor: Colors.white,
                         style: TextStyle(color: Colors.white.withOpacity(0.9)),
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please your username';
                           }
                           return null;
                         },
                         decoration: InputDecoration(
                           prefixIcon: Icon(
                             Icons.person_outline,
                             color: Colors.white70,
                           ),
                           labelText: 'Enter Username',
                           labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                           filled: true,
                           floatingLabelBehavior: FloatingLabelBehavior.never,
                           fillColor: Colors.white.withOpacity(0.3),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30.0),
                               borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                         ),
                         keyboardType: TextInputType.emailAddress,
                       ),
                       const SizedBox(
                         height: 20,
                       ),
                       TextFormField(
                         // The validator receives the text that the user has entered.
                         controller: _emailTextController,
                         obscureText: false,
                         enableSuggestions: true,
                         autocorrect: true,
                         cursorColor: Colors.white,
                         style: TextStyle(color: Colors.white.withOpacity(0.9)),
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please your email';
                           }
                           return null;
                         },
                         decoration: InputDecoration(
                           prefixIcon: Icon(
                             Icons.email,
                             color: Colors.white70,
                           ),
                           labelText: 'Enter Email',
                           labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                           filled: true,
                           floatingLabelBehavior: FloatingLabelBehavior.never,
                           fillColor: Colors.white.withOpacity(0.3),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30.0),
                               borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                         ),
                         keyboardType: TextInputType.emailAddress,
                       ),
                       const SizedBox(
                         height: 20,
                       ),

                       TextFormField(
                         // The validator receives the text that the user has entered.
                         controller: _passwordTextController,
                         obscureText: true,
                         enableSuggestions: false,
                         autocorrect: false,
                         cursorColor: Colors.white,
                         style: TextStyle(color: Colors.white.withOpacity(0.9)),
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please your password';
                           }
                           return null;
                         },
                         decoration: InputDecoration(
                           prefixIcon: Icon(
                             Icons.lock_outline,
                             color: Colors.white70,
                           ),
                           labelText: 'Enter Password',
                           labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                           filled: true,
                           floatingLabelBehavior: FloatingLabelBehavior.never,
                           fillColor: Colors.white.withOpacity(0.3),
                           border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30.0),
                               borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                         ),
                         keyboardType: TextInputType.emailAddress,
                       ),
                     ]

                   ),
                 ),
               )
             )
            ],
          ),
        ),
      ),
    );
  }
}
