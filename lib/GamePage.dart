import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './LearnToPlay.dart';

class Testapp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Testappstate();
  }
}

class Testappstate extends State<Testapp> {
  List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.yellow,
  ];
  int firstSkip = 0;
  int currentSkip = 1;
  int invalidColorsindex = 0;
  String currentPlayer = "black";
  int invalidEntries = 0;
  int initial = 0;
  String winnerName = "";
  int complete = 0;
  int enter = 0;
  int empty = 60;
  static int m = 8;
  static int n = 8;
  var a = List<List<String>>.generate(
      m, (i) => List<String>.generate(n, (j) => '-'));

  void setcolor(int x) {
    enter = 0;
    print(empty);
    String c = currentPlayer == "black" ? 'B' : 'W';
    int rowno = x ~/ 8;
    int colno = x % 8;
    print("$rowno $colno");
    setState(() {
      if (colno < 7) east(rowno, colno, c);
      if (colno > 0) west(rowno, colno, c);
      if (rowno > 0) north(rowno, colno, c);
      if (rowno < 7) south(rowno, colno, c);
      if (rowno > 0 && colno < 7) northeast(rowno, colno, c);
      if (rowno > 0 && colno > 0) northwest(rowno, colno, c);
      if (rowno < 7 && colno < 7) southeast(rowno, colno, c);
      if (rowno < 7 && colno > 0) southwest(rowno, colno, c);
      if (enter == 0) {
        showLongToast("Invalid Entry");
        invalidEntries = invalidEntries == 3 ? 3 : (invalidEntries + 1) % 4;
      } else {
        invalidEntries = 0;
        currentPlayer = currentPlayer == "black" ? "white" : "black";
        empty--;
      }

      if (empty == 0 ||
          countingColors("White") == 0 ||
          countingColors("Black") == 0) {
        setState(() {
          complete = 1;
        });
        print("COMPLETE : $complete");
      }
    });
  }

  void truncate() {
    setState(() {
      for (int i = 0; i < 8; i++) for (int j = 0; j < 8; j++) a[i][j] = '-';

      firstSkip = 0;
      currentSkip = 1;
      complete = 0;
      invalidEntries = 0;
      empty = 60;
      a[3][3] = 'W';
      a[3][4] = 'B';
      a[4][3] = 'B';
      a[4][4] = 'W';
    });
  }

  int east(int x, int y, String ch) //right
  {
    //print("right");
    int l = y, f = 0;
    if (a[x][y + 1] == ch || a[x][y + 1] == '-') return 0;
    for (int i = y + 2; i < 8; i++) {
      if (a[x][i] == '-') return 0;
      if (a[x][i] == ch) {
        l = i;
        break;
      }
    }
    for (int j = l - 1; j >= y; j--) {
      a[x][j] = ch;
      f = 1;
    }
    if (f == 1) {
      enter = 1;
      print("east done");
      return 1;
    } else
      return 0;
  }

  int west(int x, int y, String ch) //left
  {
    // print("left");
    int l = y, f = 0;
    if (a[x][y - 1] == ch || a[x][y - 1] == '-') return 0;
    for (int i = y - 2; i >= 0; i--) {
      if (a[x][i] == '-') return 0;
      if (a[x][i] == ch) {
        l = i;
        break;
      }
    }
    for (int j = l + 1; j <= y; j++) {
      a[x][j] = ch;
      f = 1;
    }
    if (f == 1) {
      print("west done");
      enter = 1;
      return 1;
    } else
      return 0;
  }

  int north(int x, int y, String ch) //up
  {
    // print("up");
    int l = x, f = 0;
    if (a[x - 1][y] == ch || a[x - 1][y] == '-') return 0;
    for (int i = x - 2; i >= 0; i--) {
      if (a[i][y] == '-') return 0;
      if (a[i][y] == ch) {
        l = i;
        break;
      }
    }
    for (int j = l + 1; j <= x; j++) {
      a[j][y] = ch;
      f = 1;
    }
    if (f == 1) {
      print("north done");
      enter = 1;
      return 1;
    } else
      return 0;
  }

  int south(int x, int y, String ch) //down
  {
    // print("down");
    int l = x, f = 0;
    if (a[x + 1][y] == ch || a[x + 1][y] == '-') return 0;
    for (int i = x + 2; i < 8; i++) {
      if (a[i][y] == '-') return 0;
      if (a[i][y] == ch) {
        l = i;
        break;
      }
    }
    for (int j = l - 1; j >= x; j--) {
      a[j][y] = ch;
      f = 1;
    }
    if (f == 1) {
      print("south done");
      enter = 1;
      return 1;
    } else
      return 0;
  }

  int northeast(int x, int y, String ch) //upright
  {
    // print("upright");
    int m = x, n = y, f = 0;
    if (a[x - 1][y + 1] == ch || a[x - 1][y + 1] == '-') return 0;
    for (int i = x - 2, j = y + 2; i >= 0 && j < 8; i--, j++) {
      if (a[i][j] == '-') return 0;
      if (a[i][j] == ch) {
        m = i;
        n = j;
        break;
      }
    }
    for (int i = m + 1, j = n - 1; i <= x && j >= y; i++, j--) {
      a[i][j] = ch;
      f = 1;
    }
    if (f == 1) {
      print("northeast done");
      enter = 1;
      return 1;
    } else
      return 0;
  }

  int northwest(int x, int y, String ch) //upleft
  {
    // print("upleft");
    int m = x, n = y, f = 0;
    if (a[x - 1][y - 1] == ch || a[x - 1][y - 1] == '-') return 0;
    for (int i = x - 2, j = y - 2; i >= 0 && j >= 0; i--, j--) {
      if (a[i][j] == '-') return 0;
      if (a[i][j] == ch) {
        m = i;
        n = j;
        break;
      }
    }
    for (int i = m + 1, j = n + 1; i <= x && j <= y; i++, j++) {
      a[i][j] = ch;
      f = 1;
    }
    if (f == 1) {
      print("northwest done");
      enter = 1;
      return 1;
    } else
      return 0;
  }

  int southeast(int x, int y, String ch) //downright
  {
    // print("downright");
    int m = x, n = y, f = 0;
    if (a[x + 1][y + 1] == ch || a[x + 1][y + 1] == '-') return 0;
    for (int i = x + 2, j = y + 2; i < 8 && j < 8; i++, j++) {
      if (a[i][j] == '-') return 0;
      if (a[i][j] == ch) {
        m = i;
        n = j;
        break;
      }
    }
    for (int i = m - 1, j = n - 1; i >= x && j >= y; i--, j--) {
      a[i][j] = ch;
      f = 1;
    }
    if (f == 1) {
      print("southeast done");
      enter = 1;
      return 1;
    } else
      return 0;
  }

  int southwest(int x, int y, String ch) //downleft
  {
    // print("downleft");
    int m = x, n = y, f = 0;
    if (a[x + 1][y - 1] == ch || a[x + 1][y - 1] == '-') return 0;
    for (int i = x + 2, j = y - 2; i < 8 && j >= 0; i++, j--) {
      if (a[i][j] == '-') {
        return 0;
      }
      if (a[i][j] == ch) {
        m = i;
        n = j;
        break;
      }
    }
    for (int i = m - 1, j = n + 1; i >= x && j <= y; i--, j++) {
      a[i][j] = ch;
      f = 1;
    }
    if (f == 1) {
      print("southwest done");
      enter = 1;
      return 1;
    } else
      return 0;
  }

  void whoiswinner() {
    int white = 0, black = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (a[i][j] == 'W')
          white++;
        else
          black++;
      }
    }
    complete = 1;
    winnerName =
        (white == black) ? "Draw Match" : ((white > black) ? "WHITE" : "BLACK");
    print("$winnerName is winner\n White : $white \n Black : $black");
  }

  int countingColors(String s) {
    int white = 0, black = 0;
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (a[i][j] == 'W')
          white++;
        else if (a[i][j] == 'B') black++;
      }
    }
    return s == "White" ? white : black;
  }

  void showLongToast(String message) {
    invalidColorsindex = invalidColorsindex + 1;
    Fluttertoast.showToast(
      gravity: ToastGravity.TOP,
      textColor: Colors.redAccent,
      backgroundColor: colors[invalidColorsindex % 3],
      msg: message,
      // timeInSecForIos: 1,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.green,
      appBar: new AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () => Navigator.pop(context),
          iconSize: MediaQuery.of(context).size.width * 0.12,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          "MultiPlayer",
          style: new TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.08,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.tealAccent,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.live_help),
              tooltip: "How to Play",
              iconSize: MediaQuery.of(context).size.width * 0.085,
              color: Colors.white70,
              onPressed: () {
                print("learn while Playing");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return new HowToPlay();
                }));
              }),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          invalidEntries == 3
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Card(
                    color: Colors.transparent,
                    elevation: 15.0,
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.all(2),
                        child: Text("   Skip\nmy Turn"),
                      ),
                      onTap: () {
                        setState(() {
                          firstSkip == 0
                              ? firstSkip = empty
                              : currentSkip = empty;
                          complete = currentSkip == firstSkip ? 1 : complete;
                          invalidEntries = 0;
                          currentPlayer =
                              currentPlayer == "black" ? "white" : "black";
                        });
                      },
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.058,
                ),
          Stack(
            children: <Widget>[
              new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 0.0),
                    child: new GridView.extent(
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width * 0.12,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      children: customBox(),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: ((MediaQuery.of(context).size.width * 0.12) * 8.35),
                    color: Colors.orangeAccent.shade100,
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(5.0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text(
                        countingColors("White") < 10
                            ? "White: 0${countingColors("White")}"
                            : "White: ${countingColors("White")}",
                        style: new TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                      new Container(
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(40.0),
                          color: currentPlayer == "black"
                              ? Colors.black
                              : Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: new Center(
                          child: new Text(
                            currentPlayer == "black"
                                ? "Black\n Turn"
                                : "White\n Turn",
                            style: new TextStyle(
                              color: currentPlayer == "black"
                                  ? Colors.white
                                  : Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025,
                            ),
                          ),
                        ),
                      ),
                      new Text(
                        countingColors("Black") < 10
                            ? "Black: 0${countingColors("Black")}"
                            : "White: ${countingColors("Black")}",
                        style: new TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: new RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        elevation: 10.0,
                        color: Colors.orangeAccent,
                        child: new Text(
                          empty == 0 || complete == 1
                              ? "Play Again"
                              : "Reset Game",
                          style: new TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                            color: Colors.redAccent,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        onPressed: () {
                          print("Reseting");
                          truncate();
                        }),
                  ),
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                left: MediaQuery.of(context).size.width * 0.01,
                child: new Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: new Center(
                    child: empty == 0 || complete == 1
                        ? (countingColors("White") == countingColors("Black")
                            ? new Image.asset(
                                'images/Draw.gif',
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                              )
                            : (countingColors("White") > countingColors("Black")
                                ? new Image.asset(
                                    'images/white.gif',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                  )
                                : new Image.asset(
                                    'images/Black.gif',
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                  )))
                        : null,
                  ),
                ),
              ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> customBox() {
    List<GestureDetector> cns =
        new List<GestureDetector>.generate(64, (int index) {
      if (initial == 0) {
        initial = 1;
        a[3][3] = 'W';
        a[3][4] = 'B';
        a[4][3] = 'B';
        a[4][4] = 'W';
      }
      int row = index ~/ 8;
      int col = index % 8;
      return new GestureDetector(
        onTap: () => (complete == 0)
            ? (a[row][col] == '-'
                ? setcolor(index)
                : showLongToast("Already Occupied"))
            : showLongToast("Game Completed"),
        child: new Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.green,
          ),
          child: new Center(
            child: new CircleAvatar(
              backgroundColor: a[row][col] == '-'
                  ? Colors.green
                  : (a[row][col] == 'W')
                      ? Colors.white
                      : Colors.black,
              maxRadius: MediaQuery.of(context).size.width * 0.047,
            ),
          ),
        ),
      );
    });
    return cns;
  }
}
