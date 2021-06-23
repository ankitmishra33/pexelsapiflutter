import 'package:photo_video_app/feature_display_photo/bloc/photo_bloc.dart';
import 'package:photo_video_app/feature_display_photo/bloc/photo_event.dart';
import 'package:photo_video_app/feature_display_photo/bloc/photo_state.dart';
import 'package:photo_video_app/feature_display_photo/models/photo_model.dart';
import 'package:photo_video_app/feature_display_photo/widgets/photo_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBody extends StatefulWidget {
  @override
  _PhotoBodyState createState() => _PhotoBodyState();
}

class _PhotoBodyState extends State<PhotoBody> {
  final List<PhotoModel> _photos = [];
  // Scroll Controller to load more data from api when its reach to end
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<PhotoBloc, PhotoState>(
        listener: (context, photoState) {
          if (photoState is PhotoLoadingState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(photoState.message)));
          } else if (photoState is PhotoSuccessState && photoState.photos.isEmpty) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('No more photo')));
          } else if (photoState is PhotoErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(photoState.error)));
            BlocProvider.of<PhotoBloc>(context).isFetching = false;
          }
          return;
        },
        builder: (context, photoState) {
          if (photoState is PhotoInitialState ||
              photoState is PhotoLoadingState && _photos.isEmpty) {
            return CircularProgressIndicator();
          } else if (photoState is PhotoSuccessState) {
            _photos.addAll(photoState.photos);
            BlocProvider.of<PhotoBloc>(context).isFetching = false;
            Scaffold.of(context).hideCurrentSnackBar();
          } else if (photoState is PhotoErrorState && _photos.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<PhotoBloc>(context)
                      ..isFetching = true
                      ..add(PhotoFetchEvent());
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(photoState.error, textAlign: TextAlign.center),
              ],
            );
          }
          return ListView.separated(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !BlocProvider.of<PhotoBloc>(context).isFetching) {
                  BlocProvider.of<PhotoBloc>(context)
                    ..isFetching = true
                    ..add(PhotoFetchEvent());
                }
              }),
            itemBuilder: (context, index) => PhotoListItem(_photos[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemCount: _photos.length,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
