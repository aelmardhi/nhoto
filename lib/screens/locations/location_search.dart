import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/screens/locations/locationItem.dart';
import '../../app.dart';
import '../../models/location.dart';
import 'dart:io';

class LocationSearch extends SearchDelegate<Location>{
  final List<Location> _locations;
  static final _locations_assets = [
    'assets/images/glass.jpg',
    'assets/images/louvre.jpg',
    'assets/images/baloons_house.jpg',
  ] ;

  LocationSearch(this._locations);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear),onPressed: (){
        query = "";
      },)
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String q = query.toLowerCase();
    final suggestionList = q.isEmpty?_locations:_locations.where((l){
      return (l.name.toLowerCase().contains(q) ||l.subtitle.toLowerCase().contains(q) ||l.text.toLowerCase().contains(q)  ) ;
    }).toList();

    return Container(
      child:
      ListView(
          children: suggestionList.map((location)=>  GestureDetector(
            child: LocationItem(location,false),
            onTap: () => _onLocationTap(context, location),
        )).toList(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    String q = query.toLowerCase();
    final suggestionList = q.isEmpty?_locations:_locations.where((l){
      return (l.name.toLowerCase().contains(q) ||l.subtitle.toLowerCase().contains(q) ||l.text.toLowerCase().contains(q)  ) ;
    }).toList();

    return ListView.builder(itemBuilder: (context,index) => Card(
      child:ListTile(
      onTap: () => _onLocationTap(context,suggestionList[index]),
      leading:  _decideImage(suggestionList[index].imagePath),
      title: RichText(
        text: TextSpan(
            style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18),
          text: suggestionList[index].name.toLowerCase().contains(q)?
                  suggestionList[index].name.substring(0,suggestionList[index].name.toLowerCase().indexOf(q)):
                  suggestionList[index].name,
          children: [
            TextSpan(
                text: suggestionList[index].name.toLowerCase().contains(q)?
                suggestionList[index].name.substring(suggestionList[index].name.toLowerCase().indexOf(q),suggestionList[index].name.toLowerCase().indexOf(q)+q.length):
                "",
                style: TextStyle(

                  fontWeight: FontWeight.w700,
                    fontSize: 20,
                    backgroundColor: Colors.lightBlueAccent,
                )
            ),
          TextSpan(
            style: TextStyle(
              color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18),
           text: suggestionList[index].name.toLowerCase().contains(q)?
              suggestionList[index].name.substring(suggestionList[index].name.toLowerCase().indexOf(q)+q.length):
              "",
          ),]
        ),
      ),
      subtitle: RichText(
        text: TextSpan(
           style: TextStyle(
                color: Colors.black,),
            text: suggestionList[index].subtitle.toLowerCase().contains(q)?
                suggestionList[index].subtitle.substring(0,suggestionList[index].subtitle.toLowerCase().indexOf(q)):
                suggestionList[index].subtitle,
            children: [
              TextSpan(
                  text:suggestionList[index].subtitle.toLowerCase().contains(q)?
                      suggestionList[index].subtitle.substring(suggestionList[index].subtitle.toLowerCase().indexOf(q),suggestionList[index].subtitle.toLowerCase().indexOf(q)+q.length):
                      "",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    backgroundColor: Colors.lightBlueAccent,
                  )
              ),
              TextSpan(
                style: TextStyle(
                  color: Colors.black,),
                text: suggestionList[index].subtitle.toLowerCase().contains(q)?
                    suggestionList[index].subtitle.substring(suggestionList[index].subtitle.toLowerCase().indexOf(q)+q.length):
                    "",
              ),]
        ),
      ),
        trailing: suggestionList[index].text.toLowerCase().contains(q) && q != ""?
                Icon(Icons.insert_drive_file,color: Colors.lightBlue,):
                null,

    ),
    ),
      itemCount: suggestionList.length,

    );
  }

  _decideImage(String _assetPath){
    if (_locations_assets[0] == _assetPath ||_locations_assets[2] == _assetPath ||_locations_assets[1] == _assetPath  ){
      return Container(
        constraints: BoxConstraints.expand(
          width: 60.0,
          height: 60.0,
        ),
        child:  Image.asset(
          _assetPath,

          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      constraints: BoxConstraints.expand(
        width: 60.0,
        height: 50.0,
      ),
      child:  Image.file(
        File(_assetPath),

        fit: BoxFit.cover,
      ),
    );
  }

  _onLocationTap(BuildContext context, Location locationID){
    Navigator.pushNamed(context, LocationDetailRoute, arguments: {"id": locationID});
  }

}