import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../enum/connectivity_status.dart';
import '../widgets/network_sensitivity.dart';

class InternetService extends NetworkSensitive {

  final BuildContext context;
  var connectionStatus;
  InternetService(this.context){
    connectionStatus = Provider.of<ConnectivityStatus>(context);
  }

  String get status{
    if (connectionStatus == ConnectivityStatus.WiFi) {
      return "wifi";
    }

    if (connectionStatus == ConnectivityStatus.Cellular) {
      return "movel";
    }

    return "offline";
  }

//print( connectionStatus );

}