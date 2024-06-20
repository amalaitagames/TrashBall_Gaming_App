import 'dart:math';

import 'package:code/choose_bonus_widget.dart';
import 'package:code/entity/EBonus.dart';
import 'package:code/entity/ETypeBonus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayPage extends StatefulWidget {
  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  bool _isLeft = false;
  double panierTaille = 128;
  double ballonTaille = 44;
  double leftPosition = 0;
  double topPosition = 50;
  String _panier = '';
  double _opacity = 1;
  bool _isShootPossible = true;
  bool _panierMarque = false;
  String _result = '';
  int _score = 0;
  int _nbrTir = 0;
  Color? _couleurText;
  String _rack = 'assets/Rack_3Balls.png';
  int _serie = 0;
  String? _bordersColor;
  Color? _floatingActionBtnColor;
  List<double> positionsListe = [120, 140, 160, 180, 200, 220, 240, 260, 280];
  EBonus? _chosenBonus;
  bool _getBonus = false;
  int _bucketsLeftBeforeBonus = 3;
  String _countBeforeBonusPng = 'assets/count_before_bonus0.png';
  final String _panierPng = 'assets/panier.png';
  final String _panierGif = 'assets/panier.gif';

  void _togglePosition() {
    if (_isShootPossible) {
      setState(() {
        _isShootPossible = false;
        _nbrTir++;
        print('get bonus: $_getBonus');
        print('$_bucketsLeftBeforeBonus');
        changeRackImage();
        if (_isLeft) {
          topPosition = 50;
        }
        _isLeft = !_isLeft;
        if (_chosenBonus == null ||
            _chosenBonus!.type != ETypeBonus.precision) {
          setShootPosition(0);
        }
        if (_chosenBonus != null &&
            _chosenBonus?.type == ETypeBonus.precision) {
          setShootPosition(_chosenBonus!.valeur);
          _chosenBonus = null;
        }
      });
      sendPoints();
    }
  }

  void setShootPosition(int bonusReduction) {
    var nextPosition = Random().nextInt(positionsListe.length - bonusReduction);
    leftPosition = positionsListe[nextPosition];
  }

  void sendPoints() async {
    if ((leftPosition >= 140 && leftPosition <= 180) &&
        topPosition == 50 &&
        _isLeft) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _panier = _panierGif;
        setOnBasketScoreValues();
      });

      //AllBluetooth().sendMessage('Panier marqué !');
      await Future.delayed(const Duration(seconds: 2));
      refresh();
    } else {
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _result = 'VOUS AVEZ MANQUÉ ...';
        _opacity = 0;
      });
      refresh();
    }
  }

  void setOnBasketScoreValues() {
    _opacity = 0;
    _panierMarque = true;
    _result = 'VOUS AVEZ MARQUÉ !!!';
    if (_chosenBonus != null &&
        _chosenBonus!.type == ETypeBonus.nbrPointParPanier) {
      _score += _chosenBonus!.valeur;
      _bucketsLeftBeforeBonus--;
    } else {
      _score++;
      _bucketsLeftBeforeBonus--;
      setCountBeforeBonusPng();
    }
  }

  checkIfPlayerCanGetBonus() {
    if (_bucketsLeftBeforeBonus == 0) {
      _getBonus = true;
      _isShootPossible = false;
    }
  }

  void resetMainValues() {
    _opacity = 1;
    _panierMarque = false;
    _isShootPossible = true;
    _chosenBonus = null;
  }

  void refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      checkForPanierPng();
      _isLeft = !_isLeft;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _result = '';
      if (_serie == 0) {
        changeRackImage();
      }
      resetMainValues();
      checkIfPlayerCanGetBonus();
    });
  }

  void changeRackImage() {
    switch (_serie) {
      case 0:
        _rack = 'assets/Rack_3Balls.png';
        _serie++;
        break;
      case 1:
        _rack = 'assets/Rack_2Balls.png';
        _serie++;
        break;
      case 2:
        _rack = 'assets/Rack_1Ball.png';
        _serie++;
        break;
      case 3:
        _rack = 'assets/Rack_empty.png';
        _serie = 0;
        break;
    }
  }

  checkForPanierPng() {
    if (_panier != _panierPng) {
      _panier = _panierPng;
    }
  }

  setCountBeforeBonusPng() {
      switch (_bucketsLeftBeforeBonus) {
        case 0:
          _countBeforeBonusPng = 'assets/count_before_bonus3.png';
          break;
        case 1:
          _countBeforeBonusPng = 'assets/count_before_bonus2.png';
          break;
        case 2:
          _countBeforeBonusPng = 'assets/count_before_bonus1.png';
          break;
        case 3:
          _countBeforeBonusPng = 'assets/count_before_bonus0.png';
          break;
      }
  }

  @override
  void initState() {
    _panier = _panierPng;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 0),
                        child: Text(
                          'Score: $_score / $_nbrTir',
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
                            if (_bucketsLeftBeforeBonus != 0 &&
                                _chosenBonus == null)
                              Image(image: AssetImage(_countBeforeBonusPng)),
                            if (_chosenBonus != null)
                              Image(image: AssetImage(_chosenBonus!.img))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            scale: 0.1,
                            image: AssetImage('assets/terrain.png'))),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      fit: StackFit.expand,
                      children: <Widget>[
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: panierTaille,
                                height: panierTaille,
                                child: Image(
                                  image: AssetImage(_panier),
                                  alignment: Alignment.center,
                                  fit: BoxFit.fitHeight,
                                ),
                              )
                            ]),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_result != '' && !_getBonus)
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
                                    _result,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: setColorAfterShootResult(),
                                        backgroundColor: Colors.white),
                                  ),
                                ),
                              ),
                            if (_getBonus)
                              ChooseBonusWidget(
                                setBonus: (bonus) {
                                  _chosenBonus = bonus;
                                  print('bonus img: ${_chosenBonus!.img}');

                                  setState(() {
                                    _bucketsLeftBeforeBonus = 3;

                                    _getBonus = false;
                                    resetMainValues();
                                  });
                                },
                              )
                          ],
                        ),
                        Positioned(
                          left: 10,
                          bottom: 40,
                          child: Image(image: AssetImage(_rack)),
                        ),
                        AnimatedPositioned(
                          left: _isLeft ? leftPosition : 185,
                          top: _isLeft ? topPosition : 500,
                          // Fixed top position
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInCubic,
                          onEnd: () {
                            print(_isLeft);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: ballonTaille,
                                height: ballonTaille,
                                child: Opacity(
                                  opacity: _opacity,
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
          onPressed: _togglePosition, // Call _togglePosition when pressed
          child: Text('Tirer'),
          backgroundColor: _isShootPossible
              ? Colors.green
              : Colors.black12), // Icon to display on the button
    );
  }

  MaterialColor setColorAfterShootResult() {
    return _couleurText = _panierMarque ? Colors.green : Colors.red;
  }
}
