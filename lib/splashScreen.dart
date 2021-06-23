import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fan_page_app/main.dart';
import 'package:fan_page_app/registerScreen.dart';
import 'package:fan_page_app/logInScreen.dart';

//class for splash screen with log-in/register buttons and picture of moi :)
class SplashScreen extends StatelessWidget {
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
            Text('I nutted'),
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
            )
          ]
        )
      )
    )
    );
  }
}