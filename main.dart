import 'dart:async';
import 'package:bhs_vendor/Helper/HelperFunction.dart';
import 'package:bhs_vendor/Screens/Dashboard.dart';
import 'package:bhs_vendor/Screens/Homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(FirebasePhoneAuthProvider(
    child: MaterialApp(
        home:MyApp()),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isloading=true;
  bool _isLoggedIn=false;
  String? username;
  getloggedInState() async {
    var LoginState = await sf.getUserLoggedInState();
    setState(() {
      if (LoginState != null) {
        _isLoggedIn = LoginState;
        if (_isLoggedIn == true) {
          getUsername();
        }
        _isloading = false;
      } else {
        setState(() {
          _isloading = false;
        });
      }
    });
  }
  getUsername() async {
    var number = await sf.getUserNameFromSharedPrefrence();
    print(number);
   // var address = await HelperFunctions.getAddress();
  //  var locality = await HelperFunctions.getLocality();
  //   print(locality);
  //   print(address);

    setState(() {
      if (number != null) {
        username = number;
        // Address = address!;
        // Locality = locality!;
        _isloading = false;
      } else {
        setState(() {
          _isloading = false;
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    getloggedInState();

    Timer(Duration(seconds: 3),
            ()=>
             _isLoggedIn!=true&&username==null?Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                Homescreen()
            )
        ):Navigator.pushReplacement(context,
                 MaterialPageRoute(builder:
                     (context) =>
                     Dashboard(username)
                 )
             )

    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("Assets/Splash.png")
        ],
      )
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
