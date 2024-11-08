enum PlayerType { home, away, substitute }

class Player {
  String id;
  String name;
  PlayerType type;

  Player({
    required this.id,
    required this.name,
    required this.type,
  });

  Player copyWith({PlayerType? type}) {
    return Player(
      id: id,
      name: name,
      type: type ?? this.type,
    );
  }
}
