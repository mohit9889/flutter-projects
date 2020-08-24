import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/Screens/game_screen.dart';

class WaitingScreen extends StatefulWidget {
  final roomId,role;
  WaitingScreen({this.roomId,this.role});
  @override
  _WaitingScreenState createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  bool p2Status;
  var db = Firestore.instance;
  String gameStatus;
  Timer timer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startWaiting();
    p2Status  = widget.role=='Host'?false:true;
  }

  void startWaiting(){
    timer = Timer.periodic(Duration(seconds: 1), (Timer t){
      print('waiting');
     if(p2Status){
       setState(() {
         p2Status = p2Status;
       });
     }
     if(gameStatus=='Started'){
       timer.cancel();
       Navigator.push(context, MaterialPageRoute(builder: (context){
         return GameScreen(roomId: widget.roomId,role: widget.role,);
       }));
     }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<DocumentSnapshot>(
                stream: db.collection("game_room").document(widget.roomId).snapshots(),
                builder: (c,snap){
                  if(snap.hasData){
//                  print(snap.data['board']);
                    p2Status = snap.data['player2'];
                    gameStatus=snap.data['gameStatus'];
                  }
                  return Container();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('Player1 Status',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                SizedBox(width: 10.0,),
                Text('Online',style: TextStyle(color: Colors.green,fontSize: 20.0,fontWeight: FontWeight.w900),)
              ],),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                Text('Player2 Status',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                SizedBox(width: 10.0,),
                Text(p2Status?'online':'Offline',style: TextStyle(color: p2Status?Colors.green:Colors.red,fontSize: 20.0,fontWeight: FontWeight.w900),)
              ],),
              SizedBox(height: 30.0,),
              Text(widget.roomId,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w900),),
              SizedBox(height: 20.0,),
              widget.role=='Host'?GestureDetector(
                onTap: (){
                      startgame();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  padding: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [BoxShadow(color: Colors.black45,offset: Offset(2,2),blurRadius: 5.0),
                      BoxShadow(color: Colors.black45,offset: Offset(2,-2),blurRadius: 5.0),
                      BoxShadow(color: Colors.black45,offset: Offset(-2,2),blurRadius: 5.0),
                      BoxShadow(color: Colors.black45,offset: Offset(-2,-2),blurRadius: 5.0)],
                  ),
                  child: Text('Start Game',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                ),
              ):Text('Waiting for start')
            ],
          ),
        ),
      ),
    );
  }

  void startgame() {
    if(p2Status){
      print('gamestart');
      db.collection("game_room").document(widget.roomId).updateData({'gameStatus':'Started'});
//      Navigator.push(context, MaterialPageRoute(builder: (context){
//        return GameScreen(roomId:widget.roomId);
//      }));
    }
  }
}
