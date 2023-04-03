import 'package:flutter/material.dart';
import 'package:notekepper/helpers/authHelper.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> logInKey = GlobalKey();

  String? email;
  String? password;
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
          padding: const EdgeInsets.all(20),
          color: Colors.white.withOpacity(0.5),
          child: Form(
            key: logInKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180,
                  child: Text(
                    "Welcome Back!",
                    style:
                        TextStyle(fontSize: 35, color: Colors.brown.shade500),
                  ),
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the E-mail first...";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.brown,
                  decoration: const InputDecoration(
                      label: Text("E-mail"), hintText: "E-mail"),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the password first";
                    } else if (val.length <= 6) {
                      return "password must be more than 6 character";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    password = val;
                  },
                  controller: passwordController,
                  cursorColor: Colors.brown,
                  decoration: const InputDecoration(
                      label: Text("password"), hintText: "Password"),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (logInKey.currentState!.validate()) {
                        logInKey.currentState!.save();

                        Map<String, dynamic> res = await AuthHelper.authHelper
                            .signIn(password: password!, email: email!);

                        if (res['user'] != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("logged in successfully")));
                          Navigator.of(context).pushReplacementNamed('/');
                        } else if (res['error'] != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(res['error']),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("logged in failed")));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 130, vertical: 17)),
                    child: const Text("Log In")),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
