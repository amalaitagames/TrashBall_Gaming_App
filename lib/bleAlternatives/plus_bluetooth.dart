import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class PlusBlueController extends GetxController {

  Future scanDevices() async {
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    FlutterBluePlus.stopScan();
  }

  Stream<List<ScanResult>> get scannedDevices => FlutterBluePlus.scanResults;
  
}