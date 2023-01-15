import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:klondike_flutter/components/waste_pile.dart';
import 'package:klondike_flutter/klondike_game.dart';
import 'package:klondike_flutter/components/card.dart';

class StockPile extends PositionComponent with TapCallbacks {
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

  @override
  void onTapUp(TapUpEvent event) {
    final wastePile = parent!.firstChild<WastePile>()!;
    for (var i = 0; i < 3; i++) {
      if (_cards.isNotEmpty) {
        final card = _cards.removeLast();
        card.flip();
        wastePile.acquireCard(card);
      }
    }
  }
}
