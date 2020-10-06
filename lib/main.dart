import 'package:flutter/material.dart';
import 'package:flutter_carwashing/telas/agenda/agendaListTela.dart';
import 'package:flutter_carwashing/telas/splashTela.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
      MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [const Locale('pt', 'BR')],
        debugShowCheckedModeBanner: false,
          home:splashTela(),
          //home:agendaListTela(),
    )
  );
}
