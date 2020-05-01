import 'dart:math';

import 'package:flutter/material.dart';
import 'package:solitaire_flutter/card_column.dart';
import 'package:solitaire_flutter/empty_card.dart';
import 'package:solitaire_flutter/playing_card.dart';
import 'package:solitaire_flutter/transformed_card.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Stores the cards on the seven columns
  List<List<PlayingCard>> cardColumns = [[]];

  // Stores the card deck
  List<PlayingCard> cardDeckClosed = [];
  List<PlayingCard> cardDeckOpened = [];

  // Stores the card in the upper boxes
  List<PlayingCard> finalHeartsDeck = [];
  List<PlayingCard> finalDiamondsDeck = [];
  List<PlayingCard> finalSpadesDeck = [];
  List<PlayingCard> finalClubsDeck = [];

  @override
  void initState() {
    super.initState();
    _initialiseGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text("Flutter Solitaire"),
        elevation: 0.0,
        backgroundColor: Colors.green,
        actions: <Widget>[
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
            ),
            splashColor: Colors.white,
            onTap: () {
              _initialiseGame();
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildCardDeck(),
              _buildFinalDecks(),
            ],
          ),
          SizedBox(
            height: 16.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: CardColumn(
                  cards: cardColumns[0],
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumns[0].addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });
                  },
                  columnIndex: 1,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumns[1],
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumns[1].addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });
                  },
                  columnIndex: 2,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumns[2],
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumns[2].addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });
                  },
                  columnIndex: 3,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumns[3],
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumns[3].addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });
                  },
                  columnIndex: 4,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumns[4],
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumns[4].addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });
                  },
                  columnIndex: 5,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumns[5],
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumns[5].addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });
                  },
                  columnIndex: 6,
                ),
              ),
              Expanded(
                child: CardColumn(
                  cards: cardColumns[6],
                  onCardsAdded: (cards, index) {
                    setState(() {
                      cardColumns[6].addAll(cards);
                      int length = _getListFromIndex(index).length;
                      _getListFromIndex(index)
                          .removeRange(length - cards.length, length);
                      _refreshList(index);
                    });
                  },
                  columnIndex: 7,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Build the deck of cards left after building card columns
  Widget _buildCardDeck() {
    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            child: cardDeckClosed.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TransformedCard(
                      playingCard: cardDeckClosed.last,
                    ),
                  )
                : Opacity(
                    opacity: 0.4,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TransformedCard(
                        playingCard: PlayingCard(
                          cardSuit: CardSuit.diamonds,
                          cardType: CardType.five,
                        ),
                      ),
                    ),
                  ),
            onTap: () {
              setState(() {
                if (cardDeckClosed.isEmpty) {
                  cardDeckClosed.addAll(cardDeckOpened.map((card) {
                    return card
                      ..opened = false
                      ..faceUp = false;
                  }));
                  cardDeckOpened.clear();
                } else {
                  cardDeckOpened.add(
                    cardDeckClosed.removeLast()
                      ..faceUp = true
                      ..opened = true,
                  );
                }
              });
            },
          ),
          cardDeckOpened.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TransformedCard(
                    playingCard: cardDeckOpened.last,
                    attachedCards: [
                      cardDeckOpened.last,
                    ],
                    columnIndex: 0,
                  ),
                )
              : Container(
                  width: 40.0,
                ),
        ],
      ),
    );
  }

  // Build the final decks of cards
  Widget _buildFinalDecks() {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.hearts,
              cardsAdded: finalHeartsDeck,
              onCardAdded: (cards, index) {
                finalHeartsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 8,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.diamonds,
              cardsAdded: finalDiamondsDeck,
              onCardAdded: (cards, index) {
                finalDiamondsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 9,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.spades,
              cardsAdded: finalSpadesDeck,
              onCardAdded: (cards, index) {
                finalSpadesDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: EmptyCardDeck(
              cardSuit: CardSuit.clubs,
              cardsAdded: finalClubsDeck,
              onCardAdded: (cards, index) {
                finalClubsDeck.addAll(cards);
                int length = _getListFromIndex(index).length;
                _getListFromIndex(index)
                    .removeRange(length - cards.length, length);
                _refreshList(index);
              },
              columnIndex: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Initialise a new game
  void _initialiseGame() {
    cardColumns = new List.generate(7, (i) => []);


    // Stores the card deck
    cardDeckClosed = [];
    cardDeckOpened = [];

    // Stores the card in the upper boxes
    finalHeartsDeck = [];
    finalDiamondsDeck = [];
    finalSpadesDeck = [];
    finalClubsDeck = [];

    List<PlayingCard> allCards = [];

    // Add all cards to deck
    CardSuit.values.forEach((suit) {
      CardType.values.forEach((type) {
        allCards.add(PlayingCard(
          cardType: type,
          cardSuit: suit,
          faceUp: false,
        ));
      });
    });

    Random random = Random();

    for(int c = 0; c < 7; c++) {
      for(int i = 0; i <= c; i++) {
        int randomNumber = random.nextInt(allCards.length);
        PlayingCard card = allCards[randomNumber];
        cardColumns[c].add(
          card
            ..opened = i == c
            ..faceUp = i == c,
        );
        allCards.removeAt(randomNumber);
      }
    }

    cardDeckClosed = allCards;
    cardDeckOpened.add(
      cardDeckClosed.removeLast()
        ..opened = true
        ..faceUp = true,
    );

    setState(() {});
  }

  void _refreshList(int index) {
    if (finalDiamondsDeck.length +
            finalHeartsDeck.length +
            finalClubsDeck.length +
            finalSpadesDeck.length ==
        52) {
      _handleWin();
    }
    setState(() {
      if (_getListFromIndex(index).length != 0) {
        _getListFromIndex(index)[_getListFromIndex(index).length - 1]
          ..opened = true
          ..faceUp = true;
      }
    });
  }

  // Handle a win condition
  void _handleWin() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You Win!"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                _initialiseGame();
                Navigator.pop(context);
              },
              child: Text("Play again"),
            ),
          ],
        );
      },
    );
  }

  List<PlayingCard> _getListFromIndex(int index) {
    switch (index) {
      case 0:
        return cardDeckOpened;
      case 1:
        return cardColumns[0];
      case 2:
        return cardColumns[1];
      case 3:
        return cardColumns[2];
      case 4:
        return cardColumns[3];
      case 5:
        return cardColumns[4];
      case 6:
        return cardColumns[5];
      case 7:
        return cardColumns[6];
      case 8:
        return finalHeartsDeck;
      case 9:
        return finalDiamondsDeck;
      case 10:
        return finalSpadesDeck;
      case 11:
        return finalClubsDeck;
      default:
        return null;
    }
  }
}
