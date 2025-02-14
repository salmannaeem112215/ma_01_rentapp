import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/presentation/bloc/car_bloc.dart';
import 'package:rentapp/presentation/bloc/car_event.dart';
import 'package:rentapp/presentation/pages/maps_details_page.dart';
import 'package:rentapp/presentation/widgets/car_card.dart';
import 'package:rentapp/presentation/widgets/more_card.dart';

class CardDetailsPage extends StatefulWidget {
  final Car car;

  final List<Car> cars;
  const CardDetailsPage({super.key, required this.car, required this.cars});

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _controller!.forward();

    super.initState();
  }

  @override
  void dispose() {
    _controller!.forward();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(Icons.info_outline), Text(' Information')],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Wrap(
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 450),
                  child: CarCard(
                    car: widget.car,
                    cars: widget.cars,
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 450),
                    child: _CarDetails(
                      widget: widget,
                      animation: _animation,
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 0,
            ),
            _OtherCarsHeader(),
            SizedBox(height: 10),
            _OtherCarCards(
              car: widget.car,
              cars: widget.cars,
            ),
          ],
        ),
      ),
    );
  }
}

class _OtherCarCards extends StatelessWidget {
  const _OtherCarCards({
    required this.cars,
    required this.car,
  });

  final List<Car> cars;
  final Car car;
  List<Car> get otherCars {
    return cars.where((c) => c.id != car.id).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        runSpacing: 10,
        spacing: 20,
        children: otherCars
            .map(
              (car) => Container(
                constraints: BoxConstraints(maxWidth: 400),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CardDetailsPage(
                                    car: car,
                                    cars: cars,
                                  )));
                    },
                    child: MoreCard(car: car)),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _OtherCarsHeader extends StatelessWidget {
  const _OtherCarsHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            "Other Cars",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CarDetails extends StatelessWidget {
  const _CarDetails({
    required this.widget,
    required Animation<double>? animation,
  }) : _animation = animation;

  final CardDetailsPage widget;
  final Animation<double>? _animation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10,
                            spreadRadius: 5)
                      ]),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/user.png'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Jane Cooper',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MapsDetailsPage(car: widget.car)));
                  },
                  child: Container(
                    height: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 5)
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Transform.scale(
                        scale: _animation!.value,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/maps.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
                onPressed: () => context
                    .read<CarBloc>()
                    .add(BookCarEvent(widget.car.contactNo)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
      ],
    );
  }
}
