import 'package:dvtapp/model/Favorites.dart';
import 'package:dvtapp/repository/repository.dart';
import 'package:flutter/material.dart';

class FavoritePlaces extends StatefulWidget {
  const FavoritePlaces({Key? key}) : super(key: key);

  @override
  State<FavoritePlaces> createState() => _FavoritePlacesState();
}

class _FavoritePlacesState extends State<FavoritePlaces> {
  final _favoriteRepository= FavoritesRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Favorites>?>(
        future: _favoriteRepository.getFavorites(),
        builder: (BuildContext context, AsyncSnapshot<List<Favorites>?> snapshot) {
          Widget child= SizedBox();
          debugPrint('${snapshot.data}');
          if(snapshot.hasData){
            // child =
          }
          return child;
        },




      ),
    );
  }
}
