import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/domain/repositories/car_repository.dart';

class UpdateCar {
  final CarRepository repository;

  UpdateCar(this.repository);

  Future<void> call(String carId, Car car) async {
    return await repository.updateCar(carId, car);
  }
}
