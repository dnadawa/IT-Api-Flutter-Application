//import 'package:flutter/material.dart';
//
//class Notes extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      backgroundColor: Colors.white,
//      appBar: new AppBar(
//          centerTitle: true,
//        elevation: 0,
//          title: new Text(
//        "Notes",
//        style: new TextStyle(fontWeight: FontWeight.bold),
//      )),
//      body: new Container(
//        child: new Center(
//            child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//
//            new Text(
//              "THE PAGE IS STILL DEVELOPING!",
//              style: new TextStyle(fontSize: 50,fontWeight: FontWeight.bold),
//              textAlign: TextAlign.center,
//
//
//            ),
//            new Text(
//              "\nThis will availiable in future updates.",
//              style: new TextStyle(fontSize: 18,color: Colors.grey),
//              textAlign: TextAlign.center,
//
//            ),
//            new Container(
//              padding: const EdgeInsets.all(15.0),
//              child: new Image(image: AssetImage("assets/come.gif")),
//            )
//          ],
//        )),
//      ),
//    );
//  }
//}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  final CollectionReference collectionReference  = Firestore.instance.collection("notes");
  List<DocumentSnapshot> paperlist;
  StreamSubscription<QuerySnapshot> subscription;



  Future launchURL(String url) async{
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = collectionReference.orderBy("name",descending: false).snapshots().listen((datasnapshot){
      setState(() {
        paperlist = datasnapshot.documents;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();

  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            centerTitle: true,
            elevation: 0,
            title: new Text("Notes", style: new TextStyle(fontWeight: FontWeight.bold),)
        ),

        body: paperlist != null? new GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: paperlist.length,
          padding: const EdgeInsets.all(10.0),

          itemBuilder: (context,i){
            String imgPath = paperlist[i].data['image'];
            String filePath = paperlist[i].data['file'];
            return new GestureDetector(
              onTap: ()=>{launchURL(filePath)},
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 7.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: new FadeInImage(
                    placeholder: new AssetImage("assets/logo.png"),
                    image: new NetworkImage(imgPath),
                    fit: BoxFit.cover,

                  ),
                ),
              ),
            );
          },
        ): new Center(child: CircularProgressIndicator())


    );
  }
}
