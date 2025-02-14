import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/domain/repositories/car_repository.dart';

class AddCar {
  final CarRepository repository;

  AddCar(this.repository);

  Future<void> call(Car car) async {
    return await repository.addCar(car);
  }
}
