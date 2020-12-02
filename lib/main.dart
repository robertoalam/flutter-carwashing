import 'package:flutter/material.dart';
import 'package:flutter_carwashing/enum/connectivity_status.dart';
import 'package:flutter_carwashing/services/connectivity_service.dart';
import 'package:flutter_carwashing/services/internet_service.dart';
import 'package:flutter_carwashing/telas/homeTela.dart';
import 'package:flutter_carwashing/telas/splashTela.dart';
import 'package:flutter_carwashing/widgets/network_sensitivity.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp( MyApp() );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      StreamProvider<ConnectivityStatus>(
        builder: (context) => ConnectivityService().connectionStatusController,
          child: MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: [const Locale('pt', 'BR')],
            debugShowCheckedModeBanner: false,
            home:homeTela(),
            //home:agendaListTela(),
          ),
      );
  }
}
