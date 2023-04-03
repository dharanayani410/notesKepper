import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notekepper/views/screens/homePage.dart';
import 'package:notekepper/views/screens/logIn.dart';
import 'package:notekepper/views/screens/signUp.dart';
import 'package:notekepper/views/screens/splash.dart';
import 'package:notekepper/views/screens/welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash',
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade500,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
          textTheme: GoogleFonts.poppinsTextTheme().copyWith(
              titleLarge: const TextStyle(fontStyle: FontStyle.italic)),
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
        'signUp': (context) => const SignUp()
      },
    );
  }
}
