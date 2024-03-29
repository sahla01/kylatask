import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kaylatask/Login_page.dart';
import 'package:kaylatask/home_page.dart';
import 'package:kaylatask/otp_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _signUpkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _signUpkey,
          child: Column(
            children: [
              SizedBox(height: 70),
              Center(
                child: Text(
                  "Hello!",
                  style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              Text(
                "Welcome back",
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !value.contains('@') ||
                          !value.contains('.')) {
                        return "Enter a Valid email";
                      }
                    },
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: InputBorder.none, // Remove the default underline
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty || value!.length<6) {
                        return "Enter  password does not match";
                      } else
                        return null;
                    },
                    controller: passwordcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: InputBorder.none, // Remove the default underline
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                  onTap: () {
                    if(_signUpkey.currentState!.validate()){
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: emailcontroller.text, password: passwordcontroller.text)
                          .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                              (route) => false));
                    }

                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondLoginScreen()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 95, right: 95, top: 13, bottom: 13),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 75),
                child: Row(
                  children: [
                    Text(
                      "Dont have an account?",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                            color: Colors.teal, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 100,
                thickness: 2,
                color: Colors.grey[400],
                endIndent: 50,
                indent: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 130),
                child: Row(
                  children: [
                    InkWell(
                      onTap:(){
                        signInWithGoogle(context);
                      },
                      child: Image.asset('assets/images/googleimg.png',
                        height: 25,),
                    ),
                    SizedBox(width: 50,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpPage()));
                      },
                      child: Image.asset('assets/images/smartphone-call.png',
                        height: 25,),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
  Future<void> signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCredential.user != null) {
      String displayName = userCredential.user!.displayName ?? 'Unknown User';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged in as $displayName'),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  HomePage(),
        ),
      );
    } else {
      print('Sign-in failed');
    }
  }
}
