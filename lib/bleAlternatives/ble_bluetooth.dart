/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLE_BluetoothScannerPage extends StatefulWidget {
  @override
  State<BLE_BluetoothScannerPage> createState() => _BLE_BluetoothScannerPageState();
}

class _BLE_BluetoothScannerPageState extends State<BLE_BluetoothScannerPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];

  @override
  void initState() {
    super.initState();
    print('Start bluetooth page...');
    _startScanning();
  }

  void _startScanning() {
    print('scan should start');
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

// Stop scanning
    flutterBlue.stopScan();

  }

  @override
  void dispose() {
    flutterBlue.stopScan();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blueetooh Devices'),
      ),
      body: ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(devices[index].name),
              subtitle: Text(devices[index].id.toString()),
              onTap: () {
                print('Connect to this device...');
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startScanning();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
    } catch (e) {
      print('Error: $e');
    }
  }

  void _discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      print('Service: ${service.uuid}');

      for (BluetoothCharacteristic characteristic in service.characteristics) {
        print('Characteristic: ${characteristic.uuid}');
      }
    }
  }

  void _readCharacteristic(BluetoothCharacteristic characteristic) async {
    List<int> value = await characteristic.read();
    print('Read value: $value');
  }

  void _writeCharacteristic(
      BluetoothCharacteristic characteristic, List<int> data) async {
    await characteristic.write(data);
    print('Data written successfully');
  }

  void _setupNotifications(BluetoothCharacteristic characteristic) async {
    await characteristic.setNotifyValue(true);
    characteristic.value.listen((value) {
      print('Notification received: $value');
    });
  }
}
*/