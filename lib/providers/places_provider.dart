import 'package:flutter/material.dart';

import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get item {
    return [..._items];
  }
}
