import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'git.dart';
import 'model_papers.dart';
import 'notes.dart';
import 'past_papers.dart';
import 'term_test.dart';


class NewHomePage extends StatefulWidget {
  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

  final CollectionReference collectionReference =
  Firestore.instance.collection("latest_updates");
  List<DocumentSnapshot> paperlist;
  StreamSubscription<QuerySnapshot> subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscription = collectionReference
        .orderBy("name", descending: true)
        .snapshots()
        .listen((datasnapshot) {
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

  Future launchURL(String url) async{
    if (await canLaunch(url)) {

      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          color: Color(0xFF3173fd),
          padding: EdgeInsets.symmetric(vertical: 20),
          child: CarouselSlider(
            initialPage: 0,

            autoPlay: true,
            autoPlayAnimationDuration: Duration(seconds: 1),
            viewportFraction: 0.4,
            items: <Widget>[

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TermTestPapers()));
                    },
                  child: Container(
                    width: 120,
                    height: 100,
                    decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),color: Colors.white),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.today,size: 62,color: Theme.of(context).colorScheme.primary,),
                            Text("Term Test Papers",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PastPapers()));
                    },
                  child: Container(
                    width: 120,
                    height: 100,
                    decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),color: Colors.white),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.history,size: 62,color: Theme.of(context).colorScheme.primary,),
                            Text("Past Papers",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),textAlign: TextAlign.center,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ModelPapers()));
                    },
                  child: Container(
                    width: 120,
                    height: 100,
                    decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),color: Colors.white),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.layers,size: 62,color: Theme.of(context).colorScheme.primary,),
                            Text("Model Papers",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                  ),
                ),
              ),



              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GIT()));
                    },
                  child: Container(
                    width: 120,
                    height: 100,
                    decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),color: Colors.white),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.chrome_reader_mode,size: 62,color: Theme.of(context).colorScheme.primary,),
                            Text("GIT Papers",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                  ),
                ),
              ),




              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Notes()));
                    },
                  child: Container(
                    width: 120,
                    height: 100,
                    decoration: ShapeDecoration(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),color: Colors.white),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.import_contacts,size: 62,color: Theme.of(context).colorScheme.primary,),
                            Text("Notes",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),textAlign: TextAlign.center,)
                          ],
                        ),
                      ),
                  ),
                ),
              ),

//
            ],

          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            "Announcements",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary
                ),
          ),
        ),

        paperlist != null?ListView.builder(
          itemCount: paperlist.length,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemBuilder: (context,i){
              String data= paperlist[i].data['name'];
              if(data != "null"){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.notifications_active,color: Theme.of(context).colorScheme.primary,),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(data,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                    )
                  ],
                );}
              else{
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(child: Text("There is nothing to show!",textAlign: TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.grey,))),
                );
              }
            }
        ):Center(child: CircularProgressIndicator()),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Recently Added",

            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary
                ),
          ),
        ),


//starting the box
        Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(8),boxShadow: [BoxShadow(blurRadius: 4)]),
          width: MediaQuery.of(context).size.width,
          height: 121,
          margin: EdgeInsets.all(16),
          child: Container(
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                ClipRRect(borderRadius: BorderRadius.circular(8) ,child: Image(image: AssetImage("assets/recentlyadded.jpg"),fit: BoxFit.fitHeight,)),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                ListTile(title: Text("ICT Syllabus",style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("Education Publications Department",style: TextStyle(fontSize: 12),)),
                   
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ButtonTheme(
                          height: 25,
                          minWidth: 20,

                          child: FlatButton(

                            onPressed: ()=>launchURL("http://nie.lk/pdffiles/tg/sALSyl%20ICT.pdf"),
                            color: Color(0xff0B72AB),
                            child: Text("Sinhala",style: TextStyle(color: Colors.white),),


                          ),
                        ),

                        ButtonTheme(
                          height: 25,
                          minWidth: 20,

                          child: FlatButton(

                            onPressed: ()=>launchURL("http://nie.lk/pdffiles/tg/eALSyl%20ICT.pdf"),
                            color: Color(0xffAB0B0B),
                            child: Text("English",style: TextStyle(color: Colors.white),),


                          ),
                        ),


                      ],
                    )
                  ],
                ),)
              ],
            )

          ),
        ),
        //ending the box


        //starting the box
        Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(8),boxShadow: [BoxShadow(blurRadius: 4)]),
          width: MediaQuery.of(context).size.width,
          height: 121,
          margin: EdgeInsets.all(16),
          child: Container(
              margin: EdgeInsets.only(right: 7),
              decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                  ClipRRect(borderRadius: BorderRadius.circular(8) ,child: Image(image: AssetImage("assets/recentlyadded.jpg"),fit: BoxFit.fitHeight,)),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(title: Text("2019 ICT Marking Scheme Part 1",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[


                          ButtonTheme(
                            height: 25,
                            minWidth: 20,

                            child: FlatButton(

                              onPressed: ()=>launchURL("https://firebasestorage.googleapis.com/v0/b/ict-api.appspot.com/o/1234%5B1%5D.jpg?alt=media&token=faf148b4-76b1-4eed-9f0e-428f79f43117"),
                              color: Color(0xffAB0B0B),
                              child: Text("View",style: TextStyle(color: Colors.white),),


                            ),
                          ),


                        ],
                      )
                    ],
                  ),)
                ],
              )

          ),
        ),



        //starting the box
        Container(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor,borderRadius: BorderRadius.circular(8),boxShadow: [BoxShadow(blurRadius: 4)]),
          width: MediaQuery.of(context).size.width,
          height: 121,
          margin: EdgeInsets.all(16),
          child: Container(
              margin: EdgeInsets.only(right: 7),
              decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),color: Colors.white),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                  ClipRRect(borderRadius: BorderRadius.circular(8) ,child: Image(image: AssetImage("assets/recentlyadded.jpg"),fit: BoxFit.fitHeight,)),
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(title: Text("GIT Online Exam",style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text("Education Publications Department",style: TextStyle(fontSize: 12),)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ButtonTheme(
                            height: 25,
                            minWidth: 20,

                            child: FlatButton(

                              onPressed: ()=>launchURL("http://onlineexams.gov.lk/download/user_manual.pdf"),
                              color: Color(0xff0B72AB),
                              child: Text("Manual",style: TextStyle(color: Colors.white),),


                            ),
                          ),

                          ButtonTheme(
                            height: 25,
                            minWidth: 20,

                            child: FlatButton(

                              onPressed: ()=>launchURL("http://onlineexams.gov.lk/login/index.php"),
                              color: Color(0xffAB0B0B),
                              child: Text("Sign Up",style: TextStyle(color: Colors.white),),


                            ),
                          ),


                        ],
                      )
                    ],
                  ),)
                ],
              )

          ),
        ),















//







      ],
    );

  }
}
