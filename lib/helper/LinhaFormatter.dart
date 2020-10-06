import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinhaFormatter extends StatelessWidget {
    final String text;
    final TextInputFormatter formatter;
    final TextEditingController controller;
    const LinhaFormatter({
        Key key,
        @required this.text,
        @required this.formatter,
        @required this.controller,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Row(
            children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: Text(
                        text,
                        style: const TextStyle(fontSize: 20),
                    ),
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            border: const OutlineInputBorder(),
                        ),
                        inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            formatter,
                        ],
                        keyboardType: TextInputType.number,
                    ),
                ),
            ],
        );
    }
}
