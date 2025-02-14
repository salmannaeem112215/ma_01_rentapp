import 'package:flutter/material.dart';
import 'package:rentapp/presentation/pages/car_list_screen.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff2C2B34),
      body: width > 1080 ? desktopView() : mobileView(),
    );
  }

  Widget desktopView() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: _ImageContent(),
        ),
        Expanded(
          child: _TextualContent(),
        )
      ],
    );
  }

  Widget mobileView() {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: _ImageContent(),
        ),
        Expanded(
          child: Padding(
              padding: EdgeInsets.all(20),
              child: FittedBox(child: _TextualContent())),
        )
      ],
    );
  }
}

class _ImageContent extends StatelessWidget {
  const _ImageContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/onboarding.png'), fit: BoxFit.cover)),
    );
  }
}

class _TextualContent extends StatelessWidget {
  const _TextualContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Premium cars. \nEnjoy the luxury',
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Premium and prestige car daily rental. \nExperience the thrill at a lower price',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 320,
          height: 54,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => CarListScreen()),
                    (route) => false);
              },
              style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white),
              child: Text(
                'Let\'s Go',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
        )
      ],
    );
  }
}
