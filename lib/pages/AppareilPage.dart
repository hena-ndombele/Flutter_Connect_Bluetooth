import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
class ListeAppareilPage extends StatefulWidget {
  @override
  _ListeAppareilPageState createState() => _ListeAppareilPageState();
}

class _ListeAppareilPageState extends State<ListeAppareilPage> {
  List<BluetoothDevice> _devices = [];

  @override
  void initState() {
    super.initState();
    _requestBluetoothPermission();
    _getBluetoothDevices();
  }

  void _requestBluetoothPermission() async {
    await FlutterBluetoothSerial.instance.requestEnable();
  }

  Future<bool> _requestBluetoothConnectPermission() async {
    var status = await Permission.bluetoothConnect.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.bluetoothConnect.request();
    }
    return status == PermissionStatus.granted;
  }
  Future<void> _getBluetoothDevices() async {
    if (await _requestBluetoothConnectPermission()) {
      final devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() {
        _devices = devices;
      });
    } else {
      // Gérez le cas où l'autorisation n'a pas été accordée
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth'),
      ),
      body: _devices.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final device = _devices[index];
          return ListTile(
            title: Text(device.name ?? 'Unknown'),
            subtitle: Text(device.address),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BluetoothDeviceScreen(device: device),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class BluetoothDeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  BluetoothDeviceScreen({required this.device});

  @override
  _BluetoothDeviceScreenState createState() => _BluetoothDeviceScreenState();
}

class _BluetoothDeviceScreenState extends State<BluetoothDeviceScreen> {
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  Future<void> _connectToDevice() async {
    try {
      await FlutterBluetoothSerial.instance.connect(widget.device);
      setState(() {
        _isConnected = true;
      });
    } catch (exception) {
      print('Error connecting to device: $exception');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name ?? 'Unknown'),
      ),
      body: Center(
        child: _isConnected
            ? Text('Connected to ${widget.device.name}')
            : CircularProgressIndicator(),
      ),
    );
  }
}