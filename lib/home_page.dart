import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:spacex_flutter_app/style/styles.dart';
import 'model/spacex.dart';
import 'dart:convert';



Future<Spacex> apiCallSpacex() async {
  final response =
  await http.get('https://api.spacexdata.com/v4/launches/latest');
  if (response.statusCode == 200) {
    return Spacex.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Spacex"),),
      body: FutureBuilder<Spacex>(
        future: apiCallSpacex(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Text(
                              "Name: ${snapshot.data.name}",
                              style: styleText,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Text(
                              "Detail: ${snapshot.data.details} ",
                              style: styleText,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(30),),
                              child: Image.network(
                                  snapshot.data.links.patch.large.toString()),
                            ),
                          ),
                        ),
                      ]),
                ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
