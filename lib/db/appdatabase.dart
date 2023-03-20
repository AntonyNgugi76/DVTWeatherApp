import 'dart:async';

import 'package:dvtapp/dao/dao.dart';
import 'package:dvtapp/model/Favorites.dart';
import 'package:dvtapp/model/current.dart';
import 'package:dvtapp/model/forecast.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'appdatabase.g.dart';

@Database(version: 1, entities: [WeatherHolder, Favorites])
abstract class appdatabase extends FloorDatabase {
  // CurrentWeatherDao get currentWeatherDao;
  WeatherHolderDao get weatherHolderDao;
  FavoritesDao  get favoritessDao;
  // ForecastWeatherDao get forecastWeatherDao;
  static getDatabaseInstance() async {
    return await $Floorappdatabase.databaseBuilder('favorites.db').build();
  }
}
