import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fan_page_app/main.dart';
import 'package:fan_page_app/registerScreen.dart';
import 'package:fan_page_app/logInScreen.dart';
import 'package:fan_page_app/homePage.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SplashScreen extends StatefulWidget{
  @override 
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      home:Scaffold(
      appBar: AppBar(title: Text('Welcome to my Only Fans babes ;)'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //start of image asset
            Padding(
              padding: EdgeInsets.all(15.0),
                child: Image.asset('assets/hawaii2.jpg', fit: BoxFit.fill),          
            ),
            //small caption
            Text('phat nut'),
            //log in button, navigate to log in screen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogInScreen()),
                      );
                  },
                  child: Text('Log In'),
                  style: ElevatedButton.styleFrom(primary: Colors.blue[600], fixedSize: Size(SizeConfig.blockSizeHorizontal * 25.0, SizeConfig.blockSizeVertical * 0.0))
                ),
                //sized box to maintain distance
                SizedBox(width: 10),
                //register button, navigate to register screen
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[600], fixedSize: Size(SizeConfig.blockSizeHorizontal * 25.0, SizeConfig.blockSizeVertical * 0.0)))
              ]
            ),
            SizedBox(height: 20),
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
            //Start of facebook log in button
            Padding(         
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Container(
                alignment:  Alignment.center,
                child: SignInButton(
                  Buttons.Google,
                  text: "Sign in with Google",
                  onPressed: () {
                    signInWithGoogle();
                  },
                )
              ),
            ),
          ]
        )
      )
    )
    );
  }

Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}