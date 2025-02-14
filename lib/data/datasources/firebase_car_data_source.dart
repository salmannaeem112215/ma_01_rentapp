import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentapp/data/models/car.dart';

class FirebaseCarDataSource {
  final FirebaseFirestore firestore;

  FirebaseCarDataSource({required this.firestore});
  CollectionReference<Map<String, dynamic>> get _collection =>
      firestore.collection('cars');

  Future<List<Car>> getCars() async {
    var snapshot = await _collection.get();
    final cars = snapshot.docs
        .map((doc) => Car.fromMap(
              doc.data(),
              doc.id,
            ))
        .toList();
    cars.sort((a, b) => b.model.compareTo(a.model)); // Sort by name first
    return cars;
  }

  Future<void> addCar(Car car) async {
    await _collection.add({
      'model': car.model,
      'contactNo': car.contactNo,
      'location': car.location,
      'address': car.address,
      'fuelCapacity': car.fuelCapacity,
      'pricePerDay': car.pricePerDay,
    });
  }

  Future<void> updateCar(String carId, Car car) async {
    await _collection.doc(carId).update({
      'model': car.model,
      'contactNo': car.contactNo,
      'location': car.location,
      'address': car.address,
      'fuelCapacity': car.fuelCapacity,
      'pricePerDay': car.pricePerDay,
    });
  }

  Future<void> deleteCar(String carId) async {
    await _collection.doc(carId).delete();
  }
}
