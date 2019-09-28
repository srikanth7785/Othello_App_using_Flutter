import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // backgroundColor: Colors.green,
      backgroundColor: Colors.orangeAccent.shade100,
      appBar: new AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: ()=> Navigator.pop(context),
          iconSize: MediaQuery.of(context).size.width * 0.12,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          "About",
          style: new TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: MediaQuery.of(context).size.width * 0.08,
            fontWeight: FontWeight.bold,
            // color: Colors.tealAccent,
            color: Colors.black,
          ),
        ),
      ),
      body: new ListView(
        children: <Widget>[
          new Card(
            color: Colors.transparent,
            margin: EdgeInsets.only(left:10.0,top:10.0,right:10.0),
            elevation: 0.0,
            child: new Container(
              padding: EdgeInsets.all(10.0),
              child: new Column(
                children: <Widget>[
                  new Padding(padding: new EdgeInsets.all(5.0)),
                  new Image.asset(
                    'images/Othello.jpg',
                    height: MediaQuery.of(context).size.height * 0.27,
                  ),
                    new Center(
                      child: new Text(
                        "Othello",
                        style: new TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.11,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    new Center(
                      child: new Text(
                        "version : 3.1.0",
                        style: new TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ],
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left:10.0,right: 10.0),
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: Colors.black,
          ),

          Card(
            color: Colors.transparent,
            elevation: 0.0,
            margin: new EdgeInsets.all(10.0),
              child: new Container(
                child: Padding(
                  padding: new EdgeInsets.all(10.0),
                  child: Text("                           Othello is all about occupying the position of opponent. The more you occupy is the more chances for your VICTORY.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),)
                ),
              ) 
          ),

          Container(
            margin: EdgeInsets.only(left:10.0,right: 10.0),
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: Colors.black,
          ),

          new Container(
            padding: EdgeInsets.only(left:6.0,right:6.0,top:5.0),
            child: new Container(
              child: new Card(
                color: Colors.transparent,
                elevation: 0.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: new Text(
                        "   Contact Us ",
                        style: new TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0,),
                      // leading: new Image.asset(
                      //   'images/Developers.png',
                      //   // color: Colors.black,
                      // ),
                      Row(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              child: Icon(Icons.developer_mode,
                                size: MediaQuery.of(context).size.height * 0.03,
                              ),
                            ),
                          ),
                          SizedBox(width: 5.0,),
                          Align(
                            alignment: Alignment.center,
                            child: new Text(
                              'We_developers',
                              style: new TextStyle(
                                color: Colors.green,
                                fontSize: MediaQuery.of(context).size.width * 0.06,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 7.0,),
                new Row(
                      children: <Widget>[
                        Padding(padding: new EdgeInsets.only(left: 5.0)),
                        new Text("Email us at :"),
                        new Text(
                          "wegroupmail1@gmail.com",
                          style: new TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
