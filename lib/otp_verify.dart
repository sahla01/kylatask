import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaylatask/otp_page.dart';
import 'package:pinput/pinput.dart';

import 'home_page.dart';




class MyVerify extends StatefulWidget {
  const MyVerify({Key? key,}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> onCustomWillPop(BuildContext context) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyVerify()));
    return true;
  }
  @override
  Widget build(BuildContext context) {
  var code = "";
    return WillPopScope(
      onWillPop: () => onCustomWillPop(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OtpPage()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 22,
            ),
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Container(
          //margin: EdgeInsets.only(left: 5.5 * SizeConfigure.widthMultiplier!,
              //right:5.5 * SizeConfigure.widthMultiplier!),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(height: 15,),
                Text(
                  "Enter OTP",style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),

                ),
                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Pinput(
                    length: 6,
                    showCursor: true,
                    onCompleted: (pin) => print(pin),
                    onChanged: (value){
                      code = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: () async {
                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(
                              verificationId: OtpPage.verify,
                              smsCode: code
                          );
                          await auth.signInWithCredential(credential);
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                        }
                        catch(e){
                          print("wrong otp");
                        }
                      },
                      child: Text("Done",style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
