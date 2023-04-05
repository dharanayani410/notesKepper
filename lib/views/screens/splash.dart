import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  checkPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('splashVisit', false);

    Timer(Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacementNamed('welcome');
    });
  }

  @override
  void initState() {
    super.initState();
    checkPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 2),
              builder: (context, val, widget) {
                return Transform.scale(
                  scale: val,
                  child: Image.asset(
                    "assets/images/firebase.png",
                    fit: BoxFit.cover,
                  ),
                );
              }),
        ),
        Container(
          color: Colors.white.withOpacity(0.8),
        ),
        Image.asset(
          "assets/images/logo.png",
          height: 150,
          width: 150,
        ),
        Align(
          alignment: const Alignment(0, 0.25),
          child: Text(
            "Notes",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.brown.shade500),
          ),
        )
      ]),
    );
  }
}
