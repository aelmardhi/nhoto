import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp2/screens/locations/locationItem.dart';
import 'package:flutterapp2/screens/locations/location_search.dart';
import '../../app.dart';
import '../../models/location.dart';
import 'locationItem.dart';
import 'main_drawer.dart';

class Locations extends StatefulWidget {
  @override
  _LocationsState createState() => _LocationsState();
}



class _LocationsState extends State<Locations> {
  static const double _hPad = 16.0;
  List<Location> _locations;
  List<Location> _selected = [];
  bool _selecting = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: _getAppBar(),
      drawer: _selecting?null:MainDrawer.getDrawer(),
      floatingActionButton: FloatingActionButton(

        child: Text('+', style: TextStyle(
            fontSize: 40.0,
          fontWeight: FontWeight.w300,
        )),
        onPressed: () => Navigator.pushNamed(context, AddLocationRoute),
      ),
      body: Container(
      child:
      ListView(
        children:  [
        FutureBuilder<List<Location>>(
          future: Location.fetchAll(),
          builder: (context, AsyncSnapshot<List<Location>>snapshot){
            if (snapshot.hasError){
              return Text('Error ${snapshot.error}');
            }
            if(snapshot.hasData){
              _locations = snapshot.data;
              return Column(
                  children : _getListOfLocations(snapshot),
              );
            }
            return Text('Updating...');
          },
        )]
//        await Location.fetchAll().map((location)=>  GestureDetector(
//            child: LocationItem(location),
//            onTap: () => _onLocationTap(context, location.id),
//        )).toList(),
      ),
      )
    );

  }

  _getListOfLocations(AsyncSnapshot<List<Location>>snapshot){
    if (snapshot.data.length >0) {
      return snapshot.data.map((location) =>
          GestureDetector(
            child: LocationItem(location,_contains(location)),
            onTap: () => _onLocationTap(context, location),
            onLongPress: () => _onLongPress(location),
          )
      ).toList();
    } else {
      return [Container(
          padding: EdgeInsets.only(left: 5,top: 40),
          child : Text('Add new note using the (+) button below',style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 15,
          ),
          ))];
    }


  }

  bool _contains(Location location){
    for (Location l in _selected){
      if (l.id == location.id)return true;
    }
    return false;
  }

  _remove(Location location){
    for (int i = 0;i<_selected.length;i++){
      if (_selected[i].id == location.id )
        _selected.removeAt(i);
    }
  }

  _onLocationTap(BuildContext context, Location locationID){
    if(_selecting){
        if (_contains(locationID)){
          _remove(locationID);
          if (_selected.length<1){
            _selecting = false;
          }
        }else{
          _selected.add(locationID);
          _selecting = true;
        }
      setState(() {

      });
    }else {
      Navigator.pushNamed(
          context, LocationDetailRoute, arguments: {"id": locationID});
    }
  }

  _onSearch(){
    showSearch(context: context, delegate: LocationSearch(_locations));
  }
  
  AppBar _getAppBar(){
    if (_selecting){
      return AppBar(
          title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children:[
                    IconButton(icon: Icon(CupertinoIcons.clear_thick), onPressed: () =>_onSelectCancel()),
                    Text(_selected.length.toString()+" Selected",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),) ,
                ]),
                _selected.length<1?null:
                IconButton(
                    icon:Icon(CupertinoIcons.delete_simple),
                    onPressed: () => _showDeleteDialog(context),
                ),
              ])
      );
    }
      return AppBar(
          title:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Nhoto',style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),) ,
                IconButton(icon: Icon(CupertinoIcons.search), onPressed: _onSearch)
              ])
      );
  }
  
  _onSelectCancel (){
    setState(() {
      _selected = [];
      _selecting=false;
    });
  }
  
  _onLongPress(Location l){
    setState(() {
      if (_contains(l)){
        _remove(l);
        if(_selected.length<1){
          _selecting = false;
        }
      }else{
        _selected.add(l);
        _selecting = true;
      }
      
    });
    
  }

  ////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> _showDeleteDialog(BuildContext context){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("do you want to delete "+_selected.length.toString()+" nhotes",
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
              onTap: () => _onConfirm(context),
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

  _onConfirm(BuildContext context){
    for(Location l in _selected){
      Location.delete(l);
    }
    setState(() {
      _selected = [];
    });
    setState(() {
      _selecting = false;
    });
    Navigator.of(context).pop();
  }

  _onCancel(context){
    Navigator.of(context).pop();
  }
}