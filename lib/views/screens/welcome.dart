import 'package:flutter/material.dart';

import '../../helpers/authHelper.dart';

class WelCome extends StatefulWidget {
  const WelCome({Key? key}) : super(key: key);

  @override
  State<WelCome> createState() => _WelComeState();
}

class _WelComeState extends State<WelCome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            "assets/images/firebase.png",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.white.withOpacity(0.8),
        ),
        Image.asset(
          "assets/images/logo.png",
          height: 150,
          width: 150,
        ),
        Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.brown.shade500,
                        fontSize: 50,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('signUp');
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 89, vertical: 17)),
                          child: const Text("Create An Account")),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed('logIn');
                          },
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 130, vertical: 17)),
                          child: const Text("Sign In")),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                          "-------------------  OR  -------------------"),
                      GestureDetector(
                        onTap: () async {
                          Map<String, dynamic> res =
                              await AuthHelper.authHelper.signInWithGoogle();

                          if (res['user'] != null) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text("Login Successful With Google....."),
                              behavior: SnackBarBehavior.floating,
                            ));
                            Navigator.of(context).pushReplacementNamed('/',
                                arguments: res['user']);
                          } else if (res['error'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(res['error']),
                              behavior: SnackBarBehavior.floating,
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Login Failed With Google....."),
                              behavior: SnackBarBehavior.floating,
                            ));
                          }

                          print("dhara");
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.brown,
                          ),
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                height: 30,
                                width: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "Continue with Google",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))
      ]),
    );
  }
}
