import 'dart:math';
import 'dart:ui';

import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:code/entity/EBonus.dart';
import 'package:code/entity/ETypeBonus.dart';

class GameState {
  final void Function() update;

  bool isLeft = false;
  final double panierTaille = 128;
  final double ballonTaille = 44;
  final String panierPng = 'assets/panier.png';
  final String panierGif = 'assets/panier.gif';

  double leftPosition = 0;
  double topPosition = 50;
  String panier = 'assets/panier.png';
  double opacity = 1;
  bool isShootPossible = true;
  bool panierMarque = false;
  String result = '';
  int score = 0;
  int nbrTir = 0;
  Color? couleurText;

  int serie = 0;
  String? bordersColor;
  Color? floatingActionBtnColor;
  List<double> positionsListe = [120, 140, 160, 160, 180, 200, 220, 240, 260, 280];
  EBonus? chosenBonus;
  bool getBonus = false;
  bool bonusChoose = false;
  int bucketsLeftBeforeBonus = 3;

  String get countBeforeBonusPng {
    switch (bucketsLeftBeforeBonus) {
      case 0:
        return 'assets/count_before_bonus3.png';
      case 1:
        return 'assets/count_before_bonus2.png';
      case 2:
        return 'assets/count_before_bonus1.png';
      case 3:
        return 'assets/count_before_bonus0.png';
      default:
        return '';
    }
  }

  String get rack {
    switch (serie) {
      case 0:
        return 'assets/Rack_3Balls.png';
      case 1:
        return 'assets/Rack_2Balls.png';
      case 2:
        return 'assets/Rack_1Ball.png';
      case 3:
        return 'assets/Rack_empty.png';
      default:
        return '';
    }
  }

  GameState({required this.update});

  void togglePosition() {
    nbrTir++;
    isShootPossible = false;
    setSerie();
    if (isLeft) {
      topPosition = 50;
    }
    isLeft = !isLeft;
    if (chosenBonus == null || chosenBonus!.type != ETypeBonus.precision) {
      setShootPosition(0);
    }
    if (chosenBonus != null && chosenBonus?.type == ETypeBonus.precision) {
      setShootPosition(chosenBonus!.valeur);
    }
    sendPoints();
    update();
  }

  void setShootPosition(int bonusReduction) {
    var nextPosition = Random().nextInt(positionsListe.length - bonusReduction);
    leftPosition = positionsListe[nextPosition];
  }

  void setSerie() {
    switch (serie) {
      case 0:
        serie++;
        break;
      case 1:
        serie++;
        break;
      case 2:
        serie++;
        break;
      case 3:
        serie = 0;
        break;
    }
  }

  void setThig() {
    opacity = 3;
    update();
  }

  sendPoints() async {
    if ((leftPosition >= 140 && leftPosition <= 180) &&
        topPosition == 50 &&
        isLeft) {
      await Future.delayed(const Duration(seconds: 1));
      panier = panierGif;
      setOnBasketScoreValues();
      AllBluetooth().sendMessage('Panier marqué +1');
      await Future.delayed(const Duration(seconds: 2));
      refresh();
    } else {
      await Future.delayed(const Duration(seconds: 1));
      result = 'VOUS AVEZ MANQUÉ ...';
      opacity = 0;
      refresh();
    }
    update();
  }

  void setOnBasketScoreValues() {
    opacity = 0;
    panierMarque = true;
    result = 'VOUS AVEZ MARQUÉ !!!';
    if (chosenBonus != null &&
        chosenBonus!.type == ETypeBonus.nbrPointParPanier) {
      score += chosenBonus!.valeur;
      bucketsLeftBeforeBonus--;
      update();
    } else {
      score++;
      bucketsLeftBeforeBonus--;
    }
    update();
  }

  checkIfPlayerCanGetBonus() {
    if (bucketsLeftBeforeBonus == 0) {
      getBonus = true;
      isShootPossible = false;
    }
    update();
  }

  void resetMainValues() {
    opacity = 1;
    panierMarque = false;
    isShootPossible = true;
    update();
  }

  refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    checkForPanierPng();
    isLeft = !isLeft;
    await Future.delayed(const Duration(seconds: 1));
    result = '';
    if (serie == 0) {
      rack;
    }
    resetMainValues();
    checkIfPlayerCanGetBonus();
    if (chosenBonus != null) {
      chosenBonus = null;
    }
    if (bonusChoose) {
      bonusChoose = !bonusChoose;
    }
    update();
  }

  checkForPanierPng() {
    if (panier != panierPng) {
      panier = panierPng;
    }
    update();
  }

  setEBonus(EBonus bonus) {
    chosenBonus = bonus;
  }
}
