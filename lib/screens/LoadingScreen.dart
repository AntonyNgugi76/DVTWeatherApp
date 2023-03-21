import 'dart:async';

import 'package:dvtapp/model/current.dart';
import 'package:dvtapp/screens/HomePage.dart';
import 'package:dvtapp/services/apiprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "", weatherType = "";
  late StreamSubscription<Position> positionStream;
  final _apiProv = APIProvider();
  var _currentWeather;
  var _currentTemperatures;
  var temp;
  var dt;
  var color;
  var image;
  var city;

  @override
  void initState() {
    checkGps();
    getLocation();
    // setColorImage(_currentWeather);
    super.initState();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();
    debugPrint('longitude $long');
    debugPrint('latitude $lat');

    setState(() {
      //refresh UI
    });
    // setColorImage(_currentWeather);
    // upDateUI();

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      debugPrint(
          'longitude.........${position.longitude}'); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      FutureBuilder<WeatherCurrent?>(
        future: _apiProv.getCurrentWeather(lat, long),
        builder:
            (BuildContext context, AsyncSnapshot<WeatherCurrent?> snapshot) {
          Widget child = SizedBox();
          if (snapshot.hasData) {
            weatherType = snapshot.data!.weather![0].main!;
          }

          return child;
        },
      ),
      Align(
          alignment: Alignment.center,
          child: Container( width: MediaQuery.of(context).size.width*0.5,
    padding: EdgeInsets.all(10),child: FloatingActionButton(
              child: Text('Get Started >'),
              onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    MyHomePage(lat: lat, lon: long, weatherType: weatherType)
            ));
          }))
      )]));
  }
}
