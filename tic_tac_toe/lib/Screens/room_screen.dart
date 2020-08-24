import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/Screens/game_screen.dart';
import 'package:tictactoe/Screens/waiting_screen.dart';

class RoomScreen extends StatefulWidget {
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  String partnerRoomId,myRoomId,idText="";
  var db = Firestore.instance.collection("game_room");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: <Widget>[

              SizedBox(height: 20.0,),
              GestureDetector(
                onTap: (){

                  setState(() {
                    myRoomId = DateTime.now().millisecondsSinceEpoch.toString();
                    idText = myRoomId;
                  });

                  var db = Firestore.instance.collection('game_room').document(myRoomId);
                  db.setData({
                    'roomId':myRoomId,
                    'player1':true,
                    'player2':false,
                    'board':["","","","","","","","",""],
                    'mReset':false,
                    'oReset':false,
                    'myTurn':true,
                    'opTurn':false,
                    'mScore':0,
                    'oScore':0,
                    'gameStatus':'waiting',
                    'win':false
                  });
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
                  child: Text('Create Room',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                ),
              ),
              SizedBox(height: 15.0,),
              Text('Room Id : $idText',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w900),),
              SizedBox(height: 15.0,),
              GestureDetector(
                onTap: (){

                    if(myRoomId!=null){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return WaitingScreen(roomId: myRoomId,role: 'Host',);
                      }));
                  }
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
                  child: Text('Start Room',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                ),
              ),
              SizedBox(height: 50.0,),
              Container(
                width: double.infinity,
                height: 2.0,
                color: Colors.blueGrey,
              ),
              SizedBox(height: 20.0,),
              Container(
                margin:EdgeInsets.all(20.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w900,color: Colors.lightBlueAccent,fontSize: 20.0),
                  decoration: InputDecoration(labelText: 'Enter room id',),
                  onChanged: (value){
                    partnerRoomId = value;
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              GestureDetector(
                onTap: (){
                  Firestore.instance.collection('game_room').document(partnerRoomId).updateData({'player2':true});
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return WaitingScreen(roomId: partnerRoomId,role: 'Join',);
                  }));
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
                  child: Text('Join Room',style: TextStyle(color: Colors.black,fontSize: 20.0),),
                ),
              ),
            ],
          ),
      ),
    );
  }
}
