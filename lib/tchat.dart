import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TchatPage extends StatefulWidget {
  final String testParam;
  TchatPage(this.testParam);

  @override
  State<TchatPage> createState() => _TchatPageState();
}

class _TchatPageState extends State<TchatPage> {

  List<String> listeMessages = ['test'];
  TextEditingController controller = TextEditingController();
  late String testParam = widget.testParam;
  @override
  void initState() {
    controller.text = testParam;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AllBluetooth().listenForData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var mess = snapshot.requireData;
            listeMessages.add(mess as String);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Tchat'),
            ),
            body: Center(
              child: Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    children: [
                      for (String mess in listeMessages)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(mess),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            controller: controller,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () => {
                                if (controller.value.text != '')
                                  {
                                    AllBluetooth()
                                        .sendMessage(controller.value.text),
                                    setState(() {
                                      listeMessages.add(controller.value.text);
                                      controller.clear();
                                    })
                                  }
                              },
                          icon: Icon(Icons.send))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
