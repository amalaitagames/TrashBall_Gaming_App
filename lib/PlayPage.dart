import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'choose_bonus_widget.dart';
import 'game_state.dart';

class PlayPage extends StatefulWidget {
  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  late final gameState = GameState(update: () {
    setState(() {});
  });

  void _togglePosition() {
    if (gameState.isShootPossible) {
      setState(() {
        gameState.togglePosition();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chosenBonus = gameState.chosenBonus;
    setState(() {
      gameState.chosenBonus = chosenBonus;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('TrashBall Game'),
        backgroundColor: const Color.fromRGBO(38, 60, 101, 100),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: context.height,
            child: Column(
              children: [
                Container(
                  color: Color.fromRGBO(213, 119, 24, 1.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0),
                          child: Text(
                            'Score: ${gameState.score} / ${gameState.nbrTir}',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Bonus: '),
                              if (gameState.bucketsLeftBeforeBonus != 0 &&
                                  !gameState.bonusChoose)
                                Image(
                                    image: AssetImage(
                                        gameState.countBeforeBonusPng)),
                              if (chosenBonus != null)
                                Image(image: AssetImage(chosenBonus.img))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            scale: 0.42,
                            image: AssetImage('assets/terrain.png')),
                        color: Colors.black12),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      fit: StackFit.expand,
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: gameState.panierTaille,
                                height: gameState.panierTaille,
                                child: Image(
                                  image: AssetImage(gameState.panier),
                                  alignment: Alignment.center,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            ]),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (gameState.result != '' && !gameState.getBonus)
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      border: Border.all(
                                          color: setColorAfterShootResult(),
                                          width: 3,
                                          style: BorderStyle.solid),
                                      color: Colors.white),
                                  child: Text(
                                    gameState.result,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: setColorAfterShootResult(),
                                        backgroundColor: Colors.white),
                                  ),
                                ),
                              ),
                            if (gameState.getBonus)
                              ChooseBonusWidget(
                                setBonus: (bonus) {
                                  setState(() {
                                    gameState.setEBonus(bonus);
                                    gameState.bucketsLeftBeforeBonus = 3;
                                    gameState.countBeforeBonusPng;
                                    gameState.getBonus = false;
                                    gameState.bonusChoose = true;
                                    gameState.resetMainValues();
                                  });
                                },
                              )
                          ],
                        ),
                        Positioned(
                          left: 10,
                          bottom: 40,
                          child: Image(image: AssetImage(gameState.rack)),
                        ),
                        AnimatedPositioned(
                          left: gameState.isLeft ? gameState.leftPosition : 185,
                          top: gameState.isLeft ? gameState.topPosition : 500,
                          // Fixed top position
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInCubic,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: gameState.ballonTaille,
                                height: gameState.ballonTaille,
                                child: Opacity(
                                  opacity: gameState.opacity,
                                  child: const Image(
                                    image: AssetImage('assets/ballon.png'),
                                    fit: BoxFit.fill,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: _togglePosition, // Call _togglePosition when pressed
          child: Text(
            'Tirer',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: gameState.isShootPossible
              ? Colors.green
              : Colors.black12), // Icon to display on the button
    );
  }

  MaterialColor setColorAfterShootResult() {
    return gameState.couleurText =
        gameState.panierMarque ? Colors.green : Colors.red;
  }
}
