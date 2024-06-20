import 'package:code/bleAlternatives/plus_bluetooth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class PlusBlue extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<PlusBlueController>(
        init: PlusBlueController(),
        builder: (controller) {

          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    width: double.infinity,
                    color: Colors.blue,
                    child: Text('Bluetooth App'),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () =>
                          controller.scanDevices(),
                        child: Text('Chercher nouveau device...'
                        )
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<List<ScanResult>>(
                    stream: controller.scannedDevices,
                    builder: (context, snapshots){
                      if(snapshots.hasData)
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshots.data!.length,
                          itemBuilder: (context, index) {
                            final data = snapshots.data![index];
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(data.device.name),
                                subtitle: Text(data.device.id.id),
                                trailing: Text(data.rssi.toString()),
                              ),
                            );
                      });
                    else {
                      return const Center(
                        child: Text("No device found..."),
                      );
                      }
                    }
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}