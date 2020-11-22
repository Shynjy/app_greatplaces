import 'package:flutter/material.dart';

// Dependecia Flutter Map
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

// Chave MapBox
import '../security/key_apis.dart';

class MapDefault extends StatefulWidget {
  double latitude;
  double longitude;

  MapDefault({this.latitude, this.longitude});

  @override
  _MapDefaultState createState() => _MapDefaultState();
}

class _MapDefaultState extends State<MapDefault> {
  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(widget.latitude, widget.longitude),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate:
              "https://api.mapbox.com/styles/v1/shynjy/ckhtpq8s13lkd1ao5pa90k63f/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2h5bmp5IiwiYSI6ImNraHRwamFkODEyY2UzMG50NHJ3Nnd4djcifQ.ObVMT7hEEDlZyE23KS_NQQ",
          additionalOptions: {
            'accessToken': KeyApis.MAPBOX,
            'id': 'mapbox.mapbox-streets-v8',
          },
        ),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              // width: 80.0,
              // height: 80.0,
              point: new LatLng(widget.latitude, widget.longitude),
              builder: (ctx) => new Container(
                child: new Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 60.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
