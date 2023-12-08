import 'package:flutter/material.dart';

import 'home_page.dart';

class AddDetailsPage extends StatefulWidget {
  const AddDetailsPage({super.key});

  @override
  State<AddDetailsPage> createState() => _AddDetailsPageState();
}

class _AddDetailsPageState extends State<AddDetailsPage> {
  TextEditingController namecontroller =TextEditingController();
  TextEditingController agecontroller =TextEditingController();
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
            Container(
             height: 120,
             width: 120,
             decoration: BoxDecoration(
               color: Colors.teal,
               borderRadius: BorderRadius.all(Radius.circular(70)),
               border: Border.all(
                 color: Colors.black
               )
             ),
             child: Stack(
               children: [
                 Center(child: Icon(Icons.image,color: Colors.white,size: 35,)),
                 Positioned(
                   right: 33,
                     top: 33,
                     child: Icon(Icons.add,color: Colors.white,))
               ],
            ),
              ),
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
                  keyboardType: TextInputType.phone,
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
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
}
