// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:day_time_app/Setting/widgets.dart';
import 'package:day_time_app/individual/individualWindow.dart';

void main() {
  runApp(new FlutterBlueApp());
}

class FlutterBlueApp extends StatefulWidget {
  _FlutterBlueAppState state;

  FlutterBlueApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlutterBlueAppState createState() => state = new _FlutterBlueAppState();

  void vibrateON() {
    state.vibrateON();
  }
  void vibrateOFF() {
    state.vibrateOFF();
  }

}

class _FlutterBlueAppState extends State<FlutterBlueApp> with AutomaticKeepAliveClientMixin {
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  /// Scanning
  StreamSubscription _scanSubscription;
  Map<DeviceIdentifier, ScanResult> scanResults = new Map();
  bool isScanning = false;

  /// State
  StreamSubscription _stateSubscription;
  BluetoothState state = BluetoothState.unknown;

  /// Device
  BluetoothDevice device;
  bool get isConnected => (device != null);
  StreamSubscription deviceConnection;
  StreamSubscription deviceStateSubscription;
  List<BluetoothService> services = new List();
  Map<Guid, StreamSubscription> valueChangedSubscriptions = {};
  BluetoothDeviceState deviceState = BluetoothDeviceState.disconnected;

  @override
  void initState() {
    super.initState();
    // Immediately get the state of FlutterBlue
    _flutterBlue.state.then((s) {
      setState(() {
        state = s;
      });
    });
    // Subscribe to state changes
    _stateSubscription = _flutterBlue.onStateChanged().listen((s) {
      setState(() {
        state = s;
      });
    });
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    _stateSubscription = null;
    _scanSubscription?.cancel();
    _scanSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;
    super.dispose();
  }

  _startScan() {
    _scanSubscription = _flutterBlue
        .scan(
      timeout: const Duration(seconds: 5),
      /*withServices: [
          new Guid('0000180F-0000-1000-8000-00805F9B34FB')
        ]*/
    )
        .listen((scanResult) {
      print('localName: ${scanResult.advertisementData.localName}');
      print(
          'manufacturerData: ${scanResult.advertisementData.manufacturerData}');
      print('serviceData: ${scanResult.advertisementData.serviceData}');
      setState(() {
        scanResults[scanResult.device.id] = scanResult;
      });
    }, onDone: _stopScan);

    setState(() {
      isScanning = true;
    });
  }

