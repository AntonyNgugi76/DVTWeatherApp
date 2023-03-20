import 'dart:convert';

import 'package:dvtapp/model/current.dart';
import 'package:dvtapp/model/forecast.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class APIProvider {
  final String _baseurlCurrent =
      'https://api.openweathermap.org/data/2.5/weather?';
  final String _baseurlForecast =
      'https://api.openweathermap.org/data/2.5/forecast?';
  final String _apikey = '212c11e275307f1fcadf57804af3f9f6';
  final String _latitude = '1';
  final String _longitude = '1';

  // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}- current
  // api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}- 5 day forecast

  Future<WeatherCurrent?> getCurrentWeather(String lat, String long) async {
    var response = await http.get(Uri.parse(
        _baseurlCurrent + 'lat=' + lat + '&lon=' + long + '&appid=' + _apikey));
    debugPrint('Response.....$lat lonng $long>>>>>> $_apikey}');
    var res = jsonDecode(response.body);
    debugPrint('$res entered');
    if (response.statusCode == 200) {
      return WeatherCurrent.fromJson(res);
      // debugPrint('Current${weat.weather}');
    } else {
      throw Exception('Failed to Fetch Weather');
    }
  }

  Future<WeatherForecast?> getWeatherForecast(String lat, String long) async {
    var _response = await http.get(Uri.parse(_baseurlForecast +
        'lat=' +
        lat +
        '&lon=' +
        long +
        '&appid=' +
        _apikey));
    var _res = jsonDecode(_response.body);
    debugPrint('forecast ....$_res');

    if (_response.statusCode == 200) {
      return WeatherForecast.fromJson(_res);

      // String weathers = jsonEncode(weat.data);
      // debugPrint('weathers$weathers');
      // debugPrint('encoded${weat.data}');
    }
  }
}
