import 'package:photo_video_app/feature_display_photo/photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart' as bp;

import 'feature_display_photo/bloc/favorite_bloc.dart';
void main() {
  Bloc.observer = PhotoBlocObserver();

  runApp(PhotoApp());
}

class PhotoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return bp.BlocProvider(
      blocs: [
       bp.Bloc((i) => FavoriteBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pexels App',
        theme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => DisplayPhotoScreen(),
        },
      ));



  }
}

class PhotoBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}
