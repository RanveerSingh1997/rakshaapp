import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:raksha/widgets/form_input/location.dart';
import 'locations.dart' as locations;

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool _isSwitched =false;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Goolge Map'),
        backgroundColor: Colors.green[700],
        actions: <Widget>[
          IconButton(icon:Icon(Icons.add), onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>LocationInput()));
          }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment:Alignment.topRight,
            child: Switch(
                activeColor:Colors.red,
                inactiveThumbColor:Colors.redAccent,
                value:_isSwitched,
                onChanged:(value){
                  setState(() {
                    _isSwitched=value;
                  });
                }
            ),
          ),
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: const LatLng(0, 0),

              ),
              trafficEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              scrollGesturesEnabled: true,
              rotateGesturesEnabled: true,
              buildingsEnabled: true,
              compassEnabled: true,
              indoorViewEnabled: true,
              mapToolbarEnabled: true,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              markers: _markers.values.toSet(),
            ),
          ),
        ],
      ),
    );
  }
}
