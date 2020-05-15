import 'package:flutter/material.dart';
import '../../models/location.dart';
import '../../models/location_fact.dart';
import '../../app.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'image_banner.dart';
import 'package:flutter/cupertino.dart';



class AddLocation extends StatefulWidget {


  @override
  _State createState() => _State();
}

class _State extends State<AddLocation> {
  io.File imageFile;
  bool _alertStatus = false;
  String name = "";
  String imagePath = Location.getTempImage();
  List<List<String>> facts = [
    ['Summary', ''],
    ['more', '']];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Item"),
      ),
      body: ListView(
      padding: EdgeInsets.all(10),
      children:[Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
//            Container(
//              child: _getAlert(),
//            ),
            TextField(
              maxLength: 20,
              decoration:InputDecoration(
                fillColor: Colors.amberAccent,
                labelText: "title",
              ),
              onChanged: (title) => this.name=title,
            ),

            TextField(
              decoration:InputDecoration(
                fillColor: Colors.amberAccent,
                labelText: "subtitle",
              ),
              onChanged: (title) => this.facts[0][1]=title,
            ),
            TextField(
              maxLines: 5,
              decoration:InputDecoration(
                fillColor: Colors.amberAccent,
                labelText: "content",
              ),
              onChanged: (title) => this.facts[1][1]=title,
            ),
            RaisedButton(
              child: Text("Select Image"),
              onPressed: () => _showChoiseDialog(context),
            ),
            _decideImageVeiw(),
            RaisedButton(
              child: Text("ADD",style: TextStyle(color: Colors.white),),
              color: Colors.blue,
              onPressed: () => _submit(context),
            ),
          ],
        ),
        ]
      )
    );
  }
  _submit(BuildContext context){
    //if (name.length >= 3 ) {//&& facts[0][1].length >= 3 && facts[1][1].length >= 3
      // todo : change this temp code and delete its ref in location model
      //imagePath = Location.getTempImage();
      Location.add(name, imagePath,
      facts[0][1], facts[1][1]);
      Navigator.pushNamedAndRemoveUntil(context, LocationsRoute,(Route<dynamic> r)  {
        if (r.settings.name == LocationsRoute || r.settings.name == LocationDetailRoute){return true;}
        return false;
      });
    //} else {
//      setState(() {
//        _alertStatus = !_alertStatus;
//      });
//    }
  }

  Future <void> _showChoiseDialog (BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text("Select a method",style: TextStyle(
          color: Colors.black45,
        ),),
        titlePadding: EdgeInsets.all(10.0),
        contentPadding: EdgeInsets.all(15.0),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Text("Galary"),
                onTap: () => _openGalary(context),
              ),
              Padding(padding: EdgeInsets.all(10.0),),
              GestureDetector(
                child: Text("Camera"),
                onTap: () => _openCamera(context),
              ),
              Padding(padding: EdgeInsets.all(10.0),),
              GestureDetector(
                child: Text("Default"),
                onTap: () => _openDefault(context),
              ),
            ],
          ),
        ),
      );
    });
  }

  _openGalary  (BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory() ;
    String newPath = documentsDirectory.path+'/'+picture.path.substring(picture.path.lastIndexOf('\/')+1);
    imageFile = await picture.copy(newPath);
    this.setState((){
      imagePath = newPath;
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory() ;
    String newPath = documentsDirectory.path+'/'+picture.path.substring(picture.path.lastIndexOf('\/')+1);
    imageFile = await picture.copy(newPath);
    this.setState((){
      imagePath = newPath;
    });
    Navigator.of(context).pop();
  }

  _openDefault(BuildContext context) async {
    imagePath = Location.getTempImageNot(imagePath);
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory() ;
    String newPath = documentsDirectory.path+'/'+imagePath;
    imageFile = io.File(newPath) ;
    this.setState((){

    });
    Navigator.of(context).pop();
  }

  Widget _decideImageVeiw (){
    if (imageFile == null){
      return Text ("click button above to select an image");
    }
    else{
      return ImageBanner(imagePath);
    }
  }

  Widget _getAlert(){
    if (!_alertStatus){
      return Text("Fill all fields with 3 characters or more");
    }
    return Text("Fill all fields with 3 characters or more",style: TextStyle(
      color: Colors.red,
      fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,);
  }

}
