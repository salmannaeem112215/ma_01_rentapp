import 'package:rentapp/data/datasources/firebase_car_data_source.dart';
import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/domain/repositories/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final FirebaseCarDataSource dataSource;

  CarRepositoryImpl(this.dataSource);

  @override
  Future<List<Car>> fetchCars() {
    return dataSource.getCars();
  }

  @override
  Future<void> addCar(Car car) {
    return dataSource.addCar(car);
  }

  @override
  Future<void> updateCar(String carId, Car car) {
    return dataSource.updateCar(carId, car);
  }

  @override
  Future<void> deleteCar(String carId) {
    return dataSource.deleteCar(carId);
  }
}
