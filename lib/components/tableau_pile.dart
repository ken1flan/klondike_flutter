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
  final Vector2 _fanOffset1 = Vector2(0, KlondikeGame.cardHeight * 0.05);
  final Vector2 _fanOffset2 = Vector2(0, KlondikeGame.cardHeight * 0.20);

  @override
  bool get debugMode => true;

  @override
  bool canMoveCard(Card card) => card.isFaceUp;

  @override
  bool canAcceptCard(Card card) {
    if (_cards.isEmpty) {
      return card.rank.value == 13;
    } else {
      final topCard = _cards.last;
      return card.suit.isRed == !topCard.suit.isRed &&
          card.rank.value == topCard.rank.value - 1;
    }
  }

  @override
  void removeCard(Card card) {
    assert(_cards.contains(card) && card.isFaceUp);
    final index = _cards.indexOf(card);
    _cards.removeRange(index, _cards.length);
    if (_cards.isNotEmpty && _cards.last.isFaceDown) {
      flipTopCard();
    }
    layoutCards();
  }

  @override
  void acquireCard(Card card) {
    if (_cards.isEmpty) {
      card.position = position;
    } else {
      card.position = _cards.last.position + _fanOffset;
    }
    card.priority = _cards.length;
    card.pile = this;
    _cards.add(card);
    layoutCards();
  }

  @override
  void returnCard(Card card) {
    final index = _cards.indexOf(card);
    card.position =
        index == 0 ? position : _cards[index - 1].position + _fanOffset;
    card..priority = index;
    layoutCards();
  }

  void flipTopCard() {
    assert(_cards.last.isFaceDown);
    _cards.last.flip();
  }

  void layoutCards() {
    if (_cards.isEmpty) {
      return;
    }
    _cards[0].position.setFrom(position);
    for (var i = 1; i < _cards.length; i++) {
      _cards[i].position
        ..setFrom(_cards[i - 1].position)
        ..add(_cards[i - 1].isFaceDown ? _fanOffset1 : _fanOffset2);
    }
    height = KlondikeGame.cardHeight * 1.5 + _cards.last.y - _cards.first.y;
  }

  List<Card> cardsOnTop(Card card) {
    assert(card.isFaceUp && _cards.contains(card));
    final index = _cards.indexOf(card);
    return _cards.getRange(index + 1, _cards.length).toList();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(KlondikeGame.cardRRect, _borderPaint);
  }
}
