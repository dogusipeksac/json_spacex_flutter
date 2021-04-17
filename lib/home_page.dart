import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spacex_flutter_app/style/styles.dart';
import 'Api/connection.dart';
import 'model/spacex.dart';

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
                        Text(
                          "Name: ${snapshot.data.name}",
                          style: styleText,
                        ),
                        Text(
                          "Detail: ${snapshot.data.details} ",
                          style: styleText,
                        ),
                        Expanded(
                          child: Image.network(
                              snapshot.data.links.patch.large.toString()),
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
