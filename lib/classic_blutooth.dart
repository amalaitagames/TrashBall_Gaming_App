/*import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class Classic_BluetoothScannerPage extends StatefulWidget {
  const Classic_BluetoothScannerPage({Key? key}) : super(key: key);

  @override
  State<Classic_BluetoothScannerPage> createState() =>
      _Classic_BluetoothScannerPageState();
}

class _Classic_BluetoothScannerPageState
    extends State<Classic_BluetoothScannerPage> {
  late BluetoothConnection _connection;
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  Future<void> _connectToDevice() async {
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    FlutterBluetoothSerial.instance.startDiscovery().forEach((element) {
      print('device: ${element.device}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: Column(
        children: [
          Container(
            child: Text('Liste de devices bluetooth trouvés :'),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                for (BluetoothDevice device in devices)
                  Card(
                    child: Text('nom : ${device.name}'),
                  );
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _connectToDevice();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
*/