import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoe/Modal/game_data.dart';
import 'package:tictactoe/main.dart';

class GameScreen extends StatefulWidget {
  final roomId, role;
  GameScreen({this.roomId, this.role});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List board = ["", "", "", "", "", "", "", "", ""];
  List boardColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];
  var db = Firestore.instance.collection('game_room');
  bool change = false, win = false, mReset = false,oReset=false, update = true;
  bool myTurn=true,opTurn=false,start = false;
  Timer t;
  String myChar;
  int mScore = 0, oScore = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myChar = widget.role == 'Host' ? 'O' : 'X';
    Future.delayed(Duration(seconds: 1), () {
      startgame();
    start=true;
    });
  }

  void chageColor(int i, int j, int k) {
    boardColor[i] = Colors.red;
    boardColor[j] = Colors.red;
    boardColor[k] = Colors.red;
    win = true;
    if (update) {
      if ( board[i] == myChar && widget.role == 'Host' ) {
        db.document(widget.roomId).updateData({'mScore': mScore + 1});
      } else if(board[i]==myChar && widget.role == 'Join'){
        db.document(widget.roomId).updateData({'oScore': oScore + 1});
      }
      update = false;
    }
  }

  void checkWinner() {
    if (t != null) {
      if (board[0] == board[1] &&
          board[1] == board[2] &&
          board[0] != "") {
        chageColor(0, 1, 2);
      } else if (board[0] == board[3] &&
          board[3] == board[6] &&
          board[0] != "") {
        chageColor(0, 3, 6);
      } else if (board[0] == board[4] &&
          board[4] == board[8] &&
          board[0] != "") {
        chageColor(0, 4, 8);
      } else if (board[1] == board[4] &&
          board[4] == board[7] &&
          board[1] != "") {
        chageColor(1, 4, 7);
      } else if (board[2] == board[4] &&
          board[4] == board[6] &&
          board[2] != "") {
        chageColor(2, 4, 6);
      } else if (board[2] == board[5] &&
          board[5] == board[8] &&
          board[2] != "") {
        chageColor(2, 5, 8);
      } else if (board[3] == board[4] &&
          board[4] == board[5] &&
          board[3] != "") {
        chageColor(3, 4, 5);
      } else if (board[6] == board[7] &&
          board[7] == board[8] &&
          board[6] != "") {
        chageColor(6, 7, 8);
      }
    }
  }

  void startgame() {
    t = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (change) {
        setState(() {
          board = board;
        });
        change = false;
      }

      if (widget.role=='Host' && mReset == true) {
        for (int i = 0; i < 9; i++) {
          boardColor[i] = Colors.white;
        }
        db.document(widget.roomId).updateData({'mReset': false});
      }else if(widget.role=='Join' && oReset == true){
        for (int i = 0; i < 9; i++) {
          boardColor[i] = Colors.white;
        }
        db.document(widget.roomId).updateData({'oReset': false});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    t.cancel();
  }

  void setData(int i) async {
    if(widget.role=='Host'){
      if(myTurn){
        board[i] = myChar;
        db.document(widget.roomId).updateData({'board': board,'myTurn':!myTurn,'opTurn':!opTurn});
      }
    }else{
      if(opTurn){
        board[i] = myChar;
        db.document(widget.roomId).updateData({'board': board,'myTurn':!myTurn,'opTurn':!opTurn});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context){
        return GameData();
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<DocumentSnapshot>(
                  stream: db.document(widget.roomId).snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData && start==true) {
                      print('f');
                      board = snapshot.data['board'];
                      win = snapshot.data['win'];
                      board = snapshot.data['board'];
                      mReset = snapshot.data['mReset'];
                      oReset = snapshot.data['oReset'];
                      mScore = snapshot.data['mScore'];
                      oScore = snapshot.data['oScore'];
                      opTurn = snapshot.data['opTurn'];
                      myTurn = snapshot.data['myTurn'];
                      checkWinner();
                      change = true;
                    }
                    return Container();
                  },
                ),
                Container(
                  height: 100.0,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: GridView.builder(
                      itemCount: 9,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext c, int i) {
                        print("Grid building");
                        return GestureDetector(
                          onTap: () {
                            if (board[i] == "" && win == false) {
                              setData(i);
                            }
                          },
                          child: Container(
                            width: 50.0,
                            height: 50.0,
                            alignment: Alignment.center,
                            child: Text(
                              board[i],
                              style: TextStyle(
                                fontSize: 50.0,
                              ),
                            ),
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: boardColor[i],
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 5.0,
                                      offset: Offset(5, 5)),
                                  BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 5.0,
                                      offset: Offset(-5, -5)),
                                  BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 5.0,
                                      offset: Offset(5, -5)),
                                  BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 5.0,
                                      offset: Offset(-5, 5)),
                                ]),
                          ),
                        );
                      },
                    ),
                  ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ScoreCard(
                      widget: widget,
                      mScore: mScore,
                      oScore: oScore,
                      title: 'You',
                    ),
                    ScoreCard(
                      widget: widget,
                      mScore: oScore,
                      oScore: mScore,
                      title: 'Opp',
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (win == true) {
                      db.document(widget.roomId).updateData({
                        'board': ["", "", "", "", "", "", "", "", ""],
                        'win': false,
                        'mReset': true,
                        'oReset':true,
                      });
                      update = true;
//                    for (int i = 0; i < 9; i++) {
//                      boardColor[i] = Colors.white;
//                    }
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    width: MediaQuery.of(context).size.width / 2,
                    padding: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(2, 2),
                            blurRadius: 5.0),
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(2, -2),
                            blurRadius: 5.0),
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(-2, 2),
                            blurRadius: 5.0),
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(-2, -2),
                            blurRadius: 5.0)
                      ],
                    ),
                    child: Text(
                      'Next Game',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  ScoreCard({this.widget, this.mScore, this.oScore, this.title});

  final GameScreen widget;
  final int mScore;
  final int oScore;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 100.0,
      margin: EdgeInsets.only(bottom: 30.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black45, blurRadius: 5.0, offset: Offset(5, 5)),
            BoxShadow(
                color: Colors.black45, blurRadius: 5.0, offset: Offset(-5, -5)),
            BoxShadow(
                color: Colors.black45, blurRadius: 5.0, offset: Offset(5, -5)),
            BoxShadow(
                color: Colors.black45, blurRadius: 5.0, offset: Offset(-5, 5)),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.role == 'Host' ? mScore.toString() : oScore.toString(),
            style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

//
//GridView.builder(
//itemCount: 9,
//physics: NeverScrollableScrollPhysics(),
//gridDelegate:
//SliverGridDelegateWithFixedCrossAxisCount(
//crossAxisCount: 3),
//itemBuilder: (BuildContext c,int i){
//return Container(
//width: 50.0,
//height: 50.0,
//margin: EdgeInsets.all(5.0),
//color: Colors.greenAccent,
//);
//},
//),
