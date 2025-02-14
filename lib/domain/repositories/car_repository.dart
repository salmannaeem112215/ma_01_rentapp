import 'package:rentapp/data/models/car.dart';

abstract class CarRepository {
  Future<List<Car>> fetchCars();
  Future<void> addCar(Car car);
  Future<void> updateCar(String carId, Car car);
  Future<void> deleteCar(String carId);
}
