import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';


class TermTestPapers extends StatefulWidget {
  @override
  _TermTestPapersState createState() => _TermTestPapersState();
}

class _TermTestPapersState extends State<TermTestPapers> {

  final CollectionReference collectionReference  = Firestore.instance.collection("term_test");

  StreamSubscription<QuerySnapshot> subscription;
  List<DocumentSnapshot> paperlist;











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
  Icon _searchIcon = Icon(Icons.search);
  Widget _title = new Text("Term Test Papers", style: new TextStyle(fontWeight: FontWeight.bold),);
  final TextEditingController _filter = new TextEditingController();

  _TermTestPapersState(){
  _filter.addListener(() {
  if (_filter.text.isEmpty) {
    setState(() {

      subscription = collectionReference.orderBy("name",descending: true).snapshots().listen((datasnapshot){
        setState(() {
          paperlist = datasnapshot.documents;
        });
      });
   });
  } else {
  setState(() {
    subscription = collectionReference.where('name', isGreaterThanOrEqualTo: _filter.text).snapshots().listen((datasnapshot){
      setState(() {
        paperlist = datasnapshot.documents;
      });
    });
  });


//  for(int i=0; i <paperlist.length;i++){
//    if(paperlist[i].data['name'].toString().toLowerCase().contains(_filter.text.toLowerCase())){
//
//    }
//  }

  }
  });}

 Widget appbar(BuildContext context){
   return new AppBar(

     actions: <Widget>[
       IconButton(icon: _searchIcon, onPressed: ()=>_searchPressed()),
       Padding(padding: EdgeInsets.symmetric(horizontal: 2))
     ],
     centerTitle: true,
     elevation: 0,
     title: _title

   );
 }




  void _searchPressed() {

    setState(() {
      if (this._searchIcon.icon == Icons.search) {

        this._searchIcon = new Icon(Icons.close, color: Colors.white,);
        this._title = new TextField(

          controller: _filter,

          style: new TextStyle(
            color: Colors.white,


          ),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: "Search...",

              hintStyle: new TextStyle(color: Colors.white),
            border: InputBorder.none
          ),
        );
        //_handleSearchStart();

      } else {
      _filter.text = "";
        this._searchIcon = new Icon(Icons.search);
        this._title = new Text("Term Test Papers", style: new TextStyle(fontWeight: FontWeight.bold),);
//
      }
    });
  }




  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: appbar(context),

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

