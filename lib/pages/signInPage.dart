import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasenotetask/pages/home_page.dart';
import 'package:firebasenotetask/pages/signUpPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';

class SignInPage extends StatefulWidget {
  static const String id = "sign_in_page";
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void>  _doSingIn() async {
    String email = emailController.text.trim().toString();
    String password = passwordController.text.trim().toString();

    if(email.isEmpty || password.isEmpty) {
      // error msg
      return;
    }

    await AuthService.signInUser(email, email, email, password).then((value) => _getFirebaseUser(value));

  }

  void _getFirebaseUser(User? user) {
    if(user != null) {
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      // print error msg
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              // # image container
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/sign in img.png')),
                    borderRadius: BorderRadius.circular(30)),
                // child: Image(image: AssetImage('assets/images/login-ill.jpg')),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Welcome to note app",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),

              // # for email
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Emailingizni kiriting");
                    }

                    // reg expression for email validation
                    if (RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]")
                        .hasMatch(value)) {
                      return ("Xato format");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  textInputAction: TextInputAction.done,
                  controller: emailController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    prefixIcon: Icon(
                      CupertinoIcons.mail,
                    ),
                  ),
                ),
              ),

              // # for password
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                height: 50,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  style: TextStyle(fontSize: 16),
                  validator: (value) {
                    RegExp regex =RegExp(r'^.{6,}$');
                    if (value!.isEmpty){
                      return("Parolni kiritish shart");
                    }
                    if (!regex.hasMatch(value)){
                      return ("Kamida 6 ta belgi bo'lishi kerak");
                    }
                  },
                  onSaved: (value){
                    passwordController.text=value!;
                  },
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    prefixIcon: Icon(
                      CupertinoIcons.lock,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: _doSingIn,

                height: 50,
                color: Colors.deepOrangeAccent,
                textColor: Colors.white,
                shape: StadiumBorder(),
                minWidth: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Sign up",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont have an account?'),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpPage.id);
                      },
                      child: Text("Sign up"))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}