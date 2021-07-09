import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';

import '../helpers/db_helper.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
  ) {
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      loc: PlaceLocation(address: '', longititude: 0.0, latitude: 0.0),
      image: pickedImage,
      title: pickedTitle,
    );

    _items.add(newPlace);
    notifyListeners();

    DBhelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'location': newPlace.loc.toString(),
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dbList = await DBhelper.getData('user_places');
    _items = dbList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              image: File(item['image']),
              loc: PlaceLocation(address: '', latitude: 0.0, longititude: 0.0),
            ))
        .toList();
    notifyListeners();  
  }
}
