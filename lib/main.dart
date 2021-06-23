import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fan_page_app/SplashScreen.dart';

//firebase initialized
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'my fan app',
        theme: ThemeData(primaryColor: Colors.blue[600]),
        home: SplashScreen()
    );
  }
}

//used to config size across all platforms
class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

/*
class MyApp extends StatefulWidget{
  @override
  _AppState createState() => _AppState();

}
class _AppState extends State<MyApp>{
  @override
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  Widget build(BuildContext context){
    return FutureBuilder(
      future: _initialization ,
      builder: (context, snapshot){

        if(snapshot.hasError){
          return SomethingWentWrong();
        }
        if(snapshot.connectionState == ConnectionState.done){

          return MyAwesomeApp();
        }
        return Loading();
      }
    )
  }
}
*/
