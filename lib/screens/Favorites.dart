import 'package:dvtapp/model/Favorites.dart';
import 'package:dvtapp/repository/repository.dart';
import 'package:dvtapp/screens/Google_map_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class FavoritePlaces extends StatefulWidget {
  const FavoritePlaces({Key? key}) : super(key: key);

  @override
  State<FavoritePlaces> createState() => _FavoritePlacesState();
}

class _FavoritePlacesState extends State<FavoritePlaces> {
  final _favoriteRepository= FavoritesRepository();
  var lat;
  var long;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favorite Locations'),),
      body: FutureBuilder<List<Favorites>?>(
        future: _favoriteRepository.getFavorites(),
        builder: (BuildContext context, AsyncSnapshot<List<Favorites>?> snapshot) {
          Widget child= SizedBox();
          debugPrint('${snapshot.data}');
          if(snapshot.hasData){

            child= ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index){
                 String latStr = snapshot.data![index].lat!;
                  lat = double.parse(latStr);
                  String longStr= snapshot.data![index].long;
                  long= double.parse(longStr);
                  return InkWell(
                    onTap: (){
                      Get.to(()=>GoogleMapScreen(
                        lat:lat, long: long,
                      ) );
                    },

                    child: Card(
                      elevation: 5,child: Container(
                      height: 40,
                      padding: EdgeInsets.all(10),

                      child: Text(
                        snapshot.data![index].name!
                      ),
                    ),)
                  );


            });


            // child =
          }
          return child;
        },




      ),
    );
  }
}
