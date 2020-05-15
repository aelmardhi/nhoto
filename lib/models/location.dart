import 'dart:io' as io;
import 'dart:math';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'location_fact.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true,checked: true)
class Location {
  @JsonKey(name: 'id')
   int id;
  @JsonKey(name: 'name')
   String name ;
  @JsonKey(name: 'imgePath')
   String imagePath;
  @JsonKey(name: 'subTitle')
   String subtitle;
  @JsonKey(name: 'text')
   String text;
  static  List<Location> _locations = [
    Location(1, 'Glass','assets/images/glass.jpg',
       'a girl standing infront of a glass window'
      , 'this image was captured be nolan kearn in his tra'
          'vel to finland . in that trip he shot ver thound photo'
    ),
    Location(2, 'Louvre','assets/images/louvre.jpg',
       'a Photo of the Louvre musium',
       'this is an image of louvre musium in paris at might'
          'the photo shows the glass pyrmid infront of the classic buildings.',
    ),
    Location(3, 'Baloons House','assets/images/baloons_house.jpg',
       'a photo of the house from up',
          'the old man wanted to travel to south america and wanted to take his house hith him.'
          'so he tied a bloons an flied it'
    ),
  ];

  // constructor
  Location(this.id, this.name, this.imagePath, this.subtitle, this.text);

  // json serializers
  factory Location.fromJson(Map<String,dynamic> json) => _$LocationFromJson(json);
  Map<String,dynamic> toJson() => _$LocationToJson(this);

  //getters



  //////////////////////////////////////////////////////////////////////////
  // database
  static Database _db  ;
  static const String TABLE = 'locations';
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String IMAGE_PATH = 'imagePath';
  static const String SUBTITLE = 'subtitle';
  static const String TEXT = 'text';
  static const String DB_NAME = 'locations.db';


  static Future<Database> get db async{
    if (null != _db) {
      return _db;
    }
    _db = await initDb ();
    return _db;
  }

  static initDb() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory() ;
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1,onCreate: _onCreate);
    return db;
  }

  static _onCreate(Database db, int version) async{
    await db.execute("CREATE TABLE $TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT,$IMAGE_PATH TEXT, $NAME TEXT, $SUBTITLE TEXT ,$TEXT TEXT)");
  }


 ////////////////////////////////////////////////////////////////



  static Future<List<Location>> fetchAll() async{
  var dbClient = await db;
  List<Map> maps = await dbClient.query(TABLE,columns: [ID,IMAGE_PATH,NAME,SUBTITLE,TEXT]);
  List<Location> locations = [];
  if(maps.length > 0){
    for (int i = 0; i < maps.length; i++){
      locations.add(Location(maps[i][ID], maps[i][NAME], maps[i][IMAGE_PATH], maps[i][SUBTITLE], maps[i][TEXT]));
    }
  }
  return locations;
  }

  static Future<Location> fetchById(int locationId) async{
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE,columns: [ID,IMAGE_PATH,NAME,SUBTITLE,TEXT],
        where: '$ID = ?',whereArgs: [locationId]);
    if(maps.length > 0){
        return Location(maps[0][ID], maps[0][NAME], maps[0][IMAGE_PATH], maps[0][SUBTITLE], maps[0][TEXT]);
    }
    return null;
  }

  static add(String name, String imagePath, String subtitle ,String text) async {
      var dbClient = await db;
      int id = await dbClient.insert(TABLE, {NAME : name,IMAGE_PATH : imagePath,SUBTITLE : subtitle,TEXT : text});
      if (name == "" ||name == " " ||name == "  " )
        await update(Location(id,name,imagePath,subtitle,text));
  }



  static delete(Location location) async{
    var dbClient = await db;
    await dbClient.delete(TABLE,where: '$ID = ?',whereArgs: [location.id]);
      if (!(
      _locations[0].imagePath == location.imagePath ||
      _locations[1].imagePath == location.imagePath ||
      _locations[2].imagePath == location.imagePath )){

        await io.File(location.imagePath).delete();
    }
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString()+'\n'+id.toString()+','+name+','+subtitle+','+text;
  }

  static update(Location location) async{
    if (location.name == "" ||location.name == " " ||location.name == "  " )
      location.name = "Nhote " + location.id.toString();
    var dbClient = await db;
    await dbClient.update(TABLE,
      {NAME : location.name,IMAGE_PATH : location.imagePath,SUBTITLE : location.subtitle,TEXT : location.text},
      where: '$ID = ?', whereArgs: [location.id]);
  }
///////////////////////////////temp////////////////////////////////////////
  static String getTempImage(){
    int r = Random().nextInt(_locations.length);
    return _locations[r].imagePath;
  }

  static String getTempImageNot(String notPath){
    int r = Random().nextInt(_locations.length);
    String path =_locations[r].imagePath;
    while(path == notPath){
      r = Random().nextInt(_locations.length);
      path =_locations[r].imagePath;
    }
    return path;
  }
}