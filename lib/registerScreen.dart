import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fan_page_app/main.dart';
import 'package:fan_page_app/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RegisterScreen extends StatefulWidget{
  @override 
  _RegisterScreenState createState() => new _RegisterScreenState();
} 

class _RegisterScreenState extends State<RegisterScreen> {

  late String _firstName, _lastName,_email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //instance of firebase auth
  final auth = FirebaseAuth.instance;

  //instance of cloud firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(title: Text('Sign Up'), centerTitle: true),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //start of first name text box field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField( 
                validator: (String? input){
                  //if nothing is input into field, return error
                  if(input == null || input.isEmpty){
                    return 'Please enter your first name';
                  }
                  return null;
                },
                onChanged: (value){
                  setState((){
                    _firstName = value.trim();
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name'
                ),                           
              ),
            ),
            //start of last name text box field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                validator: (String? input){
                  //if nothing is input into field, return error
                  if(input == null || input.isEmpty){
                    return 'Please enter your last name';
                  }
                  return null;
                },
                onChanged: (value){
                  setState((){
                    _lastName = value.trim();
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name'
                )
              ),
            ),
            //start of email text box field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                validator: (String? input){
                  //if nothing is input into field, return error
                  if(input == null || input.isEmpty){
                    return 'Please enter your E-mail';
                  }
                  return null;
                },
                onChanged: (value){
                  setState((){
                    _email = value.trim();
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'E-mail'
                )
              ),
            ),
            //start of password text box field
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: TextFormField(
                validator: (String? input){
                  //if nothing is input into field, return error
                  if(input == null || input.isEmpty){
                    return 'Please enter a password';
                  }
                  return null;
                },
                onChanged: (value){
                  setState((){
                    _password = value.trim();
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password: at least 6 characters'
                ),
                //hides characters when typing
                obscureText: true,
              ),
            ),
            //start of Register button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                    onPressed: () {
                      signUp(_firstName, _lastName, _email, _password);
                    },
                    child: Text('Register'),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[600],
                    fixedSize: Size(SizeConfig.blockSizeHorizontal * 250.0, SizeConfig.blockSizeVertical * 0.0)
                    )      
              ),
            ),
           // SizedBox(height: 20),
           //start of social media sign up divider
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Divider(color: Colors.black)
                  ),
                ),
                Text('OR'),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Divider(color: Colors.black)
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton.icon(
                    onPressed: (){},
                    label: Text('Sign up with Facebook'),
                    icon: Icon(
                      Icons.facebook
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.indigo[800],
                    fixedSize: Size(SizeConfig.blockSizeHorizontal * 250.0, SizeConfig.blockSizeVertical * 0.0)
                    )      
              ),
            ),
          ] 
        )       
      )
    );
  }
  //method to sign up through firebase auth
  Future<String?> signUp(String _firstName, String _lastName, String _email, String _password) async{
    try{
      await auth.createUserWithEmailAndPassword(email: _email, password: _password);
      
      //used to get user's unique id after registration
      final User? user = auth.currentUser;
      final String uid = user!.uid;

      //adds user info to collection 'users' 
      CollectionReference users = firestore.collection('users');
      users.add({
        'first_name': _firstName,
        'last_name': _lastName,
        'registration_datetime': DateTime.now(),
        'user_id': uid,
        'user_role': 'customer'
      }).then((value)=>print("User Added")).catchError((error)=>print("Failed to add user:$error"));

      //moves user to homepage screen
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));

      return 'Signed Up';
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }
}