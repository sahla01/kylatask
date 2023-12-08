import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController phonecontrollers=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                keyboardType: TextInputType.emailAddress,
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
              onTap: () {
                _showRequestDialog();
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
             "Diet Plan Request",
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
}
