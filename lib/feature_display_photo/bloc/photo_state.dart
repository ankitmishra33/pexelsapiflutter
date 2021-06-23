import 'package:photo_video_app/feature_display_photo/models/photo_model.dart';
import 'package:flutter/foundation.dart';

abstract class PhotoState {
  const PhotoState();
}

class PhotoInitialState extends PhotoState {
  const PhotoInitialState();
}

class PhotoLoadingState extends PhotoState {
  final String message;

  const PhotoLoadingState({
    @required this.message,
  });
}

class PhotoSuccessState extends PhotoState {
  final List<PhotoModel> photos;

  const PhotoSuccessState({
    @required this.photos,
  });
}

class PhotoErrorState extends PhotoState {
  final String error;

  const PhotoErrorState({
    @required this.error,
  });
}
