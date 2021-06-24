# fan_page_app

This app is setup to run on android and web app platforms.

Since we are using google_sign_in import: 

    import 'package:google_sign_in/google_sign_in.dart';

The app must be run with: 
    
    flutter run --no-sound-null-safety

If the above command does not work, go to settings -> Workspace -> Dark & Flutter.
Look for Dart: Flutter Additional Args and click Add Item to insert "--no-sound-null-safety". Do the same for Dart: Analyzer Additional Args

If it still does not work, go to 'settings.json' and add the following:

    "dart.flutterRunAdditionalArgs": [
        "--no-sound-null-safety"
    ],
    "dart.vmAdditionalArgs": [
        "--no-sound-null-safety"
    ]


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

# flutter sdk version 
sdk: ">=2.12.0 <3.0.0"

# These are the versions used for firebase and google_sign_in
  firebase_core: ^1.3.0
  firebase_auth: ^1.4.1
  cloud_firestore: ^2.2.2
  google_sign_in: "^4.5.1"
  flutter_signin_button: ^2.0.0 
  # the flutter_sign_in_button is used for the google log in button 

In the build.gradle file under the 'android/app' folder, add these implementations under dependencies {} section:
# these are all for firebase and google
    implementation platform('com.google.firebase:firebase-bom:28.1.0')
    implementation 'com.google.firebase:firebase-analytics-ktx'
    implementation 'com.android.support:multidex:1.0.3'
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"

    // Declare the dependency for the Firebase Authentication library
    // When using the BoM, you don't specify versions in Firebase library dependencies
    implementation 'com.google.firebase:firebase-auth'

    // Also declare the dependency for the Google Play services library and specify its version
    implementation 'com.google.android.gms:play-services-auth:19.0.0'

Do the same for the other build.gradle file that is inside the 'android' folder, add these implementations under dependencies {} section:
# for google services 
    classpath 'com.android.tools.build:gradle:4.1.0'
    classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    classpath 'com.google.gms:google-services:4.3.8'


