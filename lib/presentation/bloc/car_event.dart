import 'package:rentapp/data/models/car.dart';

abstract class CarEvent {}

class LoadCars extends CarEvent {}

class AddCarEvent extends CarEvent {
  final Car car;
  AddCarEvent(this.car);
}

class UpdateCarEvent extends CarEvent {
  final String carId;
  final Car car;
  UpdateCarEvent(this.carId, this.car);
}

class DeleteCarEvent extends CarEvent {
  final String carId;
  DeleteCarEvent(this.carId);
}
