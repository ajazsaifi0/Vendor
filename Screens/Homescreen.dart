import 'package:bhs_vendor/Constants.dart';
import 'package:bhs_vendor/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  double longitude = 0;
  double latitude = 0;
  Position? position1;
  String Address = "";
  String Locality = "";
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      GetAddressFromLatLong(position);

      position1 = position;
      // _markers.add(Marker(
      //     markerId: MarkerId(1.toString()),
      //     position: LatLng(position1!.latitude, position1!.longitude)));
      longitude = position.longitude;
      latitude = position.latitude;
    });

    print(position.latitude);
    print(position.longitude);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

    return await Geolocator.getCurrentPosition();
  }
  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    Locality = "${place.locality}";
    Address =
    '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      Constants.State=place.locality!;
      Constants.Address=Address;
    });
    print(Address.trim());
  }
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
       // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on_sharp,color: Colors.red,size: MediaQuery.of(context).size.height*0.2,),

            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Set Your Location",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),)
              
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text("We only access our location while you use the app",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 18),textAlign: TextAlign.center,),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: (){
              _determinePosition();

            },
            child: Container(

              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(10)
              ),
              height: 50,
              width: MediaQuery.of(context).size.width*0.8,
              child: Center(child: Text("Allow",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
            ),
          )
        ],
      ),
    );
  }
}
