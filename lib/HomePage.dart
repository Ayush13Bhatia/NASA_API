import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gradient_widgets/gradient_widgets.dart';

import 'package:cached_network_image/cached_network_image.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List usersData;
  bool isLoading = true;
  // final String url = "https://randomuser.me/api/?results=50";
  final String url =
      "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY";

  Future getData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    List data = jsonDecode(response.body)['photos'];
    // print(data.toString());
    setState(() {
      usersData = data;
      isLoading = false;
    });
  }

  // Future<Map> getData() async {
  //   String url =
  //       "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY";
  //   http.Response response = await http.get(url);
  //   return json.decode(response.body);
  //   // setState(() {
  //   //   usersData = data;
  //   //   isLoading = false;
  //   // });
  //   // print(data);
  //   // return data;
  // }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Users"),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: usersData == null ? 0 : usersData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20.0),
                            child: Image(
                              width: 70.0,
                              height: 70.0,

                              fit: BoxFit.contain,
                              // image: AssetImage('assets/logo.png'),
                              image: NetworkImage(
                                  // "https://mars.nasa.gov/msl-raw-images/proj/msl/redops/ods/surface/sol/01000/opgs/edr/fcam/FLB_486265257EDR_F0481570FHAZ00323M_.JPG",
                                  // "https://animals.sandiegozoo.org/sites/default/files/2016-09/animals_hero_black_rhino_0.jpg"
                                  usersData[index]['img_src']),
                              // image: NetworkImage(
                              //     // '${userdata[index]['img_src']}'
                              //     // usersData[index]['picture']['thumbnail']
                              //     ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    "Rover: ${usersData[index]['camera']['full_name']}"),
                                Image.network(
                                    "https://animals.sandiegozoo.org/sites/default/files/2016-09/animals_hero_black_rhino_0.jpg"
                                    // "Gender: ${usersData[index]['img_src']}"
                                    ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
    //     //  Card(
    //     //   elevation: 16.0,
    //     //   margin: EdgeInsets.all(12.0),
    //     // );

    //     // Scaffold(
    //     //     appBar: AppBar(
    //     //       title: Text("Random Users"),
    //     //     ),
    //     //     body: FutureBuilder(
    //     //         future: getData(),
    //     //         builder: (context, snapshot) {
    //     //           Map data = snapshot.data;
    //     //           if (snapshot.hasError) {
    //     //             print(snapshot.error);
    //     //             return Text("Failed to get response from the server",
    //     //                 style: TextStyle(color: Colors.red, fontSize: 22.0));
    //     //           } else if (snapshot.data) {
    //     //             return Center(
    //     //               child: ListView.builder(
    //     //                   itemCount: data.length,
    //     //                   itemBuilder: (context, index) {
    //     //                     return Column(
    //     //                       children: [
    //     //                         Padding(padding: const EdgeInsets.all(5.0)),
    //     //                         Container(
    //     //                           child: InkWell(
    //     //                             onTap: () {},
    //     //                             child: Image.network(
    //     //                                 '${data['photos'][index]['img_src']}'),
    //     //                           ),
    //     //                         )
    //     //                       ],
    //     //                     );
    //     //                   }),
    //     //             );
    //     //           }
    //     //         })
    //     Container(
    //   child: Center(
    //     child: isLoading
    //         ? CircularProgressIndicator()
    //         : PageView.builder(
    //             scrollDirection: Axis.vertical,
    //             controller: PageController(
    //               viewportFraction: 0.8,
    //             ),
    //             itemCount: usersData == null ? 0 : usersData.length,
    //             itemBuilder: (context, index) {
    //               return GradientCard(
    //                 child: Row(
    //                   children: <Widget>[
    //                     Container(
    //                       margin: EdgeInsets.all(20.0),
    //                       child: Image(
    //                         width: 30.0,
    //                         height: 30.0,
    //                         alignment: Alignment.center,
    //                         fit: BoxFit.contain,

    //                         image: NetworkImage(
    //                           usersData[index]['img_src'],
    //                         ),
    //                         // image: AssetImage('${usersData[index]['img_src']}'),
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: <Widget>[
    //                           // Text(
    //                           //   usersData[index]['camera']['full_name'],
    //                           //   // " " +
    //                           //   // usersData[index]['name']['last'],
    //                           //   style: TextStyle(
    //                           //       fontSize: 20.0,
    //                           //       fontWeight: FontWeight.bold),
    //                           // ),
    //                           Text(
    //                               "Rover: ${usersData[index]['rover']['name']}"),
    //                           Text(
    //                               "Lading Date: ${usersData[index]['rover']['landing_date']}"),
    //                         ],
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //               );
    //             },
    //           ),
    //   ),
    // );
  }
}
