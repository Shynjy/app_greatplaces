import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

// API GOOGLE
// import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:latlong/latlong.dart' as latlong;


// Providers
import '../providers/great_places.dart';

// Widgets
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class PlaceFormScreen extends StatefulWidget {
  @override
  _PlaceFormScreenState createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();

  // Local da imagem
  File _pickedImage;

  // Posição geográfica
  latlong.LatLng _pickedPosition;

  // Adiciona o local a variável
  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  // Adiciona a posição a variável
  void _selectPosition(latlong.LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  // Verifica se todos os campos estão preenchidos
  bool _isValidForm() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  // Adiciona ao sqflite as informações
  void _submitForm() {
    if (!_isValidForm()) return;

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage,
      _pickedPosition,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Lugar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(labelText: 'Título'),
                      onChanged: (_) {
                        setState(() {});
                      },
                    ),
                    SizedBox(height: 10),
                    ImageInput(this._selectImage),
                    SizedBox(height: 10),
                    LocationInput(this._selectPosition),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            label: Text('Adicionar'),
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.add),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: _isValidForm() ? _submitForm : null,
          ),
        ],
      ),
    );
  }
}
