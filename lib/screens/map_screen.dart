import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// Tipo
import '../models/place.dart';

// Dependência Flutter Map
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart' as latlong;

// Chave MapBox
import '../security/key_apis.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadonly;

  //Erro na const
  // const MapScreen({
  //   this.initialLocation = const PlaceLocation(
  //     latitude: -23.5489,
  //     longitude: -46.6388,
  //   ),
  // });

  const MapScreen({this.initialLocation, this.isReadonly = false});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  latlong.LatLng _picketPosition;

  @override
  Widget build(BuildContext context) {

    // Seleciona um local no map
    void _selectPosition(latlong.LatLng position) {
      setState(() {
        _picketPosition = position;
      });
    }

    // Marcador
     var markers = <Marker>[
        Marker(
          width: 80.0,
          height: 80.0,
          point: _picketPosition,
          builder: (ctx) => Container(
            child: FlutterLogo(),
          ),
        ),
      ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Selecione um local'),
      ),
      // IPA GOOGLE
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(
      //       widget.initialLocation.latitude,
      //       widget.initialLocation.longitude,
      //     ),
      //     zoom: 13,
      //   ),
      //  onTap: widget.isReadonly ? null : _selectPosition,
      // markers: _picketPosition == null
      //   ? null
      //   : {
      //     Marker(markerId: MarkeId('p1'),
      //     position: _picketPosition,
      //     ),
      //   },
      // ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: latlong.LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude),
              zoom: 10.0,
              onTap: _selectPosition,
              // onTap: _handleTap,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/shynjy/ckhtpq8s13lkd1ao5pa90k63f/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2h5bmp5IiwiYSI6ImNraHRwamFkODEyY2UzMG50NHJ3Nnd4djcifQ.ObVMT7hEEDlZyE23KS_NQQ",
                additionalOptions: {
                  'accessToken': KeyApis.MAPBOX,
                  'id': 'mapbox.mapbox-streets-v8',
                },
              ),
              MarkerLayerOptions(markers: _picketPosition != null ? markers : [])
            ],
          ),
        ],
      ),
    );
  }
}
