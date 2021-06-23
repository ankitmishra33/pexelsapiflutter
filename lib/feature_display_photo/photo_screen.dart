import 'package:photo_video_app/feature_display_photo/bloc/photo_bloc.dart';
import 'package:photo_video_app/feature_display_photo/bloc/photo_event.dart';
import 'package:photo_video_app/feature_display_photo/repository/photo_repository.dart';
import 'package:photo_video_app/feature_display_photo/widgets/photo_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_video_app/feature_display_photo/bloc/favorite_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as bp;
import 'favrouite_screen.dart';
import 'models/photo_model.dart';

class DisplayPhotoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final FavoriteBloc favoriteBloc = bp.BlocProvider.getBloc<FavoriteBloc>();


    return BlocProvider(
      create: (context) => PhotoBloc(
        photoRepository: PhotoRepository(),
      )..add(PhotoFetchEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Pexels',style: TextStyle(color: Colors.white)),
          elevation: 0.0,
          backgroundColor: Colors.black87,
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: StreamBuilder<Map<String, PhotoModel>>(
                stream: favoriteBloc.outFav,
                initialData: {},
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data.length}");
                  }
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FavoriteScreen()));
              },
            ),

          ],
        ),
        body: PhotoBody(),
      ),
    );
  }
}
