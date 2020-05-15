import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer {

  static Drawer getDrawer() {
//    return super.build(context);
  return Drawer(

      child: ListView(children:[
      Container(
        padding: EdgeInsets.only(left: 20,top: 18,right: 20,bottom: 60),
      child:Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text("Nhoto 1.0.1",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),),
          Container(
            height: 2,
            color: Colors.black12,
          ),
          Padding(
            padding: EdgeInsets.all(12),
          ),
          Container(padding:EdgeInsets.only(top: 4),child:Text("֍ Notes with photo ")),
          Container(padding:EdgeInsets.only(top: 4),child:Text("֍ Tap '+' button to add new nhote ")),
          Container(padding:EdgeInsets.only(top: 4),child:Text("֍ Search ")),
          Container(padding:EdgeInsets.only(top: 4),child:Text("֍ Multi-selection ")),
          Container(padding:EdgeInsets.only(top: 4),child:Text("֍ Add photo from Galary or Camera ")),
          Container(padding:EdgeInsets.only(top: 4),child:Text("֍ Edit and delete nhotes ")),
          Container(padding:EdgeInsets.only(top: 4),child:Text("֍ Image viewer ")),
          Padding(
            padding: EdgeInsets.all(11.0),
          ),
        ],
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
      Text("aelmadhi © 2020",style: TextStyle(color: Colors.black45,),)
      ]),
    ],
  )
  )])
  );
  }
}