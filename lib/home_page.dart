import 'package:flutter/material.dart';
import 'package:kaylatask/add_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchcontroller =TextEditingController();
  double _value = 0.0;
  double _startValue = 0.0; // Add this line
  double _endValue = 50.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Container(
          width:MediaQuery.of(context).size.width*0.9,
          child: TextFormField(
            controller: searchcontroller,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                ),
                filled: true,
                hintText: 'Search',
                fillColor: const Color(0XFFD9D9D9),
                focusedBorder: const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(width:1,color: Colors.grey)),
                enabledBorder: const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      color: Colors.grey, )),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )
            ),


          ),
        ),
        actions: [
          IconButton(
              onPressed: ()
              {
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewNotification()));
              },
              icon: Icon(
                Icons.logout,
                size: 25,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Row(
                children: [
                  Text("Age Range: 0-50",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(width: 30,),
              RangeSlider(
                min: 0.0,
                max: 50.0,
                divisions: 10,
                labels: RangeLabels(
                  _startValue.round().toString(),
                  _endValue.round().toString(),
                ),
                values: RangeValues(
                  _startValue.clamp(0.0, 50.0),
                  _endValue.clamp(0.0, 50.0),
                ),
                onChanged: (values) {
                  setState(() {
                    _startValue = values.start.clamp(0.0, 50.0);
                    _endValue = values.end.clamp(0.0, 50.0);
                  });
                },
                activeColor: Colors.teal,
                inactiveColor: Colors.grey, // Add this line to set

              )
                ],
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Card(
                          color: Color(0xffeae9e9),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              )),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset('assets/images/fitnesimg1.png',
                                      height: 25,),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    flex:2,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                               Text("sahla",
                                                 style: TextStyle(
                                                   color: Colors.grey
                                               ),
                                                   ),
                                                SizedBox(height: 10,),
                                                Text("26",
                                                  style: TextStyle(
                                                      color: Colors.grey
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 90),
        child: FloatingActionButton.extended(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddDetailsPage()));
          },
          label: Text("Add Student",style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.teal,

            ),
      ),
    );
  }
}
