import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class StaticMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  StaticMap(this.latitude, this.longitude);
  @override
  _StaticMapState createState() => _StaticMapState();
}

class _StaticMapState extends State<StaticMap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(
            backgroundColor: Colors.black,
             title: Text("User's Location",
              style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.056,
              ),
          ),
        ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(widget.latitude, widget.longitude),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(widget.latitude, widget.longitude),
                builder: (ctx) => Container(
                  child: IconButton(
                    icon:Icon(Icons.location_on),
                    color:Colors.red,
                    iconSize: MediaQuery.of(context).size.width * 0.13,
                    onPressed: (){},
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
