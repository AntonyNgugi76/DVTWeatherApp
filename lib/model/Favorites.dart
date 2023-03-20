import 'package:floor/floor.dart';

@entity
class Favorites {
  @PrimaryKey()
  int? id;
  String? lat;
  String? long;
  String? name;

  Favorites({
     this.id, this.lat,  this.long, this.name});

  // Favorites.fromJson(Map<String, dynamic> json){
  //   lat = json['lat'];
  //   long = jso n['long'];
  // }


}
