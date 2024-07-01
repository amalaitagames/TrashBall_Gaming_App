import 'package:all_bluetooth/all_bluetooth.dart';
import 'package:TrashBall/searchNewDevicesBle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllBluetoothClass extends StatefulWidget {
  @override
  State<AllBluetoothClass> createState() => _AllBluetoothClassState();
}

class _AllBluetoothClassState extends State<AllBluetoothClass> {
  final allBluetooth = AllBluetooth();
  List<BluetoothDevice> devices = [];
  List<BluetoothDevice> newDevices = [];

  void getDevices() async {
    devices = await allBluetooth.getBondedDevices();
  }



  void openDiscovery() async {
    allBluetooth.startDiscovery();
  }

  @override
  void initState() {
    super.initState();
    openDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: AllBluetooth().streamBluetoothState,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            print(snapshot);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Connexion Bluetooth'),
              backgroundColor: context.theme.highlightColor,
            ),
            body: Column(children: [
              Row(
                children: [
                  Text('Faire de ce téléphone un serveur'),
                  IconButton(
                    onPressed: () {
                      allBluetooth.startBluetoothServer();
                      allBluetooth.listenForConnection.isBroadcast;
                      //allBluetooth.instance.startDiscovery();
                    },
                    icon: Icon(Icons.network_wifi),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Appareils enregistrés : '),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            getDevices();
                          });
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView(
                  children: [
                    for (BluetoothDevice device in devices)
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
                                      allBluetooth
                                          .connectToDevice(device.address)
                                          .then((value) => {
                                                print('connected'),
                                                allBluetooth.listenForData
                                                    .listen((event) {
                                                  print(event);
                                                })
                                              });
                                      allBluetooth.instance.startDiscovery();
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Découvrir de nouveaux appareils : '),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchNewBleDevices()));
                          });
                        },
                        icon: Icon(Icons.search))
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView(
                  children: [
                    for (BluetoothDevice newDevice in newDevices)
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(newDevice.name),
                                Text(newDevice.address),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.bluetooth_connected)),
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {

              },
              child: Icon(Icons.refresh),
            ),
          );
        });
  }
}
