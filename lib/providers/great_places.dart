import 'package:flutter/material.dart';

// Tipos
import '../models/place.dart';

class GreatPlaces extends ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Place itemByIndex(int index) {
    return _items[index];
  }
}