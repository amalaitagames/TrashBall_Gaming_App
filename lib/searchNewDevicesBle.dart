import 'package:flutter/cupertino.dart';
import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:flutter/material.dart';

class SearchNewBleDevices extends StatelessWidget {

  List<BluetoothDevice> newDevices = [];

  @override
  Widget build(BuildContext context) {
      return StreamBuilder(
          stream: AllBluetooth().discoverDevices,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              print(snapshot);
              newDevices?.add(snapshot.requireData);
            }
            return Scaffold(
             appBar: AppBar(
               title: Text('Chercher des nouvelles connexions'),
             ),
              body: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: TextButton(
                        child: Text('Démarrer la recherche'),
                        onPressed: () => {AllBluetooth().startDiscovery()},
                      )),
                  Expanded(
                      flex: 1,
                      child: TextButton(
                        child: Text('Arrêter la recherche'),
                        onPressed: () => {AllBluetooth().stopDiscovery()}
                      )),
                Expanded(
                  flex: 4,
                  child: ListView(
                    children: [
                      for (BluetoothDevice device in newDevices)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(device.name),
                                  Text(device.address),
                                  IconButton(
                                      onPressed: () {
                                        print('se connecter');
                                      },
                                      icon: Icon(Icons.bluetooth_connected)),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ]
              ),
            );
          });
  }
}