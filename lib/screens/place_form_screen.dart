import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _submitForm() {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return null;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage);

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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: 'Título'),
                  ),
                  SizedBox(height: 10),
                  ImageInput(this._selectImage),
                  SizedBox(height: 10),
                  LocationInput(),
                ],
              ),
            ),
          ),
          Spacer(),
          RaisedButton.icon(
            label: Text('Adicionar'),
            color: Theme.of(context).accentColor,
            icon: Icon(Icons.add),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
