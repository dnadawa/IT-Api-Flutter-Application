import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
          centerTitle: true,
        elevation: 0,
          title: new Text(
        "Notes",
        style: new TextStyle(fontWeight: FontWeight.bold),
      )),
      body: new Container(
        child: new Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new Text(
              "THE PAGE IS STILL DEVELOPING!",
              style: new TextStyle(fontSize: 50,fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,

              
            ),
            new Text(
              "\nThis will availiable in future updates.",
              style: new TextStyle(fontSize: 18,color: Colors.grey),
              textAlign: TextAlign.center,

            ),
            new Container(
              padding: const EdgeInsets.all(15.0),
              child: new Image(image: AssetImage("assets/come.gif")),
            )
          ],
        )),
      ),
    );
  }
}
