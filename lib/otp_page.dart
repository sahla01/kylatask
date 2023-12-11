import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaylatask/home_page.dart';
import 'package:kaylatask/otp_verify.dart';

class OtpPage extends StatefulWidget {
  static String verify="";
  bool isVerified = false; // Keep track of OTP verification
   OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController phonecontrollers=TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var phone = "";
  final otpKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: otpKey,
        child: Column(
          children: [
            SizedBox(height: 300,),
            Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 25),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
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
                    if (value == null || value.isEmpty) {
                      return "Enter a valid phone number";
                    }
                    else if (value.length < 10 || value.length > 10) {
                      return "phone must be 10 character";
                    }
                    else
                      return null;
                  },
                  controller: phonecontrollers,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number',
                    border: InputBorder.none, // Remove the default underline
                    contentPadding: EdgeInsets.all(10.0),
                ),
              ),
              ),
            ),
            SizedBox(height: 20,),
            InkWell(
                onTap: () async{

                 if(otpKey.currentState!.validate()){

                   String phoneNumber = '+91${phonecontrollers.text}.}';

                   // Check if OTP verification is already done
                   if (!widget.isVerified) {
                     // Perform OTP verification
                     await FirebaseAuth.instance.verifyPhoneNumber(
                       phoneNumber: phoneNumber,
                       verificationCompleted: (PhoneAuthCredential credential) {
                         // OTP verification is completed
                         widget.isVerified = true;
                         // Automatically sign in after OTP verification
                         signInWithPhoneNumber(credential);
                       },
                       verificationFailed: (FirebaseAuthException e) {
                         // Handle verification failure
                         print("Verification Failed: ${e.message}");
                       },
                       codeSent: (String verificationId, int? resendToken) {
                         // Set verificationId for later use
                         OtpPage.verify = verificationId;
                         // Navigate to OTP verification screen
                         Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(builder: (context) => MyVerify()),
                         );
                       },
                       codeAutoRetrievalTimeout: (String verificationId) {
                         // Handle timeout
                         print("Verification Timed Out: $verificationId");
                       },
                     );
                   } else {
                     // OTP is already verified, directly sign in
                     signInWithPhoneNumber(null); // Pass null as credential
                   }
                 }
                  // _showRequestDialog();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,right: 20,top: 13,bottom: 13),
                      child: Text(
                        "Get OTP",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
  void _showRequestDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
             "Get OTP",
            style: TextStyle(
              fontSize: 20
            ),
          ),
          content: Divider(
            height: 80,
            thickness: 2,
            color: Colors.grey[400],

          ),

          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OtpPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30,),
                child: Text(
                   "Done",
                  style: TextStyle(
                    color: Colors.teal
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> signInWithPhoneNumber(PhoneAuthCredential? credential) async {
    try {
      UserCredential? userCredential; // Initialize as nullable

      // Check if credential is provided and perform sign-in accordingly
      if (credential != null) {
        userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        // If no credential provided, handle your specific sign-in logic here
        // For example, using cached credentials or stored information
      }

      // Check if user is successfully logged in
      if (userCredential?.user != null) {
        // User is logged in, navigate to the appropriate screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (e) {
      print("Sign In Failed: $e");
      // Handle sign-in failure
    }
  }
}
