import 'package:dvtapp/model/Favorites.dart';
import 'package:dvtapp/model/current.dart';
import 'package:dvtapp/model/forecast.dart';
import 'package:floor/floor.dart';
@dao
abstract class CurrentWeatherDao{
  @Query('SELECT*FROM WeatherCurrent')
  Future<List<WeatherCurrent>> getCurrentWeather();

  @insert
  Future<void> insertCurrentWeather(WeatherCurrent weatherCurrent);
}
@dao
abstract class WeatherHolderDao{
  @Query('SELECT * FROM WeatherHolder')
  Future<WeatherHolder?> getWeather();

  @insert
  Future<void> imsertWeather(WeatherHolder weatherHolder);
  }
// abstract class ForecastWeatherDao{
//   @Query('SELECT*FROM WeatherForecast')
//   Future<List<WeatherForecast>> getForecastWeather();
//   @insert
//   Future<void> addForecastWeather(WeatherForecast weatherForecast);
// }
@dao
abstract class FavoritesDao{
  @Query('SELECT *  FROM Favorites')
  Future<List<Favorites>> getFavorites();

  @insert
  Future<void> insertFavorite(Favorites favorites);

}