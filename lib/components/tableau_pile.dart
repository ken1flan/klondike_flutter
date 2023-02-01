import 'package:flame/components.dart';
import 'package:flutter/widgets.dart';
import 'package:klondike_flutter/components/pile.dart';
import 'package:klondike_flutter/klondike_game.dart';
import 'package:klondike_flutter/components/card.dart';

class TableauPile extends PositionComponent implements Pile {
  TableauPile({super.position}) : super(size: KlondikeGame.cardSize);

  final List<Card> _cards = [];
  final _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10
    ..color = const Color(0x50ffffff);
  final Vector2 _fanOffset = Vector2(0, KlondikeGame.cardHeight * 0.05);

  @override
  bool get debugMode => true;

  @override
  bool canMoveCard(Card card) => _cards.isNotEmpty && card == _cards.last;

  void acquireCard(Card card) {
    if (_cards.isEmpty) {
      card.position = position;
    } else {
      card.position = _cards.last.position + _fanOffset;
    }
    card.priority = _cards.length;
    card.pile = this;
    _cards.add(card);
  }

  void flipTopCard() {
    assert(_cards.last.isFaceDown);
    _cards.last.flip();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(KlondikeGame.cardRRect, _borderPaint);
  }
}
