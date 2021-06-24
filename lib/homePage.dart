import 'dart:async';

import 'package:fan_page_app/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomePage extends StatefulWidget{
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  //instance of firebase auth
  final auth = FirebaseAuth.instance;

  //instance of cloud firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //used to store admin message and update to firestore database
  late String _message;

  //used to check user_role and allow for admin button to appear/reappear
  bool isVisible = false;
  
  @override 
  Widget build(BuildContext context){

    checkUser();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello babes ;)'), 
          centerTitle: true, 
          actions: <Widget>[
            //Log out icon button
            IconButton(
              icon: Icon(Icons.logout,color: Colors.white), 
              //on pressed, will show alert dialog asking for user to confirm logging out
              onPressed: () => showDialog(
                context: context, 
                builder: (BuildContext context) => AlertDialog(
                  //description message in alert dialog
                  content: Text('Are you sure you want to log out?'),
                  actions: <Widget>[
                    //will cancel and return back to home page
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () => Navigator.pop(context, 'Cancel'),                
                    ),
                    //will sign out user and return to splash screen
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () {                                            
                        auth.signOut();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>SplashScreen()));               
                      },      
                    ),            
                  ]
                )
              )
            )
          ]
        ),
        //Stream builder returns message posts from firesetore database
        body: StreamBuilder<QuerySnapshot>(
          stream: firestore.collection('message_posts').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else
            //maps document snapshot content from query snapshot
              return ListView(
                children: snapshot.data!.docs.map((doc) {
                  return Card(
                    child: ListTile(
                      title: Text(doc['content']),
                    ),
                  );
                }).toList(),
              );
          },
        ),
        //button only visible to admin user
        //on pressed displays a pop up with a text box to allow user to post to message board
        floatingActionButton: Visibility(
          //will change depending on user role
          visible: isVisible,
          child: FloatingActionButton(
            onPressed: ()=> showDialog(
                  context: context, 
                  builder: (BuildContext context) => AlertDialog(
                    //description message in alert dialog
                    title: Text('Enter a message:'),
                    content: TextField(
                      onChanged: (value){
                        setState((){
                          _message = value.trim();
                        });
                      }
                    ),
                    actions: <Widget>[
                      //cancels and return back to home page
                      TextButton(
                        child: Text('Cancel'),
                        onPressed: () => Navigator.pop(context, 'Cancel')                 
                      ),
                      //posts message and add to firestore database
                      TextButton(
                        child: Text('POST MESSAGE'),
                        onPressed: () {
                          CollectionReference users = firestore.collection('message_posts');
                          users.add({
                            'date_time': DateTime.now(),
                            'content': _message
                          }).then((value)=>print("Message posted")).catchError((error)=>print("Failed to post message:$error"));
                          //returns back to home page
                          Navigator.pop(context);
                        },                     
                      ),            
                    ]
                  )
                ),
            child: Icon(Icons.add),
          ),
        )
      ),
    );
  }

//method to check for user role
  Future <bool?> checkUser() async  {
    try{
        //from the collection 'users' where user_id = currentUser_uid, get the document 
       await firestore.collection('users').where('user_id', isEqualTo: auth.currentUser!.uid).get().then((QuerySnapshot snapshot){
          snapshot.docs.forEach((doc){
            //if user role for this document == admin, setState and make admin post button visible
            if(doc['user_role'] == 'admin'){            
              // isVisible = true;
                setState((){
                  isVisible=true;
                });
              }                          
          });
          return isVisible;
        });     
    } on FirebaseAuthException catch(e){
      return false;
    }
  }
}

