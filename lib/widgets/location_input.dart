import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart' as latlong;

// Rotas
import '../utils/location_util.dart';
import '../screens/map_screen.dart';

// Widgets
import '../widgets/map_default.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPosition;

  LocationInput(this.onSelectPosition);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;
  double _latitude;
  double _longitude;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );

    setState(() {
      // Ipa Google
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();

      _showPreview(locData.latitude, locData.longitude);

      setState(() {
        _latitude = locData.latitude;
        _longitude = locData.longitude;
      });

      widget.onSelectPosition(latlong.LatLng(
        locData.latitude,
        locData.longitude,
      ));
    } catch (e) {
      // Colocar um caixa de dialogo, para caso o usuário não tenha permitido o uso da geolocalização.
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final latlong.LatLng selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(),
      ),
    );

    if (selectedPosition == null) return;

    _showPreview(selectedPosition.latitude, selectedPosition.longitude);

    setState(() {
      _latitude = selectedPosition.latitude;
      _longitude = selectedPosition.longitude;
    });

    widget.onSelectPosition(selectedPosition);
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
              onPressed: _selectOnMap,
            ),
          ],
        )
      ],
    );
  }
}
