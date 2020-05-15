import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final String _title;
  final String _body;
  static const double _hPad = 16.0;

  TextSection(this._title, this._body);

  @override
  Widget build(BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color:Color.fromARGB(38, 0, 0, 0),blurRadius:1.0,spreadRadius:.25)],
                color: Color.fromARGB(250, 220, 243, 245)
            ),
            padding: const EdgeInsets.fromLTRB(_hPad, 32.0, _hPad, 4.0),
            child: Text(_title, style: Theme.of(context).textTheme.title,),
          ),
          Container(

            padding: const EdgeInsets.fromLTRB(_hPad, 10.0, _hPad, _hPad),
            child: Text(_body, style: Theme.of(context).textTheme.body1,),
          ),

        ]
      );
  }
}