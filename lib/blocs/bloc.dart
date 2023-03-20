import 'package:dvtapp/model/current.dart';
import 'package:dvtapp/model/forecast.dart';
import 'package:dvtapp/repository/repository.dart';
import 'package:rxdart/subjects.dart';



class CurrentWeatherBloc{
  final _repository = Repository();
  final weatherFetcher = PublishSubject<WeatherCurrent>();

  Stream<WeatherCurrent> get currentWeather => weatherFetcher.stream;
  getCurrentWeather() async{
    // WeatherCurrent? _weatherCurrent = await _repository.fetchCurrentWeather();
    // weatherFetcher.sink.add(_weatherCurrent!);
  }
  dispose(){
    weatherFetcher.close();
  }
}

final currentbloc = CurrentWeatherBloc();

class ForeCastBloc{
  final _repository = Repository();
  final _forecastFetcher = PublishSubject<WeatherForecast>();

  Stream<WeatherForecast> get forecastWeather=> _forecastFetcher.stream;

  // getForeCastWeather() async{
  //   WeatherForecast? _weatherForecast = await _repository.fetchAllForecast();
  //   _forecastFetcher.sink.add(_weatherForecast!);
  //
  // }
  dispose(){
    _forecastFetcher.close();

  }
}
final forecastbloc=ForeCastBloc();
