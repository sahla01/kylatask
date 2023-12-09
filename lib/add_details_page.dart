
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page.dart';
import 'modelclass.dart';

class AddDetailsPage extends StatefulWidget {
  const AddDetailsPage({super.key});

  @override
  State<AddDetailsPage> createState() => _AddDetailsPageState();
}

class _AddDetailsPageState extends State<AddDetailsPage> {
  TextEditingController namecontroller =TextEditingController();
  TextEditingController agecontroller =TextEditingController();
  String? imgB64;
  XFile? _image;
  UserManagement userManagement = UserManagement();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70,),
            Center(
              child: Text("Enter User Details!",
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),),
            ),
            SizedBox(height: 50,),
            InkWell(
                onTap: (){
                  showimage();
                },
                child:
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.teal,
                  child: ClipOval(
                    child: _image != null // Case 1: Editing with local image
                        ? Image.file(
                      File(_image!.path),
                      fit: BoxFit.cover,
                      height: 95,
                      width: 95,

                    ):
                    Icon(Icons.image,color: Colors.white,size: 35,),
                  ),
                )),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextFormField(
                  validator: (value) {
                    if (value != namecontroller.text) {
                      return "Enter a valid name ";
                    }

                    else
                      return null;
                  },
                  cursorColor: const Color(0xff565353),
                  controller: namecontroller,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 13),
                      isDense: true,
                      filled: true,
                      fillColor: const Color(0xffF4F6FF),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffEF2253),width: 0.5)),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderSide:BorderSide(color:Color(0xffEF2253), width: 0.5),),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 0.5, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 2, color: Colors.teal),
                          borderRadius:
                          BorderRadius.circular(10)),
                      hintStyle:const TextStyle(
                          fontSize: 12, color:Colors.grey),
                      hintText: 'Name',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25,right: 25),
              child: TextFormField(
                  validator: (value) {
                    if (value != namecontroller.text) {
                      return "Enter a valid age ";
                    }

                    else
                      return null;
                  },
                  cursorColor: const Color(0xff565353),
                  controller: agecontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 13),
                    isDense: true,
                    filled: true,
                    fillColor: const Color(0xffF4F6FF),
                    errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffEF2253),width: 0.5)),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide:BorderSide(color:Color(0xffEF2253), width: 0.5),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 0.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2, color: Colors.teal),
                        borderRadius:
                        BorderRadius.circular(10)),
                    hintStyle:const TextStyle(
                        fontSize: 12, color:Colors.grey),
                    hintText: 'Age',
                  )),
            ),
            SizedBox(height: 70,),
            InkWell(
                onTap: () {
                  if (namecontroller.text.isNotEmpty &&
                      agecontroller.text.isNotEmpty &&
                      _image != null) {  // Check if _image is not null
                    String imagePath = _image!.path;
                    userManagement.uploadImageAndUserData(
                      name: namecontroller.text,
                      age: agecontroller.text,
                      imagePath: imagePath,
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  } else {
                    Fluttertoast.showToast(
                      msg: "All fields are mandatory!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },

                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 110,right: 110,top: 13,bottom: 13),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ))),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }),
    );
  }

  _imagefromgallery() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50
    );
    Uint8List imagebytes = await image!.readAsBytes();
    String base64String = base64.encode(imagebytes);
    setState(() {
      _image = image;
      imgB64 = base64String;
      print(_image);
      print('abfcvfdd');
    });
  }

  _imagefromcamera() async {
    final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 50
    );
    Uint8List imagebytes = await image!.readAsBytes();
    String base64String = base64.encode(imagebytes);
    setState(() {
      _image = image;
      imgB64 = base64String;
    });
  }

  showimage() {
    showModalBottomSheet(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.pink,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromcamera();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.camera_alt_rounded,
                              color: Colors.white),
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("camera"),
                    ],
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      Ink(
                        decoration: const ShapeDecoration(
                          color: Colors.purple,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _imagefromgallery();
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.photo),
                          color: Colors.white,
                          iconSize: 20,
                          splashRadius: 40,
                        ),
                      ),
                      Text("gallery"),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

}
