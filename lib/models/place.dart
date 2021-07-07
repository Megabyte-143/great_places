import 'dart:io';

import 'package:flutter/material.dart';

class PlaceLocation {
  final double latitude;
  final double longititude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longititude,
    required this.address,
  });
}

class Place {
  final String id;
  final String title;
  final PlaceLocation loc;
  final File image;

  Place({
    required this.id,
    required this.title,
    required this.loc,
    required this.image,
  });
}
