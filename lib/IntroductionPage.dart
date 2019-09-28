import 'package:flutter/material.dart';
import 'package:fourth/AboutUs.dart';
import './GamePage.dart';
import './Computer.dart';
import './LearnToPlay.dart';
import 'package:share/share.dart';

import 'package:firebase_admob/firebase_admob.dart';


class IntroPage extends StatefulWidget {
  @override
  IntroPageState createState() => IntroPageState();
}

class IntroPageState extends State<IntroPage> {

static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  keywords: <String>['games', 'pubg','food','taxi','ride','hotel','play','oyo','rapido','swiggy','uber','Goibibo','True Balance','Phone Pay','Lynk','IOT','AI','Machine Learning'],
  contentUrl: 'https://flutter.io',
  testDevices: <String>["90F3FC819896095375532EAC4070D216"], // Android emulators are considered test devices
);

BannerAd bannerAd = BannerAd(
  adUnitId: "ca-app-pub-8497531290930465/4971570592",
  size: AdSize.banner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event){
    print("\n\n\n\nBanner Event is : $event\n\n\n\n");
  }
);



@override
initState()
{
  super.initState();
  FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8497531290930465~1582989926");
  bannerAd..load()..show(
    anchorType: AnchorType.bottom,
    anchorOffset: 5.0,
    horizontalCenterOffset: 0.0,
  );
}

@override
dispose()
{
  bannerAd?.dispose();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Othello',
          style: new TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),


        actions: <Widget>[

          new IconButton(
            icon: new Icon(
              Icons.info,
              color: Colors.black,
            ),
            tooltip: "About",
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AboutPage();
                })),
          ),

          new IconButton(
            icon: new Icon(
              Icons.share,
              color: Colors.black,
              ),
              tooltip: "Share",
              onPressed: () 
              {
                print("Sharing Game");
                Share.share("Feeling bored with Usual Games..? Try Playing This Game\n https://play.google.com/store/apps/details?id=com.srikanth7785.othello \nNow Updated with Single Player Mode..:)");
              }
          ),
        ],
      ),
      backgroundColor: Colors.orangeAccent.shade100,
      body: new ListView(
        children: <Widget>[
          new Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  new Image.asset(
                    'images/Demo Game.gif',
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.09),
                        child: GestureDetector(
                          child: new Column(
                            children: <Widget>[
                              Image.asset('images/Multiplayer.png',
                              color: Colors.brown,
                              width: MediaQuery.of(context).size.width * 0.25,
                              height: MediaQuery.of(context).size.height * 0.12,
                              ),
                              Text(" Multiplayer",
                              style: TextStyle(
                                color: Colors.brown,
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold
                              ),
                              ),
                            ]
                          ),
                          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => Testapp())),
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width*0.24),
                      GestureDetector(
                        child: new Column(
                          children: <Widget>[
                            SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                              Icon(Icons.remove_from_queue,
                              size: MediaQuery.of(context).size.width * 0.24,
                              color: Colors.brown,),
                            Text(" Single Player",
                            style: TextStyle(
                              color: Colors.brown,
                              fontSize: MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ]
                        ),
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => Computer())),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  GestureDetector(
                    child: Column(
                      children: <Widget>[
                          Icon(Icons.live_help,
                          size: MediaQuery.of(context).size.width * 0.08,
                          color: Colors.brown,),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01),
                        Text("How To Play",
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold
                        )
                        ),
                      ],
                    ),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HowToPlay())),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
