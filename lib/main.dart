import 'package:flutter/material.dart';
import 'package:ict_api/term_test.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'about_us.dart';
import 'git.dart';

import 'homepage.dart';
import 'model_papers.dart';
import 'notes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'past_papers.dart';
import 'splash.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MaterialApp(home: Splash(),
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: "TTCommons"
      ),));
  });
}





class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Color(0xFF3173fd),

      ),
      routes: <String, WidgetBuilder>{
        "/a": (BuildContext context) => new TermTestPapers(),
        "/b": (BuildContext context) => new Notes(),
        "/c": (BuildContext context) => new AboutUS(),
        "/d": (BuildContext context) => new PastPapers(),
        "/e": (BuildContext context) => new ModelPapers(),
        "/f": (BuildContext context) => new GIT()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();


   Future launchURL(String url) async{
    if (await canLaunch(url)) {

      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future sendEmail() async{
    if (await canLaunch("mailto:dulajnadawa@gmail.com?subject=Contacting IT Api&body=")) {
      await launch("mailto:dulajnadawa@gmail.com?subject=Contacting IT Api&body=");
    } else {
      throw 'Could not launch';
    }
  }

  void rate(BuildContext context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return new AlertDialog(
          title: Text("Rate Us!"),
          content: Text("If you Like the app, please Rate Us!"),
          elevation: 8.0,
          actions: <Widget>[
            new FlatButton(
                onPressed: ()=> Navigator.of(context).pop(),
                child: Text("CANCEL")),

            new FlatButton(
                onPressed: ()=> launchURL("https://play.google.com/store/apps/details?id=dnadawa.ict_api&reviewId=0"),
                  child: Text("RATE US"))
          ],
        );
      }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        final title = message['notification']['title'];
        final body = message['notification']['body'];
        print('on message $title,$body');

      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );

    _firebaseMessaging.getToken().then((token){print(token);});


  }





  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      appBar: new AppBar(
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.record_voice_over),onPressed: (){rate(context);},),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 2.0))
        ],
        title: new Text(
          "IT Api",
          style: new TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new Container(
              height: 150.0,
            //  color: Theme.of(context).colorScheme.primary,
              child: Center(child: new Image(image: AssetImage("assets/logo.png"),fit: BoxFit.cover,)),

            ),
            new ListTile(
              leading: new Icon(Icons.home),
              title: new Text("Home",
                  style: new TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => Navigator.of(context).pop(),
            ),
            new ListTile(
              leading: new Icon(Icons.today),
              title: new Text("Term Test Papers",
                  style: new TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/a");
              },
            ),
            new ListTile(
              leading: new Icon(Icons.history),
              title: new Text("Past Papers",
                  style: new TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/d");
              },
            ),
            new ListTile(
              leading: new Icon(Icons.layers),
              title: new Text("Model Papers",
                  style: new TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/e");
              },
            ),
            new ListTile(
              leading: new Icon(Icons.chrome_reader_mode),
              title: new Text("GIT Papers",
                  style: new TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/f");
              },
            ),
            new ListTile(
              leading: new Icon(Icons.import_contacts),
              title: new Text("NOTES",
                  style: new TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/b");
              },
            ),
            new Divider(),
            new ListTile(
              leading: new Icon(Icons.contacts),
              title: new Text("Contact Us",
                  style: new TextStyle(fontWeight: FontWeight.bold)),
              onTap: () => sendEmail(),
            ),
            new ListTile(
              leading: new Icon(Icons.info),
              title: new Text("About Us",
                  style: new TextStyle(fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/c");
              },
            )
          ],
        ),
      ),
      body: NewHomePage()

    );
  }
}


