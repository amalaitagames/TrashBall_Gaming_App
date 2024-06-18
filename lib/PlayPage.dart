import 'dart:math';

import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import './all_bluetooth.dart';

class PlayPage extends StatefulWidget {
  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  bool _isLeft = false;

  double leftPosition = 0;
  double topPosition = 50;

  List<double> positionsListe = [
    20,
    60,
    80,
    100,
    120,
    140,
    160,
    180,
    200,
    220,
    240,
    260,
    280,
    300,
    320,
    340,
    360
  ];

  void _togglePosition() {
    setState(() {
      if(_isLeft) {
        topPosition = 50;
      }
      _isLeft = !_isLeft;
      var nextPosition = Random().nextInt(positionsListe.length);
      leftPosition = positionsListe[nextPosition];
      print('left change to : ${leftPosition}');
    });
    sendPoints();
  }

  void sendPoints() async {
    if ((leftPosition >= 120 && leftPosition <= 220) && topPosition == 50 && _isLeft) {
      print('vous avez marquez un panier !!!');
      await Future.delayed(const Duration(seconds: 1));
      AllBluetooth().sendMessage('Panier marqué !');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.expand,
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      color: Colors.blueAccent,
                    )
                  ]),
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
                      width: 20,
                      height: 20,
                      color: _isLeft ? Colors.blue : Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _togglePosition, // Call _togglePosition when pressed
        child: Icon(Icons.swap_horiz), // Icon to display on the button
      ),
    );
  }
}
