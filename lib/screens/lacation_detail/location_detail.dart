

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'image_banner.dart';
import 'text_section.dart';
import '../../models/location.dart';
import 'package:flutter/material.dart';
import '../../app.dart';
import '../locations/locations.dart';
import 'dart:io';


class LocationDetail extends StatelessWidget {
  final Location _locationID;
  static final _locations_assets = [
    'assets/images/glass.jpg',
    'assets/images/louvre.jpg',
    'assets/images/baloons_house.jpg',
  ] ;

  LocationDetail(this._locationID);

  @override
  Widget build(BuildContext context) {
    //final location = Location.fetchById(_locationID);
    final location = _locationID;
    return Container(
        color: Colors.white,
        child:CustomScrollView(
      
      slivers: <Widget>[
        SliverAppBar(
            pinned: true,
            floating: true,
            stretch: true,
            expandedHeight: 300.0,
            stretchTriggerOffset: 400,

            flexibleSpace: FlexibleSpaceBar(
              title: Text(location.name, style: TextStyle(
//              fontSize: location.name.length>10?8:20,
                fontWeight: FontWeight.bold,
              ),),
              background: ImageBanner(location.imagePath,location.name),
            ),

            actions: <Widget>[

              GestureDetector(
                child: Icon(CupertinoIcons.pen),
                behavior: HitTestBehavior.opaque,

                onTap: () => _onUpdateTap(context, location),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              GestureDetector(

                child: Icon(CupertinoIcons.delete_simple),
                behavior: HitTestBehavior.opaque,

                onTap: () => _showDeleteDialog(context, location),
              ),
            ]),
        SliverList(
          delegate: SliverChildListDelegate(
              [
//                ImageBanner(location.imagePath, location.name),
              Container(
              child:Column(
                children: textSections(location),
              )
              )
              ]
//                ..addAll(textSections(location))
          ),
        )
      ],
    ));
  }
  List<Widget> textSections(Location l){
    return [TextSection(l.subtitle,l.text)];
  }

  _onDeleteTap(BuildContext context, Location id){
    Location.delete(id);
    Navigator.pushNamedAndRemoveUntil(context, LocationsRoute,(Route<dynamic> r)  {
      if (r.settings.name == LocationsRoute || r.settings.name == LocationDetailRoute){return true;}
      return false;
    });
  }

  Future<void> _showDeleteDialog(BuildContext context,Location location){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("do you want to delete ' "+location.name+" '",
        textAlign: TextAlign.center,
        ),
        contentPadding: EdgeInsets.all(20.0),
        titlePadding: EdgeInsets.all(20.0),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              child: Text("Confirm",
                style: TextStyle(
                  color: Colors.red
              ),),
              onTap: () => _onConfirm(context,location),
            ),
            GestureDetector(
              child: Text("Cancel",
              style: TextStyle(
                color: Colors.lightBlue,
              ),
              ),
              onTap: () => _onCancel(context),
            ),
          ],
        ),
      );
    });
  }

  _onConfirm(BuildContext context, Location id){
    Location.delete(id);
    Navigator.pushNamedAndRemoveUntil(context, LocationsRoute,(Route<dynamic> r)  {
      if (r.settings.name == LocationsRoute || r.settings.name == LocationDetailRoute){return true;}
      return false;
    });
  }

  _onCancel(context){
    Navigator.of(context).pop();
  }

  _onUpdateTap(BuildContext context, Location locationID){
    Navigator.pushNamed(context, LocationUpdateRoute, arguments: {"id": locationID});
  }

}
