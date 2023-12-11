import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaylatask/Login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
                    if (value == null || value.isEmpty) {
                      return "Enter a Valid Password";
                    }
                    else if (value.length < 8) {
                      return "password must be 8 characters";
                    }
                    else
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
              // onTap: (){
              //   if (emailcontroller.text.isNotEmpty &&
              //       passwordcontroller.text.isNotEmpty
              //      ) {
              //     // Check if _image is not null
              //     // userManagement.uploadImageAndUserData(
              //     //   name: namecontroller.text,
              //     //   age: agecontroller.text,
              //     //   imagePath: imagePath,
              //     // );
              //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
              //   } else {
              //     Fluttertoast.showToast(
              //       msg: "username and password can't be empty",
              //       toastLength: Toast.LENGTH_SHORT,
              //       gravity: ToastGravity.CENTER,
              //       timeInSecForIosWeb: 1,
              //       backgroundColor: Colors.red,
              //       textColor: Colors.white,
              //       fontSize: 16.0,
              //     );
              //   }
              // },
                onTap: () {
                  registerWithEmailAndPassword(emailcontroller.text, passwordcontroller.text, context);
                  // FirebaseAuth.instance
                  //     .createUserWithEmailAndPassword(
                  //         email: emailcontroller.text,
                  //     password: passwordcontroller.text)
                  //     .then((value) => Navigator.pushAndRemoveUntil(
                  //         context,
                  //         MaterialPageRoute(builder: (context) => LoginPage(
                  //         )),
                  //         (route) => false));

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
                  Image.asset(
                    'assets/images/googleimg.png',
                    height: 25,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Image.asset(
                    'assets/images/smartphone-call.png',
                    height: 25,
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
  void registerWithEmailAndPassword(
      String email,String password,BuildContext context) async {
    try {
      UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword
        (email: email, password: password);
       Fluttertoast.showToast(
         msg: "All fields are mandatory!",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.CENTER,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0,
       );
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
    }
    catch(e){
      Fluttertoast.showToast(
        msg:e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
