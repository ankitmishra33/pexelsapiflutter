import 'dart:convert';
import 'package:photo_video_app/feature_display_photo/bloc/photo_event.dart';
import 'package:photo_video_app/feature_display_photo/bloc/photo_state.dart';
import 'package:photo_video_app/feature_display_photo/models/photo_model.dart';
import 'package:photo_video_app/feature_display_photo/repository/photo_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class PhotoBloc extends Bloc<PhotoEvent,PhotoState> {
  final PhotoRepository photoRepository;
  int page = 1;
  bool isFetching = false;

  PhotoBloc({
    @required this.photoRepository,
  }) : super(PhotoInitialState());

  @override
  //map event state block to map all events state

  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    if (event is PhotoFetchEvent) {
      yield PhotoLoadingState(message: 'Loading images');
      final response = await photoRepository.getPhotos(page: page);
      if (response is http.Response) {
        if (response.statusCode == 200) {
          final photos = jsonDecode(response.body)["photos"] as List;
          yield PhotoSuccessState(
            photos: photos.map((photo) => PhotoModel.fromJson(photo)).toList(),
          );
          //print("page is"+page.toString());
          page++;
        } else {
          yield PhotoErrorState(error: response.body);
        }
      } else if (response is String) {
        yield PhotoErrorState(error: response);
      }
    }
  }


}
