import 'package:dvtapp/db/appdatabase.dart';
import 'package:dvtapp/model/Favorites.dart';
import 'package:dvtapp/model/current.dart';
import 'package:dvtapp/model/forecast.dart';
import 'package:dvtapp/services/apiprovider.dart';

class Repository{
  final _apiProvider=  APIProvider();

  // Future<WeatherForecast?> fetchAllForecast() => _apiProvider.getWeatherForecast();
  // Future<WeatherCurrent?> fetchCurrentWeather()=> _apiProvider.getCurrentWeather();

}

class FavoritesRepository{

  void insertFvorites(Favorites favorites) async{
    final db=  await $Floorappdatabase.databaseBuilder('favorites.db').build();
    final favoriteDao= db.favoritessDao;
    await favoriteDao.insertFavorite(favorites);

  }
  Future<List<Favorites>?> getFavorites() async{
    final db = await $Floorappdatabase.databaseBuilder('favorites.db').build();
    final favoritesDao = db.favoritessDao;
    await favoritesDao.getFavorites();
    return favoritesDao.getFavorites();
  }
}