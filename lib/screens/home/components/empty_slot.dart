import 'package:flutter/material.dart';
import '../../../models/player.dart';

class EmptyPosition extends StatelessWidget {
  final void Function(Player player) onAcceptPlayer;
  const EmptyPosition({
    super.key,
    required this.onAcceptPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<Player>(
      onWillAccept: (data) => true,
      onAccept: onAcceptPlayer,
      builder: (context, accepted, rejected) {
        return Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            '+',
            style: TextStyle(color: Colors.grey, fontSize: 24),
          ),
        );
      },
    );
  }
}
