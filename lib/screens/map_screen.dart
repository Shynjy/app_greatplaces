import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// Tipo
import '../models/place.dart';

// Dependência Flutter Map
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart' as latlong;
import '../plugin/zoombuttons_plugins_option.dart';

// Chave MapBox
import '../security/key_apis.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadonly;

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: -23.5489,
      longitude: -46.6388,
    ),
    this.isReadonly = false,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  latlong.LatLng _picketPosition;

  @override
  void initState() {
    super.initState();

    if (widget.isReadonly) {
      setState(() {
        _picketPosition = widget.initialLocation.toLatLng();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Seleciona um local no map
    void _selectPosition(latlong.LatLng position) {
      if (!widget.isReadonly) {
        setState(() {
          _picketPosition = position;
        });
      }
    }

    // Marcador
    var markers = <Marker>[
      Marker(
        width: 100.0,
        height: 100.0,
        point: _picketPosition,
        builder: (ctx) => Transform.translate(
          offset: Offset(0, -20),
          child: Icon(
            Icons.location_on,
            size: 50,
            color: Colors.red,
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: widget.isReadonly ? Text('Local no map') : Text('Selecione um local'),
        actions: <Widget>[
          if (!widget.isReadonly)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _picketPosition == null
                  ? null
                  : () {
                      Navigator.of(context).pop(_picketPosition);
                    },
            ),
        ],
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
              zoom: 12.0,
              plugins: [
                ZoomButtonsPlugin(),
              ],
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
              MarkerLayerOptions(
                  markers: _picketPosition != null ? markers : []),
              ZoomButtonsPluginOption(
                minZoom: 4,
                maxZoom: 19,
                mini: true,
                padding: 10,
                alignment: Alignment.bottomRight,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
