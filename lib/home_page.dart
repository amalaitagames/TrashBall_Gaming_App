import 'package:code/all_bluetooth.dart';
import 'package:code/basic_blue.dart';
import 'package:code/plus_blue_view.dart';
import 'package:code/plus_bluetooth.dart';
import 'package:flutter/material.dart';

import 'PlayPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: Container(
                    color: const Color.fromRGBO(38, 60, 101, 100),
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'TrashBall Gaming Simulator',
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(38, 60, 101, 100),
                  child: const Image(
                    image: AssetImage('assets/logoTPV5.png'),
                    alignment: Alignment.center,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                color: const Color.fromRGBO(38, 60, 101, 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.blueAccent),
                      ),
                      child: const Text('Commencer la partie'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PlayPage()));
                      },
                    ),
                    ElevatedButton(onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AllBluetoothClass()));
                    }, child: Text('bluetooth'))
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
