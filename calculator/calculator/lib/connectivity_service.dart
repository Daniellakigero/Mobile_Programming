import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConnectivityService {
  Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? _subscription;

  void startMonitoring() {
    _subscription =
        _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        Fluttertoast.showToast(
          msg: "Connected to the Internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Disconnected from the Internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      }
    });
  }

  void stopMonitoring() {
    _subscription?.cancel();
  }
}
