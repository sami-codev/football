import 'package:flutter/material.dart';
import '../../../models/player.dart';



class DraggablePlayer extends StatelessWidget {
  final Player player;
  Function onAccept;

  DraggablePlayer({
    super.key,
    required this.player,
    required this.onAccept,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Player>(
        onWillAccept: (data) => true,
        onAccept: (p){onAccept(p);},
        builder: (context, accepted, rejected) {
          return Draggable<Player>(
            data: player,
            feedback: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Image.asset(player.type==PlayerType.home?'assets/home.png':player.type==PlayerType.away?'assets/away.png':'assets/reserve.png',width: 30,height: 30,),
                  Text(
                    player.name,
                    style: const TextStyle(color: Colors.white, fontSize: 9),
                  )
                ],
              ),
            ),
            childWhenDragging: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              child: const Text(
                '+',
                style: TextStyle(color: Colors.grey, fontSize: 24),
              ),
            ),
            onDragCompleted: (){},
            child: Column(
              children: [
                Image.asset(player.type==PlayerType.home?'assets/home.png':player.type==PlayerType.away?'assets/away.png':'assets/reserve.png',width: 30,height: 30,),
                Container(
                  margin: const EdgeInsets.only(top: 3),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                  child: Text(
                    player.name,
                    style: const TextStyle(color: Colors.black, fontSize: 9,fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        }
    );
  }
}
