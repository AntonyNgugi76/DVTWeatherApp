import 'package:floor/floor.dart';

@entity
class WeatherForecast {
  String? cod;
  int? message;
  int? cnt;
  List<Data>? data;
  City? city;

  WeatherForecast({this.cod, this.message, this.cnt, this.data, this.city});

  WeatherForecast.fromJson(Map<String, dynamic> json) {
    cod = json['cod'];
    message = json['message'];
    cnt = json['cnt'];
    if (json['list'] != null) {
      data = <Data>[];
      json['list'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cod'] = cod;
    data['message'] = message;
    data['cnt'] = cnt;
    if (this.data != null) {
      data['list'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (city != null) {
      data['city'] = city!.toJson();
    }
    return data;
  }
}

class Data {
  int? dt;
  Main? main;
  List<Weather>? weather;
  String? dtText;


  Data(
      {this.dt,//date
        this.main,
        this.weather,
        this.dtText
        });

  Data.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    dtText = json['dt_txt'];
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = dt;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Main {
  var tempe;
  Main(
      { this.tempe,
        });

  Main.fromJson(Map<String, dynamic> json) {
    tempe = json['temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['temp'] = tempe;
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? icon;

  Weather({this.id, this.main, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['main'] = main;
    data['icon'] = icon;
    return data;
  }
}

  class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City(
  {this.id,
  this.name,
  this.coord,
  this.country,
  this.population,
  this.timezone,
  this.sunrise,
  this.sunset});

  City.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  name = json['name'];
  coord = json['coord'] != null ? new Coord.fromJson(json['coord']) : null;
  country = json['country'];
  population = json['population'];
  timezone = json['timezone'];
  sunrise = json['sunrise'];
  sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = id;
  data['name'] = name;
  if (coord != null) {
  data['coord'] = coord!.toJson();
  }
  data['country'] = country;
  data['population'] = population;
  data['timezone'] = timezone;
  data['sunrise'] = sunrise;
  data['sunset'] = sunset;
  return data;
  }
  }

  class Coord {
  var lat;
  var   lon;

  Coord({this.lat, this.lon});

  Coord.fromJson(Map<String, dynamic> json) {
  lat = json['lat'];
  lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['lat'] = lat;
  data['lon'] = lon;
  return data;
  }
  }


@entity
class WeatherHolder{
  @primaryKey
  int id=1;
  String? data;

  WeatherHolder({ required this.id, this.data});

  WeatherHolder.fromJson(Map<String, dynamic> json){
    id = json['id'];
    data = json['data'];

  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['id']= id;
    json['data']=  data;
    return json;
  }


}