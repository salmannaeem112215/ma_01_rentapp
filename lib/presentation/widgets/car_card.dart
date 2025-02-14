import 'package:flutter/material.dart';
import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/presentation/pages/car_details_page.dart';
import 'package:rentapp/presentation/widgets/my_shimmer.dart';

class CarCard extends StatelessWidget {
  final Car? car;
  final List<Car>? cars;

  const CarCard({super.key, required this.car, required this.cars});
  bool get isLoading => car == null;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CardDetailsPage(
                            car: car!,
                            cars: cars!,
                          )));
            },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Color(0xffF3F3F3),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5)
            ]),
        child: Column(
          children: [
            !isLoading
                ? Image.asset(
                    'assets/car_image.png',
                    height: 120,
                  )
                : MyShimmer(
                    height: 120,
                  ),
            !isLoading
                ? Text(
                    car!.model,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )
                : SizedBox(),
            SizedBox(
              height: 10,
            ),
            isLoading
                ? MyShimmer(
                    height: 20,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/gps.png'),
                              Text(' ${car!.distance.toStringAsFixed(0)}km')
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset('assets/pump.png'),
                              Text(' ${car!.fuelCapacity.toStringAsFixed(0)}L')
                            ],
                          ),
                        ],
                      ),
                      Text(
                        // 'RS ${car!.pricePerDay.toInt()}/day',
                        'RS 55555/day',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
