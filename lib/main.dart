import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notekepper/views/screens/addnote.dart';
import 'package:notekepper/views/screens/homePage.dart';
import 'package:notekepper/views/screens/logIn.dart';
import 'package:notekepper/views/screens/signUp.dart';
import 'package:notekepper/views/screens/splash.dart';
import 'package:notekepper/views/screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? signUP = prefs.getBool('SignUpVisited') ?? false;
  bool? logIn = prefs.getBool('LoggedInVisit') ?? false;
  bool? splashVisit = prefs.getBool('splashVisit') ?? false;
  bool? welcomeVisit = prefs.getBool('welcome') ?? false;

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: (splashVisit == false)
        ? 'splash'
        : (welcomeVisit == false)
            ? 'welcome'
            : (signUP == false)
                ? 'signUp'
                : (logIn == false)
                    ? 'logIn'
                    : '/',
    theme: ThemeData(
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade500,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)))),
        textTheme: GoogleFonts.poppinsTextTheme()
            .copyWith(titleLarge: const TextStyle(fontStyle: FontStyle.italic)),
        inputDecorationTheme: InputDecorationTheme(
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.brown)),
            labelStyle: const TextStyle(color: Colors.brown),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.brown.shade500)))),
    routes: {
      '/': (context) => const MyApp(),
      'splash': (context) => const Splash(),
      'logIn': (context) => const LogIn(),
      'welCome': (context) => const WelCome(),
      'signUp': (context) => const SignUp(),
      'add': (context) => const Add()
    },
  ));
}
