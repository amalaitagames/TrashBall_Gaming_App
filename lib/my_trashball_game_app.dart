import 'package:flutter/material.dart';
import 'package:all_bluetooth/all_bluetooth.dart';
import 'home_page.dart';

class MyTrashBallGameApp extends StatelessWidget {
  const MyTrashBallGameApp({super.key});


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AllBluetooth().listenForConnection,
      builder: (context, snapshot) {
        var device = snapshot.data?.device;
        print('update $device');
      return const MaterialApp(
        home: HomePage(),
      ); },
    );
  }
}