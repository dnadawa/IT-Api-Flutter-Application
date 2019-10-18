import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'main.dart';
import 'package:firebase_admob/firebase_admob.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {



  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>[],
    childDirected: false,
    testDevices: <String>[], // Android emulators are considered test devices
  );
  InterstitialAd myInterstitial = InterstitialAd(
    // Replace the testAdUnitId with an ad unit id from the AdMob dash.
    // https://developers.google.com/admob/android/test-ads
    // https://developers.google.com/admob/ios/test-ads
    adUnitId: "ca-app-pub-2946850357131537/7609996828",
    targetingInfo: targetingInfo,
    listener: (MobileAdEvent event) {
      print("InterstitialAd event is $event");
    },
  );





  AnimationController iconAnimationController;
  Animation<Offset> iconAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iconAnimationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));

    iconAnimation = Tween<Offset>(begin: Offset(0.0,-1.0), end: Offset.zero)
        .animate(iconAnimationController);
    iconAnimationController.forward();

    FirebaseAdMob.instance.initialize(appId: "ca-app-pub-2946850357131537~8739245665");
    
    Timer(Duration(seconds: 3),()=>checkInternet()//Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Myapp()),(Route<dynamic> route)=>false)
    );
    
  }

  void checkInternet() async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');


        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context){
          myInterstitial..load()..show();
          return Myapp();}));
      }
    } on SocketException catch (_) {
      print('not connected');
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => NotConnected()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: BoxDecoration(color: Colors.indigoAccent),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SlideTransition(
                  position: iconAnimation,
                  child: Container(
                    child: new FadeInImage(placeholder:AssetImage("assets/logo.png"),image: AssetImage("assets/splash.png")),padding: const EdgeInsets.all(60.0),),

                ),
               
              ],
            ),
          )
        ],
      ),
    );
  }
}


class NotConnected extends StatelessWidget{





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              Container(padding:const EdgeInsets.symmetric(horizontal: 10.0),child: new Text("Oops! There is no Internet Connection!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,)),
              Padding(padding: const EdgeInsets.all(10.0),),
              Image(image: new AssetImage("assets/nointenet.gif"),),
              new RaisedButton(onPressed: () async {


                  try {
                    final result = await InternetAddress.lookup('google.com');
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      print('connected');
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Myapp()),(Route<dynamic> route)=>false);
                    }
                  } on SocketException catch (_) {
                    print('not connected');
                    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NotConnected()),(Route<dynamic> route)=>false);

                }



              },
                child: Text("Try Again",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
              color: Colors.indigo)
            ],
          ),
        ),
      ),
    );
  }
}
