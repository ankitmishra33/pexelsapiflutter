import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:photo_video_app/feature_display_photo/models/photo_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBloc extends BlocBase {
  Map<String, PhotoModel> _favorites = {};
List<PhotoModel> favList=[];

  // replaces the above stream controller, remembering that the behavior subject is already broadcast
  // BehaviorSubject sends the last data that passed through it
  final _favController = BehaviorSubject<Map<String, PhotoModel>>();

  Stream<Map<String, PhotoModel>> get outFav => _favController.stream;

  //construtor
  FavoriteBloc() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getKeys().contains("favorites")) {
        _favorites =
            json.decode(prefs.getString("favorites")).map((key, value) {
              return MapEntry(key, PhotoModel.fromJson(value));
            }).cast<String, PhotoModel>();

        _favController.sink.add(_favorites);
      }
    });
  }

  // check if the video is bookmarked and check or uncheck
  void toggleFavorite(PhotoModel photo) {
    if (_favorites.containsKey(photo.id)) {
      _favorites.remove(photo.id);
      favList.removeWhere((item) => item.id == photo.id);

    } else {
      _favorites[photo.id] = photo;
      favList.add(photo);
    }

    _favController.sink.add(_favorites);

    _saveFav();
  }

  void _saveFav() async {
    SharedPreferences.getInstance().then((prefs) {
    // print(json.encode(favList));
     prefs.setString("favorites", json.encode(_favorites));
       prefs.setString('favorlist', jsonEncode(favList));

    });
  }





  @override
  void dispose() {
    _favController.close();
    super.dispose();
  }
}
