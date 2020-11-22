import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../utils/location_util.dart';
import '../widgets/map_default.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  double _latitude;
  double _longitude;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();

    // Usando Ipa Google
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );

    setState(() {
      _latitude = locData.latitude.toDouble();
      _longitude = locData.longitude.toDouble();

      // Ipa Google
      _previewImageUrl = staticMapImageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text('Localização não informada')
              : MapDefault(
                  latitude: _latitude,
                  longitude: _longitude,
                ),
          // API GOOGLE
          // _previewImageUrl == null
          //     ? Text('Localização não informada')
          //     : Image.network(
          //         _previewImageUrl,
          //         fit: BoxFit.cover,
          //         width: double.infinity,
          //       ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              label: Text('Localização Atual'),
              icon: Icon(Icons.location_on),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
            ),
            FlatButton.icon(
              label: Text('Selecione no Mapa'),
              icon: Icon(Icons.map),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
