import 'package:flutter/material.dart';

import 'home_page.dart';

class MyTrashBallGameApp extends StatelessWidget {
  const MyTrashBallGameApp({super.key});


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}