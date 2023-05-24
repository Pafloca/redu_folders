import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:users_login_db/users/authentication/signup_screeen.dart';
import 'package:users_login_db/api/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:users_login_db/users/fragments/dashboard_of_fragments.dart';
import 'package:users_login_db/users/userPreferences/user_preferences.dart';

import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(title: const Text("Sign In"),
        automaticallyImplyLeading: false
        ,centerTitle: true,
        backgroundColor: Color(0xFF1C8750),),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  loginUserNow() async {
    try {
      var res = await http.post(
        Uri.parse(API.login),
        body: {
          "user_email": emailController.text.trim(),
          "user_password": passwordController.text.trim(),
        },
      );

      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        print(data);

        if (data["success"] == true) {
          Fluttertoast.showToast(msg: "Login Successfully");
          print(data["userData"]);
          User userInfo = User.fromJson(data["userData"]);
          await RememberUserPrefs.storeUserInfo(userInfo);

          Get.to(DashboardOfFragments());

        } else {
          Fluttertoast.showToast(
              msg: "Writte correct password or email. Try Again");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
              msg: "Writte correct password. Try Again");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Image.asset(
            "images/redulogolong.png",
            width: 300,
            height: 100,
          )
              ),

            Form(
                key: formKey,
                child: Column(
                  children: [

                    TextFormField(
                        controller: emailController,
                        /*validator: (val) =>
                            val == "" ? "Please write email" : null,*/
                        validator: (value){
                          if (value == null || value.isEmpty) {
                            return'Sorry, user can\'t be empty.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        )
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sorry, user can\'t be empty.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 15,),
                    Material(
                        child: ElevatedButton(
                          child: const Text('Login',style: TextStyle(fontSize: 16)),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              loginUserNow();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(450, 20),
                            foregroundColor: Colors.white, backgroundColor: Color(0xFF1C8750),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            elevation: 5,
                          ),
                        )),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Does not have account?',style: TextStyle(fontSize: 16)),
                TextButton(
                  child: const Text('Sign Up',
                    style: TextStyle(
                        fontSize: 20,color: Color(0xFF1C8750)),
                  ),
                  onPressed: () {
                    Get.to(SignUpScreen());
                  },
                )
              ],
            ),
          ],
        ));
  }
}
