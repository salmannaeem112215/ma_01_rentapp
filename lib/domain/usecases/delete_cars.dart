import 'package:rentapp/domain/repositories/car_repository.dart';

class DeleteCar {
  final CarRepository repository;

  DeleteCar(this.repository);

  Future<void> call(String carId) async {
    return await repository.deleteCar(carId);
  }
}
