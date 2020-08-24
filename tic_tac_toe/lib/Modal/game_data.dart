

import 'package:flutter/cupertino.dart';

class GameData extends ChangeNotifier{
  int mScore=0,oScore=0;
  List board=["","","","","","","","",""];

  void changeBoard(newBoard){
    board=newBoard;
    notifyListeners();
  }
}