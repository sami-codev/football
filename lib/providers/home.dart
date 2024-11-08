import 'package:flutter/material.dart';

import '../models/player.dart';

class HomeProvider extends ChangeNotifier{
  List<Player?> res = [
    Player(id: '1', name: 'Res1', type: PlayerType.substitute),
    Player(id: '2', name: 'Res2', type: PlayerType.substitute),
    Player(id: '3', name: 'Res3', type: PlayerType.substitute),
    Player(id: '4', name: 'Res4', type: PlayerType.substitute),
    Player(id: '5', name: 'Res5', type: PlayerType.substitute),
    Player(id: '6', name: 'Res6', type: PlayerType.substitute),
    Player(id: '7', name: 'Res7', type: PlayerType.substitute),
  ];

  List<Player?> home = [
    Player(id: '8', name: 'H1', type: PlayerType.home),
    null,
    Player(id: '9', name: 'H2', type: PlayerType.home),
    Player(id: '10', name: 'H3', type: PlayerType.home),
    Player(id: '11', name: 'H4', type: PlayerType.home),
    Player(id: '12', name: 'H5', type: PlayerType.home),
    Player(id: '13', name: 'H6', type: PlayerType.home),
    null,
    Player(id: '14', name: 'H7', type: PlayerType.home),
    Player(id: '15', name: 'H8', type: PlayerType.home),
    null,
    Player(id: '16', name: 'H9', type: PlayerType.home),
    null,
    Player(id: '17', name: 'H10', type: PlayerType.home),
    null,
    null
  ];

  List<Player?> away = [
    Player(id: '18', name: 'A1', type: PlayerType.away),
    null,
    Player(id: '19', name: 'A2', type: PlayerType.away),
    Player(id: '20', name: 'A3', type: PlayerType.away),
    Player(id: '21', name: 'A4', type: PlayerType.away),
    Player(id: '22', name: 'A5', type: PlayerType.away),
    Player(id: '23', name: 'A6', type: PlayerType.away),
    null,
    Player(id: '24', name: 'A7', type: PlayerType.away),
    Player(id: '25', name: 'A8', type: PlayerType.away),
    null,
    Player(id: '26', name: 'A9', type: PlayerType.away),
    null,
    Player(id: '27', name: 'A10', type: PlayerType.away),
    Player(id: '28', name: 'A11', type: PlayerType.away),
    null
  ];

  void emptyFill(Player incomingPlayer, int currentIndex, PlayerType currentType) {
    int incomingIndex=0;
    if(incomingPlayer.type==PlayerType.substitute && !hasLimit(currentType))return;
    if((currentType==PlayerType.home && incomingPlayer.type==PlayerType.away)||(currentType==PlayerType.away&&incomingPlayer.type==PlayerType.home))return;

    if(incomingPlayer.type==PlayerType.substitute){
      incomingIndex=res.indexWhere((element) => element!=null&&element.id==incomingPlayer.id);
      res[incomingIndex]=null;
    }else if(incomingPlayer.type==PlayerType.away){
      incomingIndex=away.indexWhere((element) => element!=null&&element.id==incomingPlayer.id);
      away[incomingIndex]=null;
    }else if(incomingPlayer.type==PlayerType.home){
      incomingIndex=home.indexWhere((element) => element!=null&&element.id==incomingPlayer.id);
      home[incomingIndex]=null;
    }

    if(currentType==PlayerType.substitute){
      res[currentIndex]=incomingPlayer;
      res[currentIndex]!.type=PlayerType.substitute;
    }else if(currentType==PlayerType.away){
      away[currentIndex]=incomingPlayer;
      away[currentIndex]!.type=PlayerType.away;
    }else if(currentType==PlayerType.home){
      home[currentIndex]=incomingPlayer;
      home[currentIndex]!.type=PlayerType.home;
    }
    notifyListeners();
  }

  hasLimit(PlayerType currentPlayerType){
    bool limit=false;
    if(currentPlayerType==PlayerType.home){
      limit=(home.where((element) => element!=null)).length<11;
    }else if(currentPlayerType==PlayerType.away){
      limit=(away.where((element) => element!=null)).length<11;
    }else if(currentPlayerType==PlayerType.substitute){
      limit=res.where((element) => element!=null).length<7;
    }
    return limit;
  }


  void playerSwap(Player incomingPlayer, Player currentPlayer, int currentIndex) {
    if((currentPlayer.type==PlayerType.home && incomingPlayer.type==PlayerType.away)||(currentPlayer.type==PlayerType.away&&incomingPlayer.type==PlayerType.home))return;
    int incomingIndex=0;
    if(currentPlayer.type==incomingPlayer.type) {
      if (currentPlayer.type == PlayerType.away) {
        incomingIndex = away.indexWhere((element) => element != null && element.id == incomingPlayer.id);
        away[incomingIndex] = currentPlayer;
        away[currentIndex] = incomingPlayer;
      } else if (currentPlayer.type == PlayerType.home) {
        incomingIndex = home.indexWhere((element) => element != null && element.id == incomingPlayer.id);
        home[incomingIndex] = home[currentIndex];
        home[currentIndex] = incomingPlayer;
      }
    }else if(incomingPlayer.type==PlayerType.away && currentPlayer.type==PlayerType.substitute){
      incomingIndex = away.indexWhere((element) => element != null && element.id == incomingPlayer.id);
      away[incomingIndex] = res[currentIndex];
      res[currentIndex] = incomingPlayer;
      res[currentIndex]!.type=PlayerType.substitute;
      away[incomingIndex]!.type=PlayerType.away;
    }else if(incomingPlayer.type==PlayerType.home && currentPlayer.type==PlayerType.substitute){
      incomingIndex = home.indexWhere((element) => element != null && element.id == incomingPlayer.id);
      home[incomingIndex] = res[currentIndex];
      res[currentIndex] = incomingPlayer;
      res[currentIndex]!.type=PlayerType.substitute;
      home[incomingIndex]!.type=PlayerType.home;
    }else if(incomingPlayer.type==PlayerType.substitute && currentPlayer.type==PlayerType.away){
      incomingIndex = res.indexWhere((element) => element != null && element.id == incomingPlayer.id);
      res[incomingIndex] = away[currentIndex];
      away[currentIndex] = incomingPlayer;
      away[currentIndex]!.type=PlayerType.away;
      res[incomingIndex]!.type=PlayerType.substitute;
    }else if(incomingPlayer.type==PlayerType.substitute && currentPlayer.type==PlayerType.home){
      incomingIndex = res.indexWhere((element) => element != null && element.id == incomingPlayer.id);
      res[incomingIndex] = home[currentIndex];
      home[currentIndex] = incomingPlayer;
      home[currentIndex]!.type=PlayerType.home;
      res[incomingIndex]!.type=PlayerType.substitute;
    }
    notifyListeners();
  }
}