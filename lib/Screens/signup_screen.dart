import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/Screens/home_screen.dart';
import 'package:flutter_app/Screens/signin_screen.dart';
import 'package:flutter_app/reuseable_widgets/reusable_widget.dart';
import 'package:flutter_app/utils/color_utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:age/age.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  String gender="male";
  TextEditingController dateInput = TextEditingController();
  DateTime pick=DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    var err="";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
        body: Form(
        key: _formKey,
        child:Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage("https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTkmgM7FtJ-w23J_UzEFYMAOaPkvSGLPd_Pu0F7aLDLjkvmhT8h"),
                fit: BoxFit.cover),
          ),
          child:
          SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    logoWidget("assets/images/Logo1.png"),

                      const SizedBox(
                        height: 10,
                      ),
                    
                    Text("Create New Account",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 30,
                    ),
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
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Align(alignment: Alignment.topLeft,child: Text("Gender",style: TextStyle(fontSize: 20,color: Colors.white),),),
                        SizedBox(
                          height: 5,
                        ),
                        RadioListTile(
                          title: Row(children: [Icon(Icons.male,color: Colors.white70),Text(" Male",style: TextStyle(color: Colors.white.withOpacity(0.9)),),],),
                          value: "male",
                          groupValue: gender,
                          onChanged: (value){
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),

                        RadioListTile(
                          title: Row(children: [Icon(Icons.female,color: Colors.white70),Text(" Female",style: TextStyle(color: Colors.white.withOpacity(0.9)),),],),
                          value: "female",
                          groupValue: gender,
                          onChanged: (value){
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                  Container(
                      padding: EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        children: [   Align(alignment: Alignment.topLeft,child: Text("Date of Birth",style: TextStyle(fontSize: 20,color: Colors.white),),),
                          TextFormField(
                            controller: dateInput,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                                icon: Icon(Icons.calendar_today,color: Colors.white), //icon of text field
                                labelText: "Enter Date",
                              labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),//label text of field
                            ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate); //formatted date output using intl package =>  2021-03-16
                                setState(() {
                                  pick=pickedDate;
                                  dateInput.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {
                                Text('Please Select the data');
                              }
                            },
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please your date';
                              }
                              else if( value!=null&&Age.dateDifference(
                                  fromDate: pick, toDate: DateTime.now(), includeToDate: false).years<18);
                              {
                                return 'You are not 18 years old';
                              }
                              return null;
                            },

                          )
                            ]
                          )),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(

                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                          FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                              email: _emailTextController.text,
                              password: _passwordTextController.text)
                              .then((value) {
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
                                'favourites':[],
                                'Gender':gender,
                                'DOB':dateInput.text
                              });
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => SignInScreen()));
                            }).onError((error, stackTrace) {
                              err=error.toString();
                            });
                          }).onError((error, stackTrace) {
                            err=error.toString();
                          });




                         /* */

                        },
                        child: Text(
                          'Sign up',
                          style: const TextStyle(
                              color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.black26;
                              }
                              return Colors.white;
                            }),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
                      ),
                    ),

                  ],
                ),
              ))),
    ),
    );
  }
}