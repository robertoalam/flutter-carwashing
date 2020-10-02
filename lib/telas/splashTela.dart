import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carwashing/helper/database.dart';
import 'package:flutter_carwashing/telas/homeTela.dart';
import 'package:flutter_carwashing/telas/servico/servicoListTela.dart';

class splashTela extends StatefulWidget {
  @override
  _splashTelaState createState() => _splashTelaState();
}

class _splashTelaState extends State<splashTela> {

  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
    Timer( Duration(seconds: 1) , ()=>
        Navigator.pushReplacement( context,  MaterialPageRoute( builder: (context) => homeTela() ) ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(color: Colors.green),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("images/igti.png"),
        ],
      ),
    );
  }

  void _init() async {
    final allRows = await dbHelper.queryAllRows('cliente');
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }
}
