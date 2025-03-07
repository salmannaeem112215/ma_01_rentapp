import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/presentation/bloc/car_bloc.dart';
import 'package:rentapp/presentation/bloc/car_event.dart';

extension on String {
  LatLng get latLng {
    try {
      List<String> parts = split(',');
      if (parts.length != 2) throw FormatException("Invalid format");

      double lat = double.parse(parts[0].trim());
      double lng = double.parse(parts[1].trim());

      return LatLng(lat, lng);
    } catch (e) {
      return LatLng(0, 0);
    }
  }
}

class MapsDetailsPage extends StatefulWidget {
  final Car car;

  const MapsDetailsPage({super.key, required this.car});

  @override
  State<MapsDetailsPage> createState() => _MapsDetailsPageState();
}

class _MapsDetailsPageState extends State<MapsDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: widget.car.location.latLng,
              initialZoom: 13,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: widget.car.location
                        .latLng, // Place the marker at the center position
                    child: Icon(
                      Icons.location_on, // Customize your marker here
                      size: 40.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                  constraints: BoxConstraints(maxWidth: 600),
                  child: carDetailsCard(
                    context: context,
                    car: widget.car,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

Widget carDetailsCard({required BuildContext context, required Car car}) {
  return SizedBox(
    height: 350,
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                car.model,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    color: Colors.white,
                    size: 16,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '> ${car.distance} km',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.battery_full,
                    color: Colors.white,
                    size: 14,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    car.fuelCapacity.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Features",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                featureIcons(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'RS ${car.pricePerDay}/day',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                        onPressed: () => context
                            .read<CarBloc>()
                            .add(BookCarEvent(car.contactNo)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        child: Text(
                          'Book Now',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: 50, right: 20, child: Image.asset('assets/white_car.png'))
      ],
    ),
  );
}

Widget featureIcons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      featureIcon(Icons.local_gas_station, 'Diesel', 'Common Rail'),
      featureIcon(Icons.speed, 'Acceleration', '0 - 100km/s'),
      featureIcon(Icons.ac_unit, 'Cold', 'Temp Control'),
    ],
  );
}

Widget featureIcon(IconData icon, String title, String subtitle) {
  return Container(
    width: 100,
    height: 100,
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1)),
    child: Column(
      children: [
        Icon(
          icon,
          size: 28,
        ),
        Text(title),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey, fontSize: 10),
        )
      ],
    ),
  );
}
