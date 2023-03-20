import 'dart:async';

import 'package:dvtapp/blocs/bloc.dart';
import 'package:dvtapp/model/Favorites.dart';
import 'package:dvtapp/model/current.dart';
import 'package:dvtapp/repository/repository.dart';
import 'package:dvtapp/screens/Favorites.dart';
import 'package:dvtapp/services/apiprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../model/forecast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _favoritesRepository = FavoritesRepository();
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
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
    debugPrint('longitude $lat');

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
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  // upDateUI() async{
  //   await
  //   _apiProv.getCurrentWeather(lat, long);
  //
  //   // setColorImage(_currentWeather);
  // }

  setColorImage(String _currentWeather) {
    if (_currentWeather == 'Rain') {
      setState(() {
        image = 'assets/images/sea_rainy.png';
        color = 0xff57575D;
      });
    } else if (_currentWeather == 'Clouds') {
      setState(() {
        image = 'assets/images/sea_cloudy.png';
        color = 0xff54717A;
      });
    } else {
      setState(() {
        image = 'assets/images/sea_sunny.png';
        color = 0xff47AB2F;
      });
    }
  }

  formatDay(int day) {
    if (day == 1) {
      return 'Monday';
    } else if (day == 2) {
      return 'Tuesday';
    } else if (day == 3) {
      return 'Wedsnesday';
    } else if (day == 4) {
      return 'Thursday';
    } else if (day == 5) {
      return 'Friday';
    } else if (day == 6) {
      return 'Saturday';
    } else {
      return 'Sunday';
    }
  }

  @override
  Widget build(BuildContext context) {
    _apiProv.getCurrentWeather(lat, long);
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(10),
                  height: 100,
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(CupertinoIcons.person_alt_circle, size: 50),
                  )),
              const Divider(
                height: 1,
                color: Colors.black54,
              ),
              ListTile(
                leading: const Icon(CupertinoIcons.location),
                title: const Text('Current Location'),
                subtitle: Text('$city'),
              ),
              InkWell(
                  onTap: () {
                    Get.to(() => const FavoritePlaces());
                  },
                  child: const ListTile(
                    leading: Icon(CupertinoIcons.square_favorites_alt),
                    title: Text('Favorite Locations'),
                  ))
            ],
          ),
        ),
        body: FutureBuilder<WeatherCurrent?>(
          future: _apiProv.getCurrentWeather(lat, long),
          builder:
              (BuildContext context, AsyncSnapshot<WeatherCurrent?> snapshot) {
            Widget child = const SpinKitSpinningLines(color: Colors.white);

            if (snapshot.hasData) {
              debugPrint('curent........$snapshot');
              var min_temp = snapshot.data?.main?.tempMin;
              var max_temp = snapshot.data?.main?.tempMax;
              _currentTemperatures = snapshot.data?.main?.temp;

              city = snapshot.data?.city;
              debugPrint('city'
                  '........$city');

              _currentWeather = snapshot.data?.weather?[0].main;

              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            // image
                            'assets/images/sea_rainy.png',
                          ),
                        )),
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell( onTap:(){ Scaffold.of(context).openDrawer();},child: const Icon(
                                    CupertinoIcons.bars,
                                    size: 30,
                                    color: Colors.white,
                                  ),),
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    padding: const EdgeInsets.all(10),
                                    child: InkWell(
                                      onTap: () {

                                        _favoritesRepository.insertFvorites(
                                            Favorites(
                                                lat: lat,
                                                long: long,
                                                name: city)


                                        );
                                        Get.snackbar('$city',"Added to Favorites");
                                      },
                                      child: const Icon(
                                        CupertinoIcons.heart,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ))
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 35),
                                child: Text(
                                  '${(_currentTemperatures! - 273).toStringAsFixed(2)}\u00B0',
                                  style: const TextStyle(
                                      fontSize: 55,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                )),
                            Container(
                                // margin: EdgeInsets.only(top: 10),
                                child: Text(
                              '${(_currentWeather)}',
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            )),
                            Container(
                                // margin: EdgeInsets.only(top: 10),
                                child: const Text(
                              '11.000 AM',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ))
                          ],
                        ))

                    // color: Colors.amber,
                    ,
                    Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        color: const Color(
                            // color
                            0xff57575D),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${(min_temp! - 273).toStringAsFixed(2)}\u00B0',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Text(
                                          'min',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '${(_currentTemperatures! - 273).toStringAsFixed(2)}'
                                          '\u00B0',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Text(
                                          'Current',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          '${(max_temp! - 273).toStringAsFixed(2)}\u00B0',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const Text(
                                          'max',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                                height: 1,
                              ),
                              Container(
                                  child: FutureBuilder<WeatherForecast?>(
                                      future: _apiProv.getWeatherForecast(
                                          lat, long),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<WeatherForecast?>
                                              snapshot) {
                                        Widget child = const SizedBox();
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child: SpinKitSpinningLines(
                                                  color: Colors.white));
                                        } else if (snapshot.connectionState ==
                                                ConnectionState.done ||
                                            snapshot.connectionState ==
                                                ConnectionState.active) {
                                          if (snapshot.hasError) {
                                            debugPrint(
                                                'Errooorrr ${snapshot.error.toString()}');
                                          } else if (snapshot.hasData) {
                                            debugPrint(
                                                'snapshotdata${snapshot.data}');
                                            var weat = snapshot.data?.data;

                                            child = ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: weat?.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  temp =
                                                      weat?[index].main?.tempe;
                                                  temp = temp - 273;

                                                  dt = weat?[index].dtText;
                                                  debugPrint(
                                                      'temperatures $dt');
                                                  var converted =
                                                      DateTime.parse(dt);
                                                  // var date= DateFormat('EEEE').format(converted);
                                                  // DateTime date= dt;
                                                  var day = converted.weekday;

                                                  // var date = new DateTime.fromMicrosecondsSinceEpoch(dt);
                                                  // DateFormat('EEEE').format(date); /// e.g Thursday
                                                  debugPrint(
                                                      'weekday..... $day');

                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10,
                                                            left: 16,
                                                            right: 16,
                                                            top: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          '${formatDay(day)}',
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        const Icon(
                                                          CupertinoIcons
                                                              .cloud_heavyrain,
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          '${temp.toStringAsFixed((2))}\u00B0',
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          }
                                        }
                                        return child;
                                      }))
                            ],
                          ),
                        ))
                  ],
                ),
              );
            }
            return child;
          },
        ));
  }
}
