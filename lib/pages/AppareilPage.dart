import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';

class ListeAppareilPage extends StatefulWidget {
  @override
  _ListeAppareilPageState createState() => _ListeAppareilPageState();
}

class _ListeAppareilPageState extends State<ListeAppareilPage> {
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  List<BluetoothDevice> _devicesList = [];
  bool _isConnecting = false;

  @override
  void initState() {
    super.initState();
    _requestBluetoothPermissions().then((granted) {
      if (granted) {
        _getDevicesList();
      }
    });
  }

  Future<bool> _requestBluetoothPermissions() async {
    PermissionStatus bluetoothStatus = await Permission.bluetooth.request();
    PermissionStatus locationStatus = await Permission.locationWhenInUse.request();

    return bluetoothStatus.isGranted && locationStatus.isGranted;
  }

  Future<void> _getDevicesList() async {
    try {
      // Récupère la liste des appareils connectés
      final connectedDevices = await _bluetooth.getBondedDevices();
      setState(() {
        _devicesList = connectedDevices;
      });
    } catch (e) {
      print('Error getting connected devices: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appareils Bluetooth'),
      ),
      body: _devicesList.isEmpty
          ? Center(child: Text('Aucun appareil Bluetooth connecté'))
          : ListView.builder(
        itemCount: _devicesList.length,
        itemBuilder: (context, index) {
          final device = _devicesList[index];
          return ListTile(
            title: Text(device.name ?? 'Appareil inconnu'),
            subtitle: Text(device.address),
          );
        },
      ),
    );
  }
}