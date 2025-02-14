import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/presentation/bloc/car_bloc.dart';
import 'package:rentapp/presentation/bloc/car_state.dart';
import 'package:rentapp/presentation/widgets/car_card.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Your Car'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<CarBloc, CarState>(
        builder: (context, state) {
          if (state is CarsLoading) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  mainAxisExtent: 250,
                ),
                itemCount: 20,
                itemBuilder: (context, index) => CarCard(
                      car: null,
                      cars: null,
                    ));
          } else if (state is CarsLoaded) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 600,
                  mainAxisExtent: 250,
                ),
                itemCount: state.cars.length,
                itemBuilder: (context, index) => CarCard(
                      car: state.cars[index],
                      cars: state.cars,
                    ));
          } else if (state is CarsError) {
            return Center(
              child: Text('error : ${state.message}'),
            );
          }
          return Container();
        },
      ),
    );
  }
}
