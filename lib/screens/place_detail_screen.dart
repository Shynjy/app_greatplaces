import 'dart:ui';

import 'package:app_greatplaces/screens/map_screen.dart';
import 'package:flutter/material.dart';

// Tipos
import '../models/place.dart';

class PlaceDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Recebendo argumento
    Place place = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Hero(
              tag: place.id,
              child: Image.file(
                place.image,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              place.location.address,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          ),
          FlatButton.icon(
            label: Text('Ver no Mapa'),
            icon: Icon(Icons.map),
            textColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                  isReadonly: true,
                  initialLocation: place.location,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}
