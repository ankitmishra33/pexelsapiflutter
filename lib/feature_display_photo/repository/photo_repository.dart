import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../const.dart';
// Repository class to fetch data from API
class PhotoRepository {
  static final PhotoRepository _photoRepository = PhotoRepository._();


  PhotoRepository._();

  factory PhotoRepository() {
    return _photoRepository;
  }

  Future<dynamic> getPhotos({
    @required int page,
  }) async {

// API Call With Authorization Token
    try {
      return await http
          .get(Uri.encodeFull('https://api.pexels.com/v1/curated/?page=$page&per_page=$perPageLimit'), headers: {
        "Accept": "application/json",
        "Authorization": "$apiKey"
      });

    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
