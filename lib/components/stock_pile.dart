import 'package:flame/components.dart';
import 'package:klondike_flutter/klondike_game.dart';
import 'package:klondike_flutter/components/card.dart';

class StockPile extends PositionComponent {
  StockPile({super.position}) : super(size: KlondikeGame.cardSize);

  @override
  bool get debugMode => true;

  final List<Card> _cards = [];

  void acquireCard(Card card) {
    assert(!card.isFaceUp);
    card.position = position;
    card.priority = _cards.length;
    _cards.add(card);
  }
}
