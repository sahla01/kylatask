import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class UserManagement {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('User');

  var id=Uuid().v1();

  Future<void> uploadImageAndUserData({
    required String name,
    required String age,
    required String imagePath,
  }) async {
    String fileName = DateTime.now().toString();
    var ref = FirebaseStorage.instance.ref().child("profilephoto/$fileName");
    File imageFile = File(imagePath);

    try {
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String url = await ref.getDownloadURL();

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = id;
        await usersCollection.doc(userId).set({
          "Name": name,
          "Age": age,
          "Image": url,
        });

        Fluttertoast.showToast(
          msg: "Registration Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Registration failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }}