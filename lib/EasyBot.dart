import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './LearnToPlay.dart';

int sysrow = -1, syscol = -1;

class EasyBot extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EasyBotstate();
  }
}

class EasyBotstate extends State<EasyBot> {
  @override
  initState() {
    super.initState();
    sysrow = -1;
    syscol = -1;
  }

  List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.yellow,
  ];
  int invalidEntries = 0;
  int invalidColorsIndex = 0;
  int initial = 0;
  int firstSkip = 0;
  int currentSkip = 1;
  String winnerName = "";
  int complete = 0;
  int enter = 0;
  int? computerentry;
  int empty = 60;
  String currentPlayer = "User";
  static int m = 8;
  static int n = 8;
  var a = List<List<String>>.generate(
      m, (i) => List<String>.generate(n, (j) => '-'));

  void setcolor(int x) {
    enter = 0;
    if (currentPlayer == "User") {
      // bool userCanEnterOrNot = computerturn('B');
      // print("USER CAN ENTER OR NOT : $userCanEnterOrNot");
      int rowno = x ~/ 8;
      int colno = x % 8;
      print("$rowno $colno");
      setState(() {
        if (colno < 7) east(rowno, colno, 'B', 1);
        if (colno > 0) west(rowno, colno, 'B', 1);
        if (rowno > 0) north(rowno, colno, 'B', 1);
        if (rowno < 7) south(rowno, colno, 'B', 1);
        if (rowno > 0 && colno < 7) northeast(rowno, colno, 'B', 1);
        if (rowno > 0 && colno > 0) northwest(rowno, colno, 'B', 1);
        if (rowno < 7 && colno < 7) southeast(rowno, colno, 'B', 1);
        if (rowno < 7 && colno > 0) southwest(rowno, colno, 'B', 1);
        if (enter == 0) {
          showLongToast("Invalid Entry");
          invalidEntries = invalidEntries == 3 ? 3 : (invalidEntries + 1) % 4;
        } else {
          invalidEntries = 0;
          empty--;
          if (empty == 0) {
            setState(() {
              complete = 1;
            });
          }
          currentPlayer = "System";
        }
        print("                                   empty : $empty");
      });
    }
    if ((enter != 0 || currentPlayer == "System") &&
        complete == 0 &&
        empty != 0) {
      computerMoves();
    }
  }

  computerMoves() {
    if (currentPlayer == "User") currentPlayer = "System";
    enter = 0;
    Timer(Duration(milliseconds: 500), () {
      print("Wait is Over");
      bool computerEnteredornot = computerturn('W');
      if (computerEnteredornot) {
        setState(() {
          sysrow = computerentry! ~/ 10;
          syscol = computerentry! % 10;

          // print("Computer Entry is : $rowno $colno");

          if (syscol < 7) east(sysrow, syscol, 'W', 1);
          if (syscol > 0) west(sysrow, syscol, 'W', 1);
          if (sysrow > 0) north(sysrow, syscol, 'W', 1);
          if (sysrow < 7) south(sysrow, syscol, 'W', 1);
          if (sysrow > 0 && syscol < 7) northeast(sysrow, syscol, 'W', 1);
          if (sysrow > 0 && syscol > 0) northwest(sysrow, syscol, 'W', 1);
          if (sysrow < 7 && syscol < 7) southeast(sysrow, syscol, 'W', 1);
          if (sysrow < 7 && syscol > 0) southwest(sysrow, syscol, 'W', 1);
          if (enter != 0) {
            empty--;
            if (countingColors("White") == 0 ||
                countingColors("Black") == 0 ||
                empty == 0) {
              setState(() {
                complete = 1;
              });
            }
            currentPlayer = "User";
            bool userCanEnterOrNot = computerturn('B');
            if (userCanEnterOrNot == false && complete == 0) {
              showLongToast("User Entry not Possible");
              bool sysCanEnterOrNot = computerturn('W');
              if (sysCanEnterOrNot == false && complete == 0) {
                showLongToast("Computer Entry not Possible");
                setState(() {
                  complete = 1;
                });
              }
              setState(() {
                currentPlayer = "System";
              });
              if (complete == 0) computerMoves();
            }
          }
        });
      } else {
        setState(() {
          currentPlayer = "User";
          showLongToast("Computer Entry not Possible");
          bool userCanEnterOrNot = computerturn('B');
          if (userCanEnterOrNot == false && complete == 0) {
            showLongToast("User Entry not Possible");
            setState(() {
              complete = 1;
            });
          }
        });
      }
      print("                                                  empty : $empty");
      complete == 1 ? print("Game Completed") : print("not Completed");
    });
  }

  bool computerturn(String p) {
    // int highestflips = 0;
    bool possible = false;
    computerentry = 0;
    int cornerflips = 0;
    bool cornerDone = false;
    if (a[0][0] == '-' && !cornerDone) {
      print("\nTOP LEFT CORNER\n");
      cornerflips = cornerflips + east(0, 0, p, 0);
      cornerflips = cornerflips + south(0, 0, p, 0);
      cornerflips = cornerflips + southeast(0, 0, p, 0);
      if (cornerflips != 0) {
        cornerDone = true;
        print("SETTING\n");
        computerentry = (0 * 10) + 0;
        return true;
      }
    }
    if (a[0][7] == '-' && !cornerDone) {
      print("\nTOP RIGHT CORNER\n");
      cornerflips = cornerflips + west(0, 7, p, 0);
      cornerflips = cornerflips + south(0, 7, p, 0);
      cornerflips = cornerflips + southwest(0, 7, p, 0);
      if (cornerflips != 0) {
        cornerDone = true;
        computerentry = (0 * 10) + 7;
        print("SETTING\n");
        return true;
      }
    }
    if (a[7][0] == '-' && !cornerDone) {
      print("\nBOTTOM LEFT CORNER\n");
      cornerflips = cornerflips + east(7, 0, p, 0);
      cornerflips = cornerflips + north(7, 0, p, 0);
      cornerflips = cornerflips + northeast(7, 0, p, 0);
      if (cornerflips != 0) {
        cornerDone = true;
        computerentry = (7 * 10) + 0;
        print("SETTING\n");
        return true;
      }
    }
    if (a[7][7] == '-' && !cornerDone) {
      print("\nBOTTOM RIGHT CORNER\n");
      cornerflips = cornerflips + west(7, 7, p, 0);
      cornerflips = cornerflips + north(7, 7, p, 0);
      cornerflips = cornerflips + northwest(7, 7, p, 0);
      if (cornerflips != 0) {
        cornerDone = true;
        computerentry = (7 * 10) + 7;
        print("SETTING\n");
        return true;
      }
    }

    for (int rowno = 0; rowno < 8; rowno++) {
      for (int colno = 0; colno < 8; colno++) {
        if (a[rowno][colno] == '-') {
          int currentflips = 0;
          if (colno < 7) currentflips = currentflips + east(rowno, colno, p, 0);
          if (colno > 0) currentflips = currentflips + west(rowno, colno, p, 0);
          if (rowno > 0)
            currentflips = currentflips + north(rowno, colno, p, 0);
          if (rowno < 7)
            currentflips = currentflips + south(rowno, colno, p, 0);
          if (rowno > 0 && colno < 7)
            currentflips = currentflips + northeast(rowno, colno, p, 0);
          if (rowno > 0 && colno > 0)
            currentflips = currentflips + northwest(rowno, colno, p, 0);
          if (rowno < 7 && colno < 7)
            currentflips = currentflips + southeast(rowno, colno, p, 0);
          if (rowno < 7 && colno > 0)
            currentflips = currentflips + southwest(rowno, colno, p, 0);
          // print("CURRENT FLIPS ARE : $currentflips");

          if (currentflips > 0) {
            possible = true;
            // highestflips = currentflips;
            computerentry = (rowno * 10) + colno;
            return possible;
          }
        }
      }
    }
    return possible;
  }

  void truncate() {
    setState(() {
      for (int i = 0; i < 8; i++) for (int j = 0; j < 8; j++) a[i][j] = '-';

      firstSkip = 0;
      currentSkip = 1;
      complete = 0;
      invalidEntries = 0;
      empty = 60;
      sysrow = -1;
      a[3][3] = 'W';
      a[3][4] = 'B';
      a[4][3] = 'B';
      a[4][4] = 'W';
    });
  }

  int east(int x, int y, String ch, int change) //right
  {
    // print("right");
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
      if (change == 1) {
        a[x][j] = ch;
      }
      f = f + 1;
    }
    if (f != 0) {
      enter = 1;
      print("east done");
      return f - 1;
    } else
      return 0;
  }

  int west(int x, int y, String ch, int change) //left
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
      if (change == 1) {
        a[x][j] = ch;
      }
      f = f + 1;
    }
    if (f != 0) {
      print("west done");
      enter = 1;
      return f - 1;
    } else
      return 0;
  }

  int north(int x, int y, String ch, int change) //up
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
      if (change == 1) {
        a[j][y] = ch;
      }
      f = f + 1;
    }
    if (f != 0) {
      print("north done");
      enter = 1;
      return f - 1;
    } else
      return 0;
  }

  int south(int x, int y, String ch, int change) //down
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
      if (change == 1) {
        a[j][y] = ch;
      }
      f = f + 1;
    }
    if (f != 0) {
      print("south done");
      enter = 1;
      return f - 1;
    } else
      return 0;
  }

  int northeast(int x, int y, String ch, int change) //upright
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
      if (change == 1) {
        a[i][j] = ch;
      }
      f = f + 1;
    }
    if (f != 0) {
      print("northeast done");
      enter = 1;
      return f - 1;
    } else
      return 0;
  }

  int northwest(int x, int y, String ch, int change) //upleft
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
      if (change == 1) {
        a[i][j] = ch;
      }
      f = f + 1;
    }
    if (f != 0) {
      print("northwest done");
      enter = 1;
      return f - 1;
    } else
      return 0;
  }

  int southeast(int x, int y, String ch, int change) //downright
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
      if (change == 1) {
        a[i][j] = ch;
      }
      f = f + 1;
    }
    if (f != 0) {
      print("southeast done");
      enter = 1;
      return f - 1;
    } else
      return 0;
  }

  int southwest(int x, int y, String ch, int change) //downleft
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
      if (change == 1) {
        a[i][j] = ch;
      }
      f = f + 1;
    }
    if (f != 0) {
      print("southwest done");
      enter = 1;
      return f - 1;
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
    invalidColorsIndex = invalidColorsIndex + 1;
    Fluttertoast.showToast(
      gravity: ToastGravity.TOP,
      textColor: Colors.redAccent,
      msg: message,
      backgroundColor: colors[invalidColorsIndex % 3],
      toastLength: Toast.LENGTH_LONG,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () => Navigator.pop(context),
          iconSize: MediaQuery.of(context).size.width * 0.12,
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: new Text(
          "Easy Bot",
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
                          currentPlayer = "System";
                          setcolor(
                              50); //////***** DOESN'T MATTER WHAT NUMBER YOU ARE PASSING HERE AS A PARAMETER*****//////
                          firstSkip == 0
                              ? firstSkip = empty
                              : currentSkip = empty;
                          print(empty);
                          complete = currentSkip == firstSkip ? 1 : complete;
                          invalidEntries = 0;
                        });
                      },
                    ),
                  ),
                )
              : Container(height: MediaQuery.of(context).size.height * 0.058),
          new Stack(
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
                          color: currentPlayer == "User"
                              ? Colors.black
                              : Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: new Center(
                          child: new Text(
                            currentPlayer == "User"
                                ? "Player\n Turn"
                                : "System\n  Turn",
                            style: new TextStyle(
                              color: currentPlayer == "User"
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
                            : "Black: ${countingColors("Black")}",
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
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
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
                          empty == 0 || complete == 1
                              ? print("playing again")
                              : print("Reseting");
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
                    child: empty == 0 ||
                            countingColors("White") == 0 ||
                            countingColors("Black") == 0 ||
                            complete == 1
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
                        : Container(
                            width: 0.0,
                            height: 0.0,
                          ),
                  ),
                ),
              ),
              sysrow == -1
                  ? Container()
                  : Positioned(
                      child: Container(
                        child: Image.asset('images/Pointing.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                      top:
                          (MediaQuery.of(context).size.width * 0.127) * sysrow +
                              15.0,
                      left:
                          (MediaQuery.of(context).size.width * 0.127) * syscol +
                              7.0,
                    ),
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
