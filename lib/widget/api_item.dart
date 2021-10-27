import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiItem extends StatefulWidget {
  ApiItem({Key? key}) : super(key: key);

  @override
  State<ApiItem> createState() => _ApiItemState();
}

class _ApiItemState extends State<ApiItem> {
  List userData = [];
  var url = Uri.parse(
      'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY');

  Future getData() async {
    var response = await http.get(url);
    List data = jsonDecode(response.body)['photos'];

    setState(() {
      userData = data;
    });

    print(data);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final curScaleFactor = mediaQuery.textScaleFactor * 0.9;
    return ListView.builder(
      itemCount: userData.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.orangeAccent[50],
          elevation: 5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Camera',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Name:- ${userData[index]['camera']['name']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Full Name:- ${userData[index]['camera']['full_name']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: mediaQuery.size.width * 0.7,
                      height: mediaQuery.size.height * 0.5,
                      margin: const EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Center(
                          child: Image(
                            height: mediaQuery.size.height * 0.7,
                            width: mediaQuery.size.width * 0.7,
                            fit: BoxFit.cover,
                            image: NetworkImage(userData[index]['img_src']
                                // "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1770&q=80"),
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Rover',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Rover:- ${userData[index]['rover']['name']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Status:- ${userData[index]['rover']['status']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Land Date:- ${userData[index]['rover']['landing_date']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16 * curScaleFactor,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          'Launch Data:- ${userData[index]['rover']['launch_date']}',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16 * curScaleFactor,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
