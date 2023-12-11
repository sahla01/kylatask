import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kaylatask/Login_page.dart';
import 'package:kaylatask/add_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchcontroller = TextEditingController();
  double _value = 0.0;
  double _startValue = 0.0; // Add this line
  double _endValue = 50.0;
  CollectionReference _users = FirebaseFirestore.instance.collection('User');

  List<Map<String, dynamic>> userList = [];
  List<Map<String, dynamic>> _filteredUserList = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    _users.snapshots().listen((QuerySnapshot querySnapshot) {
      setState(() {
        userList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        _filteredUserList = List.from(userList);
      });
    });
  }

  void _searchByName(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _filteredUserList = userList
            .where((user) =>
            user['Name'].toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        _filteredUserList = List.from(userList);
      }
    });
  }

  void _filterByAgeRange() {
    setState(() {
      _filteredUserList = userList
          .where((user) =>
      int.parse(user['Age']) >= _startValue.round() &&
          int.parse(user['Age']) <= _endValue.round())
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: TextFormField(
            onChanged: (value) => _searchByName(value),
                // _searchFilter(value),
            controller: searchcontroller,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(),
                filled: true,
                hintText: 'Search',
                fillColor: const Color(0XFFD9D9D9),
                focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(width: 1, color: Colors.grey)),
                enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    )),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                )),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage())));
              },
              icon: Icon(
                Icons.logout,
                size: 25,
                color: Colors.white,
              )),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Text(
                  "Age Range: 0-50",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 30,
                ),
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
                    _filterByAgeRange();
                  },
                  activeColor: Colors.teal,
                  inactiveColor: Colors.grey, // Add this line to set
                )
              ],
            ),
          ),
          Expanded(
            child: Container(

              child: StreamBuilder<QuerySnapshot>(
                stream: _users.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong'),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  userList = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
                  return ListView(
                    children: _filteredUserList.map((user) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.0), color: Colors.white),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: ClipOval(
                                      child: user['Image'] != null
                                          ? Image.network(
                                        user['Image'],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                          : Image.asset('assets/images/user.png', width: 50, height: 50),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(user['Name']),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text(user['Age']),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            width: 140,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddDetailsPage()));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
              ),
              label: Text(
                "Add Student",
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
