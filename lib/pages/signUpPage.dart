import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasenotetask/pages/signInPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth_services.dart';
import '../services/hive_service.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "sign_up_page";
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void>  _doSingUp() async {
    String firstName = firstNameController.text.trim().toString();
    String lastName = lastNameController.text.trim().toString();
    String email = emailController.text.trim().toString();
    String password = passwordController.text.trim().toString();

    if(email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      // error msg
      return;
    }

    DBService.storeString(StorageKeys.FIRSTNAME, firstName);
    DBService.storeString(StorageKeys.LASTNAME, lastName);

    await AuthService.signUpUser(firstName + " " + lastName, email, password).then((value) => _getFirebaseUser(value));
  }

  void _getFirebaseUser(User? user) {
    if(user != null) {
      Navigator.pushReplacementNamed(context, SignInPage.id);
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
              // # image container
              SizedBox(height: 10,),
              Container(
                height: 230,
                width: 230,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/sign_up_image.png'),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(30)
                ),
                // child: Image(image: AssetImage('assets/images/login-ill.jpg')),
              ),

              // # for Frist name
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 50,
                width: MediaQuery.of(context).size.width*0.9,
                child: TextField(
                  controller: firstNameController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.orange),),
                    hintText: "Frist name",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    prefixIcon: Icon(CupertinoIcons.person,),

                  ),
                ),
              ),

              // # for last name
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 50,
                width: MediaQuery.of(context).size.width*0.9,
                child: TextField(
                  controller: lastNameController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.orange),),
                    hintText: "Last name",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    prefixIcon: Icon(CupertinoIcons.person,),

                  ),
                ),
              ),
              // # for email
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 50,
                width: MediaQuery.of(context).size.width*0.9,
                child: TextField(
                  controller: emailController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.orange),),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    prefixIcon: Icon(CupertinoIcons.mail,),

                  ),
                ),
              ),

              // # for password
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                height: 50,
                width: MediaQuery.of(context).size.width*0.9,
                child: TextField(
                  controller: passwordController,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.orange),),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    prefixIcon: Icon(CupertinoIcons.lock,),

                  ),
                ),
              ),

              // # for confirm password

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Allready have an account?'),
                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Sign in"))
                ],
              ),
              MaterialButton(
                onPressed: _doSingUp,
                height: 45,
                color: Colors.deepOrangeAccent,
                textColor: Colors.white,
                shape: StadiumBorder(),
                minWidth: MediaQuery.of(context).size.width*0.8,
                child: Text("Sign up", style: TextStyle(fontSize: 18),),
              ),

            ],
          ),
        ),
      ),
    );
  }
}