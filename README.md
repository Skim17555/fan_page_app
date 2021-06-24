# fan_page_app


This app was developed using VSCode on Flutter version 2.2.2 using Dart 2.13.3

A 'launch.json' file was configured for application to run on Android and web app platforms.


FOR ANDROID:
-------------------------------------------------------------------------------------------------------------------
To run the app on Android emulator, go to Run and Debug to select the debug configuration named 'fan_page_app (android)'.

Since we are using google_sign_in legacy library: 

    import 'package:google_sign_in/google_sign_in.dart';

If a null safety error is thrown when debugging, run app with the command: 
    
    flutter run --no-sound-null-safety

If the above command does not work, go to extension settings -> Workspace -> Dark & Flutter.
Look for Dart: Flutter Run Additional Args and click Add Item to insert "--no-sound-null-safety". Do the same for Dart: Vm Additional Args. 

If it still does not work, go to 'settings.json' file and add the following configuration:

    "dart.flutterRunAdditionalArgs": [
        "--no-sound-null-safety"
    ],
    "dart.vmAdditionalArgs": [
        "--no-sound-null-safety"
    ]


FOR WEB APP:
-------------------------------------------------------------------------------------------------------------------
To run the app on a web browser, go to Run and Debug to select the debug configuration named 'fan_page_app (56100)'.

The authorized JavaScript origins in console.developers.google.com are set up with the URIs:

        http://localhost
        http://localhost:56100


The 'launch.json' file was configured to set the port number as 56100. 

If the .json file poses any issues, alternatively you can also run with the command:

    flutter run --no-sound-null-safety -d chrome --web-port 56100



FOR TESTING FUNCTIONALITY:
-------------------------------------------------------------------------------------------------------------------
To test 'admin' functionality:

    email: bleh@gmail.com
    password: 123456

To test 'customer' functionality:

    email: troyboi@gmail.com
    password: 123456



DEPENDENCIES & PLUG-INS:
-------------------------------------------------------------------------------------------------------------------
In case the dependencies and plug ins do not carry over to github:

Inside pubspec.yaml:

    # flutter sdk version 
    sdk: ">=2.12.0 <3.0.0"
    # These are the versions used for firebase and google_sign_in
    firebase_core: ^1.3.0
    firebase_auth: ^1.4.1
    cloud_firestore: ^2.2.2
    google_sign_in: "^4.5.1"
    flutter_signin_button: ^2.0.0 
    # the flutter_sign_in_button is used for the google log in button 


# For Google and Firebase:
Inside 'build.gradle' file under the 'android/app' folder, add these implementations in the 'dependencies {}' section:

    implementation platform('com.google.firebase:firebase-bom:28.1.0')
    implementation 'com.google.firebase:firebase-analytics-ktx'
    implementation 'com.android.support:multidex:1.0.3'
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"

    // Declare the dependency for the Firebase Authentication library
    // When using the BoM, you don't specify versions in Firebase library dependencies
    implementation 'com.google.firebase:firebase-auth'

    // Also declare the dependency for the Google Play services library and specify its version
    implementation 'com.google.android.gms:play-services-auth:19.0.0'

Do the same for the other 'build.gradle' file that is inside the 'android' folder, add these implementations in the 'dependencies {}' section:

    classpath 'com.android.tools.build:gradle:4.1.0'
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    classpath 'com.google.gms:google-services:4.3.8'


# The file 'index.html' must include the following

Inside the <head> must include to allow google_sign_in for web app:

      <meta name="google-signin-client_id" content="184015195776-76785j3f2cjcg5032qgleam78tul381s.apps.googleusercontent.com">

Inside the <body> must include the following scripts for firebase/firestore:

    <script src="https://apis.google.com/js/platform.js" async defer></script>
    <script src="https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.6.7/firebase-analytics.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.6.7/firebase-auth.js"></script>
    <script src="https://www.gstatic.com/firebasejs/8.6.7/firebase-firestore.js"></script>

    <script>
    // Your web app's Firebase configuration
    // For Firebase JS SDK v7.20.0 and later, measurementId is optional
    var firebaseConfig = {
      apiKey: "AIzaSyDYqK28Fq7HHjnJo0CKLzuZIxHHCEW83KM",
      authDomain: "fan-app-862ea.firebaseapp.com",
      projectId: "fan-app-862ea",
      storageBucket: "fan-app-862ea.appspot.com",
      messagingSenderId: "935896390156",
      appId: "1:935896390156:web:cf79b82c5329475ac86c29",
      measurementId: "G-WWYRL7GHSH"
    };
    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
    firebase.analytics();
    </script>
