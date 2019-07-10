import 'package:flutter/material.dart';

class AboutUS extends StatefulWidget {
  @override
  _AboutUSState createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          centerTitle: true,
          elevation: 0,
          title: new Text(
        "About Us",
        style: new TextStyle(fontWeight: FontWeight.bold),
      )),
      body: new Container(

        child: new ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: new Image(
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: new Text("We developed this app to help local ICT students who are "
                  "facing the A/L exam. Our main goal is to improve thier output, "
                  "writing ability and help them to face the exam with confidence. "
                  "This app gives you direct access to lots of island wide school papers,past papers,model papers & Notes. Help your self out and good luck !"
              ,style: TextStyle(fontSize: 15,color: Colors.grey),textAlign: TextAlign.justify,),
            )
          ],
        ),
      ),
    );
  }
}
