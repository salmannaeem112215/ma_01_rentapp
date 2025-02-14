import 'package:flutter/material.dart';

class Car {
  final String id;
  final String model;
  final String location;
  final String address;
  final String contactNo;
  final double fuelCapacity;
  final double pricePerDay;
  double get distance {
    return 10.0;
  }

  Car({
    this.id = '',
    required this.model,
    required this.contactNo,
    required this.location,
    required this.address,
    required this.fuelCapacity,
    required this.pricePerDay,
  });

  factory Car.fromMap(Map<String, dynamic> map, [String id = '']) {
    debugPrint("TEMP CAR $map");

    return Car(
        id: id,
        model: map['model'],
        contactNo: map['contactNo'],
        location: map['location'],
        address: map['address'],
        fuelCapacity: double.parse(map['fuelCapacity'].toString()),
        pricePerDay: double.parse(map['pricePerDay'].toString()));
  }
}
