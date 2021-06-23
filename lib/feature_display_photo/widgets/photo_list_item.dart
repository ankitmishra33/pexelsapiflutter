import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_video_app/feature_display_photo/bloc/favorite_bloc.dart';
import 'package:photo_video_app/feature_display_photo/models/photo_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_video_app/feature_display_photo/bloc/photo_state.dart';
import 'package:photo_video_app/feature_display_photo/models/photo_model.dart';
import 'package:photo_video_app/feature_display_photo/bloc/favorite_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as bp;
class PhotoListItem extends StatelessWidget {
  final PhotoModel photo;

  const PhotoListItem(this.photo);

  @override
  Widget build(BuildContext context) {
    final FavoriteBloc favoriteBloc = bp.BlocProvider.getBloc<FavoriteBloc>();
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16.0 / 8.0,
              child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Hero(
                  tag:  photo.src.landscape,
                  child: FadeInImage.assetNetwork(
                    image: photo.src.landscape,
                    fit: BoxFit.cover,
                    placeholder: "assets/images/loading.gif",
                    imageScale: 1,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
            Padding(
            padding: EdgeInsets.fromLTRB(8, 0, 8,0),
        child: Text(
          photo.photographer,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
                  StreamBuilder<Map<String, PhotoModel>>(
                      stream: favoriteBloc.outFav,
                      initialData: {},
                      builder: (context, snapshot) {
                        if (snapshot.hasData)
                          return IconButton(
                            icon: Icon(
                              snapshot.data.containsKey(photo.id)
                                  ? Icons.star
                                  : Icons.star_border,
                            ),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {
                              favoriteBloc.toggleFavorite(photo);
                            },
                          );
                        else
                          return CircularProgressIndicator();
                      })

                ]
            ),


                    ],
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );




  }
}
