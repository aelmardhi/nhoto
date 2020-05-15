import 'package:flutter/material.dart';
import '../../models/location.dart';
import 'dart:io';


class LocationItem extends StatelessWidget{
  static const double _hPad = 8.0;
  final Location location;
  final bool _selected ;
  static final _locations_assets = [
    'assets/images/glass.jpg',
    'assets/images/louvre.jpg',
    'assets/images/baloons_house.jpg',
  ] ;
  LocationItem(this.location, this._selected);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 4.0),
        padding: const EdgeInsets.fromLTRB(_hPad, 0.0, _hPad, 0.0),
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color:Color.fromARGB(38, 0, 0, 0),blurRadius:0.75,spreadRadius:0.25)],
            color: _selected?
            Color.fromARGB(255, 80, 200, 255):
            Color.fromARGB(250, 242, 243, 245)
        ),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _decideImage(location.imagePath),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Container(
            padding: const EdgeInsets.fromLTRB(_hPad, 6.0, _hPad, 1.0),
            child: Text(location.name, style: Theme.of(context).textTheme.title,),
             //  RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
          ),
            Container(
              padding: const EdgeInsets.fromLTRB(_hPad, 1.0, _hPad, 8.0),
              child: Text(
                location.subtitle.length < 18 ?
                  location.subtitle:
                  location.subtitle.substring(0,18)+'...',
                style: TextStyle(
                  fontSize: 12
                )),
            ),
          ]
        ),
      ],
    )
    );

  }

  _decideImage(String _assetPath){
    if (_locations_assets[0] == _assetPath ||_locations_assets[2] == _assetPath ||_locations_assets[1] == _assetPath  ){
      return Container(
        constraints: BoxConstraints.expand(
          width: 100.0,
          height: 100.0,
        ),
        child:  Image.asset(
          _assetPath,

          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      constraints: BoxConstraints.expand(
      width: 100.0,
      height: 100.0,
    ),
      child:  Image.file(
        File(_assetPath),

        fit: BoxFit.cover,
      ),
    );
  }

}