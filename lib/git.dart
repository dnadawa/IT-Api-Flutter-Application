import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class GIT extends StatefulWidget{
  @override
  _GITState createState() => _GITState();
}

class _GITState extends State<GIT> with SingleTickerProviderStateMixin{

  TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(

          centerTitle: true,
          elevation: 0,
          title: new Text("GIT Papers", style: new TextStyle(fontWeight: FontWeight.bold),),
          bottom: TabBar(
              controller: tabController,
              tabs:<Widget>[
                Tab(child: Text("SINHALA",style: TextStyle(fontWeight: FontWeight.bold),),),
                Tab(child: Text("ENGLISH",style: TextStyle(fontWeight: FontWeight.bold),),)
              ] ),
        ),

        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            SinhalaPapers(),
            EnglishPapers()
          ],

        )


    );
  }
}

class SinhalaPapers extends StatefulWidget {

  @override
  _SinhalaPapersState createState() => _SinhalaPapersState();
}

class _SinhalaPapersState extends State<SinhalaPapers> {

  final CollectionReference collectionReference  = Firestore.instance.collection("git_papers");
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

    return Container( child:
    paperlist != null? new GridView.builder(
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

class EnglishPapers extends StatefulWidget {
  @override
  _EnglishPapersState createState() => _EnglishPapersState();
}

class _EnglishPapersState extends State<EnglishPapers> {
  final CollectionReference collectionReference  = Firestore.instance.collection("git_papers_english");
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

    return Container( child:
    paperlist != null? new GridView.builder(
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