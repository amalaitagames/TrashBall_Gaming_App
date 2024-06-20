import 'dart:math';

import 'package:code/entity/EBonus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseBonusWidget extends StatefulWidget {
  final void Function(EBonus) setBonus;

  const ChooseBonusWidget({super.key, required this.setBonus});

  @override
  State<ChooseBonusWidget> createState() => _ChooseBonusWidgetState();
}

class _ChooseBonusWidgetState extends State<ChooseBonusWidget> {

  List<EBonus> bonusList = [
    EBonus.precision_plus_1,
    EBonus.panier_vaut_2,
    EBonus.panier_vaut_3,
    EBonus.precision_plus_2,
    EBonus.precision_plus_3,
    EBonus.precision_plus_4,
    EBonus.precision_plus_5,
    EBonus.precision_plus_6,
    EBonus.seconde_chance
  ];

  List<EBonus> bonusBtns = [];

  EBonus? chosenBonus;
  bool isShootPossible = true;
  bool getBonus = false;
  int bucketsLeftBeforeBonus = 3;


  void choisirBonus(EBonus bonus) {
      widget.setBonus(bonus);
  }

  @override
  void initState() {
    for (int i = 0; i < 3; i++) {
      bonusBtns.add(bonusList[Random().nextInt(bonusList.length)]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.lightBlueAccent,
              style: BorderStyle.solid,
              width: 5),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 10, 20, 20),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [
                  Text(
                    'Choisissez un bonus :',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment:
              MainAxisAlignment.spaceAround,
              crossAxisAlignment:
              CrossAxisAlignment.center,
              children: [
                for (EBonus bonus in bonusBtns)
                  Padding(
                    padding:
                    const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            choisirBonus(bonus);
                          },
                          child: Image(
                            image: AssetImage(
                                bonus.img),
                          ),
                        ),
                        Text(bonus.nom)
                      ],
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}