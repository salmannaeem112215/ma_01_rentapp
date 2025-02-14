import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/domain/usecases/add_cars.dart';
import 'package:rentapp/domain/usecases/delete_cars.dart';
import 'package:rentapp/domain/usecases/get_cars.dart';
import 'package:rentapp/domain/usecases/update_cars.dart';
import 'package:rentapp/presentation/bloc/car_event.dart';
import 'package:rentapp/presentation/bloc/car_state.dart';

class CarBloc extends Bloc<CarEvent, CarState> {
  final GetCars getCars;
  final AddCar addCar;
  final UpdateCar updateCar;
  final DeleteCar deleteCar;

  CarBloc({
    required this.getCars,
    required this.addCar,
    required this.updateCar,
    required this.deleteCar,
  }) : super(CarsLoading()) {
    on<LoadCars>((event, emit) async {
      emit(CarsLoading());
      try {
        final cars = await getCars.call();
        emit(CarsLoaded(cars));
      } catch (e) {
        emit(CarsError(e.toString()));
      }
    });

    on<AddCarEvent>((event, emit) async {
      try {
        await addCar(event.car);
        add(LoadCars()); // Refresh list after adding
      } catch (e) {
        emit(CarsError(e.toString()));
      }
    });

    on<UpdateCarEvent>((event, emit) async {
      try {
        await updateCar(event.carId, event.car);
        add(LoadCars()); // Refresh list after updating
      } catch (e) {
        emit(CarsError(e.toString()));
      }
    });

    on<DeleteCarEvent>((event, emit) async {
      try {
        await deleteCar(event.carId);
        add(LoadCars()); // Refresh list after deleting
      } catch (e) {
        emit(CarsError(e.toString()));
      }
    });
  }
}
