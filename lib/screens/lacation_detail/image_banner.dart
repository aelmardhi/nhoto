import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterapp2/screens/lacation_detail/image_viewer.dart';
import '../../app.dart';

class ImageBanner extends StatelessWidget {
  final String _assetPath;
  static final _locations_assets = [
    'assets/images/glass.jpg',
    'assets/images/louvre.jpg',
    'assets/images/baloons_house.jpg',
  ] ;
  final String _name;
  ImageBanner(this._assetPath,this._name);

  @override
  Widget build(BuildContext context) {
    if (_locations_assets[0] == _assetPath ||_locations_assets[2] == _assetPath ||_locations_assets[1] == _assetPath  ){
      return Container(
        constraints: BoxConstraints.expand(
          height: 300.0,
        ),
        decoration: BoxDecoration(color: Colors.grey),
        child:  GestureDetector(
          onTap:()=> _showViewer(context,AssetImage(_assetPath)),
          child: Image.asset(
          _assetPath,

          fit: BoxFit.cover,
        ),
      )
      );
    }
      return Container(
        constraints: BoxConstraints.expand(
          height: 300.0,
        ),
        decoration: BoxDecoration(color: Colors.grey),
        child:  GestureDetector(
          onTap: ()=>_showViewer(context,FileImage(File(_assetPath))),
          child: Image.file(
            File(_assetPath),

            fit: BoxFit.cover,
          ),
        )
      );
  }

  _showViewer(BuildContext context,ImageProvider provider){
    Navigator.pushNamed(context, ImageViewerRoute, arguments: {"provider": provider,"name": _name});
  }
}