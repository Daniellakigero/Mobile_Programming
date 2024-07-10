import 'package:battery_plus/battery_plus.dart';
// import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BatteryService {
  final Battery _battery = Battery();

  void startMonitoring() {
    _battery.onBatteryStateChanged.listen((BatteryState state) async {
      if (state == BatteryState.charging) {
        int batteryLevel = await _battery.batteryLevel;
        if (batteryLevel >= 90) {
          Fluttertoast.showToast(
            msg: "Battery level is $batteryLevel%. Please unplug your charger.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
          );
        }
      }
    });
  }
}
