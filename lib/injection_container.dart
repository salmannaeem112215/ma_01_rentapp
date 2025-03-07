import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:rentapp/data/datasources/firebase_car_data_source.dart';
import 'package:rentapp/data/repositories/car_repository_impl.dart';
import 'package:rentapp/domain/repositories/car_repository.dart';
import 'package:rentapp/domain/usecases/add_cars.dart';
import 'package:rentapp/domain/usecases/book_car.dart';
import 'package:rentapp/domain/usecases/delete_cars.dart';
import 'package:rentapp/domain/usecases/get_cars.dart';
import 'package:rentapp/domain/usecases/update_cars.dart';
import 'package:rentapp/presentation/bloc/car_bloc.dart';

GetIt getIt = GetIt.instance;

void initInjection() {
  try {
    getIt.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
    getIt.registerLazySingleton<FirebaseCarDataSource>(
        () => FirebaseCarDataSource(firestore: getIt<FirebaseFirestore>()));
    getIt.registerLazySingleton<CarRepository>(
        () => CarRepositoryImpl(getIt<FirebaseCarDataSource>()));
    getIt.registerLazySingleton<GetCars>(() => GetCars(getIt<CarRepository>()));
    getIt.registerLazySingleton<AddCar>(() => AddCar(getIt<CarRepository>()));
    getIt.registerLazySingleton<UpdateCar>(
        () => UpdateCar(getIt<CarRepository>()));
    getIt.registerLazySingleton<DeleteCar>(
        () => DeleteCar(getIt<CarRepository>()));
    getIt.registerLazySingleton<BookCar>(() => BookCar());
    getIt.registerFactory(
      () => CarBloc(
        bookCar: getIt<BookCar>(),
        getCars: getIt<GetCars>(),
        addCar: getIt<AddCar>(),
        updateCar: getIt<UpdateCar>(),
        deleteCar: getIt<DeleteCar>(),
      ),
    );
  } catch (e) {
    rethrow;
  }
}
