import 'package:flutter/cupertino.dart';
import 'package:flutterapp2/screens/lacation_detail/image_viewer.dart';
import 'style.dart';
import 'package:flutter/material.dart';
import 'screens/locations/locations.dart';
import 'screens/lacation_detail/location_detail.dart';
import 'screens/add_location/addLocation.dart';
import 'screens/update_location/updateLocation.dart';
import 'screens/lacation_detail/image_viewer.dart';
import 'package:flutter/rendering.dart';

const LocationsRoute = '/';
const LocationDetailRoute = '/location_detail';
const LocationUpdateRoute = '/location_update';
const AddLocationRoute = '/add';
const ImageViewerRoute = '/image_viewer';


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

//    debugPaintSizeEnabled = true ;
    return MaterialApp(
      onGenerateRoute: _routes(),
      theme: _theme(),
    );
  }

  RouteFactory _routes (){
    return (settings){
      final Map <String, dynamic> arguments = settings.arguments;
      Widget screen ;
      switch(settings.name){
        case LocationsRoute:
          screen= Locations();
          break;
        case LocationDetailRoute:
          screen= LocationDetail(arguments['id']);
          break;
        case LocationUpdateRoute:
          screen= UpdateLocation(arguments['id']);
          break;
        case ImageViewerRoute:
          screen= ImageViewer(arguments['provider'],arguments['name']);
          break;
        case AddLocationRoute:
          screen= AddLocation();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }

  ThemeData _theme(){
    return ThemeData(
      appBarTheme: AppBarTheme(
          textTheme: TextTheme(title: AppBarTextStyle,)
      ),
      textTheme: TextTheme(
        title: TitleTextStyle ,
        body1: Body1TextStyle,
      ),
    );
  }
}