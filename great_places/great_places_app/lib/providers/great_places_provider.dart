import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places_app/helpers/db_helper.dart';
import 'package:great_places_app/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String title,
    File image,
  ) {
    final newPlace = Place(
        id: DateTime.now().toIso8601String(),
        image: image,
        title: title,
        location:
            PlaceLocation(latitude: 0.0, longitude: 0.0, readableAddress: ''));
    _items.add(newPlace);
    DBHelper.insert(DBHelper.userPlacesDb, {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path
    });
    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    final list = await DBHelper.fetchData(DBHelper.userPlacesDb);
    _items = list
        .map((e) => Place(
            id: e['id'],
            image: File(e['image']),
            title: e['title'],
            location: PlaceLocation(
                latitude: 0.0, longitude: 0.0, readableAddress: '')))
        .toList();
    notifyListeners();
  }
}
