import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo', 
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                TextField(
                  
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    //Do something with the user input.
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your email')
                ),
               const  SizedBox(
                  height: 8.0,
                ),
                TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'Enter your password')
                ),
                const SizedBox(
                  height: 24.0,
                ),
                RoundedButton(buttonTitle: 'Log In', color: Colors.lightBlueAccent, onPressed: () async{
                  setState(() {
                    showSpinner = true;
                   });
                    try{
                      final user =await _auth.signInWithEmailAndPassword(email: email, password: password);
                    if(user!=null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                      setState(() {
                        showSpinner = false;
                      });
                    }catch (e){
                      print(e);
                    }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}