import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class ModelPapers extends StatefulWidget {
  @override
  _ModelPapersState createState() => _ModelPapersState();
}

class _ModelPapersState extends State<ModelPapers> {

  final CollectionReference collectionReference  = Firestore.instance.collection("model_papers");
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
    subscription = collectionReference.orderBy("name",descending: true).snapshots().listen((datasnapshot){
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
            title: new Text("Model Papers", style: new TextStyle(fontWeight: FontWeight.bold),)
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
