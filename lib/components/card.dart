import 'package:flame/components.dart';
import 'package:klondike_flutter/klondike_game.dart';
import 'package:klondike_flutter/suit.dart';
import 'package:klondike_flutter/rank.dart';

class Card extends PositionComponent {
  Card(int intRank, int intSuit)
      : rank = Rank.of(intRank),
        suit = Suit.fromInt(intSuit),
        _faceUp = false,
        super(size: KlondikeGame.cardSize);

  final Rank rank;
  final Suit suit;
  bool _faceUp;

  bool get isFaceUp => _faceUp;
  void flip() => _faceUp = !_faceUp;

  @override
  String toString() => rank.label + suit.label;
}
