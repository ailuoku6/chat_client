
import 'package:flutter/material.dart';

class OptionItem extends StatelessWidget {

  final String _title;
  final String _value;
  final IconData _icon;

  OptionItem(this._title, this._value, this._icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(_icon,color: Colors.blueAccent,),
              Text(_title)
            ],
          ),
          Text(_value)
        ],
      ),
    );
  }
}
