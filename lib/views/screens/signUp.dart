import 'package:flutter/material.dart';
import 'package:notekepper/helpers/authHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> signUpKey = GlobalKey();

  String? user;
  String? email;
  String? password;
  String? confPassword;

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
          child: SingleChildScrollView(
              child: Form(
            key: signUpKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 180,
                  child: Text(
                    "Register",
                    style:
                        TextStyle(fontSize: 35, color: Colors.brown.shade500),
                  ),
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the user first..";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    user = val;
                  },
                  controller: userController,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.brown,
                  decoration: const InputDecoration(
                      label: Text("User Name"),
                      hintText: "User Name",
                      hintStyle: TextStyle(color: Colors.brown)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the email first..";
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
                      label: Text("E-mail"),
                      hintText: "E-mail",
                      hintStyle: TextStyle(color: Colors.brown)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: Validators.compose([
                    Validators.required("Enter the password first .."),
                    Validators.minLength(
                        6, "password must be more than 5 character.."),
                    Validators.patternString(
                        r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$',
                        "must be required special characters and numbers..")
                  ]),
                  onSaved: (val) {
                    password = val;
                    print(val);
                  },
                  controller: passwordController,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.brown,
                  decoration: const InputDecoration(
                      label: Text("password"),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.brown)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter the password repeat..";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    confPassword = val;
                  },
                  controller: confirmPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.brown,
                  obscureText: false,
                  decoration: const InputDecoration(
                      label: Text("Confirm password"),
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(color: Colors.brown)),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (signUpKey.currentState!.validate()) {
                        signUpKey.currentState!.save();

                        Map<String, dynamic> res = await AuthHelper.authHelper
                            .signUp(password: password!, email: email!);

                        if (res['user'] != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("sign up successfully")));
                          Navigator.of(context).pushReplacementNamed('logIn');
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
                              const SnackBar(content: Text("sign up failed")));
                        }
                      }
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('SignUpVisited', true);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 130, vertical: 17)),
                    child: const Text("Sign Up")),
              ],
            ),
          ))),
    ]));
  }
}
