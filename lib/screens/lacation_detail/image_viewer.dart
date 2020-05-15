import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {

  final ImageProvider _provider;
  final String _name;
  ImageViewer(this._provider,this._name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(_name),
          backgroundColor: Color.fromARGB(50, 0, 0, 0),

        ),
        body:Container(

          decoration: BoxDecoration(color: Colors.black,
          ),
      child: PhotoView(
          imageProvider: _provider,

      ),
    )
    );
  }
}
