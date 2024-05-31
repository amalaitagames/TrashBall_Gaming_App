import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:all_bluetooth/all_bluetooth.dart';
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
    print(devices);
  }

  void discoverNewDevices() {
    allBluetooth.discoverDevices.listen((device) {
      print('Scanning for new devices...');
      newDevices.add(device);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //getDevices();
  }

  @override
  Widget build(BuildContext context) {
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
                allBluetooth
                    .startBluetoothServer()
                    .then((value) => print('Serveur démarré...'));
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
                                        print('connected')
                                      });
                                  //allBluetooth.listenForConnection.listen((event) {
                                    //print(event);
                                  //});

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
                      discoverNewDevices();
                      print('Search pressed...');

                      allBluetooth.startDiscovery().then((value) =>
                      {
                        print('Starting...'),
                      });
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
          discoverNewDevices();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