  _stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
    setState(() {
      isScanning = false;
    });
  }

  _connect(BluetoothDevice d) async {
    device = d;
    // Connect to device
    deviceConnection = _flutterBlue
        .connect(device, timeout: const Duration(seconds: 4))
        .listen(
      null,
      onDone: _disconnect,
    );

    // Update the connection state immediately
    device.state.then((s) {
      setState(() {
        deviceState = s;
      });
    });

    // Subscribe to connection changes
    deviceStateSubscription = device.onStateChanged().listen((s) {
      setState(() {
        deviceState = s;
      });
      if (s == BluetoothDeviceState.connected) {
        device.discoverServices().then((s) {
          setState(() {
            services = s;
          });
        });
      }
    });
  }

  _disconnect() {
    // Remove all value changed listeners
    valueChangedSubscriptions.forEach((uuid, sub) => sub.cancel());
    valueChangedSubscriptions.clear();
    deviceStateSubscription?.cancel();
    deviceStateSubscription = null;
    deviceConnection?.cancel();
    deviceConnection = null;
    setState(() {
      device = null;
    });
  }

  _readCharacteristic(BluetoothCharacteristic c) async {
    await device.readCharacteristic(c);
    setState(() {});
  }

  _writeCharacteristic(BluetoothCharacteristic c) async {
    /*
    await device.writeCharacteristic(c, [0x12, 0x34],
        type: CharacteristicWriteType.withResponse);
    setState(() {});
    */
    await device.writeCharacteristic(c, [0xFFFFFFFF],
        type: CharacteristicWriteType.withoutResponse);
    setState(() {});
  }

  _writeCharacteristicON(BluetoothCharacteristic c) async {
    await device.writeCharacteristic(c, [0xFFFFFFFF],
        type: CharacteristicWriteType.withoutResponse);
    setState(() {});
  }

  _writeCharacteristicOFF(BluetoothCharacteristic c) async {
    await device.writeCharacteristic(c, [0x000000],
        type: CharacteristicWriteType.withoutResponse);
    setState(() {});
  }

  _readDescriptor(BluetoothDescriptor d) async {
    await device.readDescriptor(d);
    setState(() {});
  }

  _writeDescriptor(BluetoothDescriptor d) async {
    await device.writeDescriptor(d, [0x12, 0x34]);
    setState(() {});
  }

  _setNotification(BluetoothCharacteristic c) async {
    if (c.isNotifying) {
      await device.setNotifyValue(c, false);
      // Cancel subscription
      valueChangedSubscriptions[c.uuid]?.cancel();
      valueChangedSubscriptions.remove(c.uuid);
    } else {
      await device.setNotifyValue(c, true);
      // ignore: cancel_subscriptions
      final sub = device.onValueChanged(c).listen((d) {
        setState(() {
          print('onValueChanged $d');
        });
      });
      // Add to map
      valueChangedSubscriptions[c.uuid] = sub;
    }
    setState(() {});
  }

  _refreshDeviceState(BluetoothDevice d) async {
    var state = await d.state;
    setState(() {
      deviceState = state;
      print('State refreshed: $deviceState');
    });
  }

  _buildScanningButton() {
    if (isConnected || state != BluetoothState.on) {
      return null;
    }
    if (isScanning) {
      return new FloatingActionButton(
        child: new Icon(Icons.stop),
        onPressed: _stopScan,
        backgroundColor: Colors.red,
      );
    } else {
      return new FloatingActionButton(
          child: new Icon(Icons.search), onPressed: _startScan);
    }
  }

  _buildScanResultTiles() {
    return scanResults.values
        .map((r) => ScanResultTile(
      result: r,
      onTap: () => _connect(r.device),
    ))
        .toList();
  }

  List<Widget> _buildServiceTiles() {
    return new List<Widget>();
    return services
        .map(
          (s) => new ServiceTile(
        service: s,
        characteristicTiles: s.characteristics
            .map(
              (c) => new CharacteristicTile(
            characteristic: c,
            onReadPressed: () => _readCharacteristic(c),
            onWritePressed: () => _writeCharacteristic(c),
            onNotificationPressed: () => _setNotification(c),
            descriptorTiles: c.descriptors
                .map(
                  (d) => new DescriptorTile(
                descriptor: d,
                onReadPressed: () => _readDescriptor(d),
                onWritePressed: () =>
                    _writeDescriptor(d),
              ),
            )
                .toList(),
          ),
        )
            .toList(),
      ),
    )
        .toList();
  }

  _buildActionButtons() {
    if (isConnected) {
      return <Widget>[
        new IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () => _disconnect(),
        )
      ];
    }
  }

  _buildAlertTile() {
    return new Container(
      color: Colors.redAccent,
      child: new ListTile(
        title: new Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: new Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead.color,
        ),
      ),
    );
  }

  _buildDeviceStateTile() {
    return new ListTile(
        leading: (deviceState == BluetoothDeviceState.connected)
            ? const Icon(Icons.bluetooth_connected)
            : const Icon(Icons.bluetooth_disabled),
        title: new Text('Device is ${deviceState.toString().split('.')[1]}.'),
        subtitle: new Text('${device.id}'),
        trailing: new IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => _refreshDeviceState(device),
          color: Theme.of(context).iconTheme.color.withOpacity(0.5),
        ));
  }

  _buildProgressBarTile() {
    return new LinearProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    var tiles = new List<Widget>();
    if (state != BluetoothState.on) {
      tiles.add(_buildAlertTile());
    }
    if (isConnected) {
      tiles.add(_buildDeviceStateTile());
      /*
      tiles.addAll(_buildServiceTiles());
      */
    } else {
      tiles.addAll(_buildScanResultTiles());
    }

    return new MaterialApp(
      home: new Scaffold(
        floatingActionButton: _buildScanningButton(),
        body: new Stack(
          children: <Widget>[
            (isScanning) ? _buildProgressBarTile() : new Container(),
            new ListView(
              children: tiles,
            ),
            new Align(
              alignment: Alignment.center,
              child: new MaterialButton(
                child: new Text("Test", style: TextStyle(fontSize: 30),),
                onPressed: vibrate,
                height: 100,
                minWidth: 200,
                color: Colors.grey,
              ),
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new MaterialButton(
                child: new Text("Disconnect", style: TextStyle(fontSize: 30),),
                onPressed: () => _disconnect(),
                height: 100,
                minWidth: 200,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
    /*
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(
            "UV-Timer",style: TextStyle(color: Colors.black87),
          ),
          actions: _buildActionButtons(),

        ),
        floatingActionButton: _buildScanningButton(),
        body: new Stack(
          children: <Widget>[
            (isScanning) ? _buildProgressBarTile() : new Container(),
            new ListView(
              children: tiles,
            ),
            new RaisedButton(
              child: new Text("Vibrieren"),
                onPressed: vibrate,
            ),
          ],
        ),
      ),
    );
     */
    /*
  new DefaultTabController(
      length: 3,
      child: new Scaffold(
        backgroundColor: Colors.amber,

        appBar: new AppBar(
          title: new Text(
              "UV-Timer",style: TextStyle(color: Colors.black87),
          ),
          backgroundColor: Colors.white,
          bottom: new TabBar(
            labelColor: Colors.amber,
            unselectedLabelColor: Colors.black87,
            indicatorColor: Colors.amber,
            tabs: <Widget>[
              new Tab(icon: Icon(Icons.laptop_mac)),
              new Tab(icon: Icon(Icons.timer)),
              new Tab(text: "Verbindung"),
            ],
          ),
        ),
        body:
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.01, 0.15, 0.5, 0.9],
                colors: [
                  Colors.white,
                  Colors.limeAccent,
                  Colors.amberAccent,
                  Colors.amber,
                ],
              )
            ),
            child: new MyTabBarView() ,
          )
      ),
    );

    class MyTabBarView extends StatelessWidget {
      Widget build(BuildContext context) {
      return new TabBarView(
        children: <Widget>[
          new CalculationWindow(),
          new IndividualWindow(),
          new FlutterBlueApp(),
      ],
    );
  }
}
   */

  }

  int on = 0;
  void vibrate() {

    BluetoothService TECO = services.last;
    BluetoothCharacteristic vib = TECO.characteristics.first;

    if (on == 0) {
      _writeCharacteristicON(vib);
      on = 1;
    } else {
      _writeCharacteristicOFF(vib);
      on = 0;
    }
  }
  void vibrateOFF() {

    BluetoothService TECO = services.last;
    BluetoothCharacteristic vib = TECO.characteristics.first;

    _writeCharacteristicOFF(vib);
  }

  void vibrateON() {

    BluetoothService TECO = services.last;
    BluetoothCharacteristic vib = TECO.characteristics.first;

    _writeCharacteristicON(vib);
  }

  @override
  bool get wantKeepAlive => true;

}
