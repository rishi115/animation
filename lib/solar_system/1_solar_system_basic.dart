import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SolarSystemBasic extends StatefulWidget {
  const SolarSystemBasic({Key? key}) : super(key: key);

  @override
  State<SolarSystemBasic> createState() => _SolarSystemBasicState();
}

class _SolarSystemBasicState extends State<SolarSystemBasic>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _animationController2;
  late Animation _animation;

  void startTicker(TickerCallback onTick) {
    Ticker ticker = Ticker(onTick);
    ticker.start();
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 10), upperBound: 2 * pi);
    _animationController.addListener(() {
      setState(() {});
    });
    startTicker((elapsed) {
      // print('elapsed: $elapsed');
    });
    _animationController2 = AnimationController(
        vsync: this, duration: const Duration(seconds: 10));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController2);

    _animationController2.forward();
    _animationController2.repeat();
    _animationController.forward();
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://media.istockphoto.com/id/498478219/photo/stars-at-night-sky.jpg?s=612x612&w=0&k=20&c=M_XD9zraaC1-1Wbvxk5XMU_Qwc5Lwsi7YbSmYbCoXi4='),
            fit: BoxFit.cover, // Adjust the BoxFit as needed
          ),
        ),
        child: Stack(
          children: [
            CustomPaint(
            painter: SolarSystemBasicPainter(_animationController),
            child: Container(),
          ),
            Center(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  return Transform(
                    transform: Matrix4.identity()..rotateZ(_animation.value ),
                    alignment: FractionalOffset.center,
                    child: Container(
                      height: 60,
                      width: 60,
                        child: Center(
                        child: Image.network('https://clipart-library.com/new_gallery/21-214135_sun-png-image-transparent-sun-vector-png.png')
                      )
                    ),
                  ); },

              ),
            ),]
        ),
      ),
    );
  }
}

class SolarSystemBasicPainter extends CustomPainter {
  final Animation<double> animation;

  SolarSystemBasicPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {

    final orbitPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5)
      ..style = PaintingStyle.stroke;
    final earthPaint = Paint()..color = Colors.blue.withOpacity(0.9);

    const earthRadius = 20.0;
    const earthOrbitRadius = 200.0;
    const moonOrbitRadius = 40.0;
    const moonRadius = 10.0;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), earthOrbitRadius, orbitPaint);



    canvas.drawCircle(
        Offset(size.width / 2 + earthOrbitRadius * cos(animation.value),
            size.height / 2 + earthOrbitRadius * sin(animation.value)),
        earthRadius,
        earthPaint);

    final moonX = size.width / 2 +
        earthOrbitRadius * cos(animation.value) +
        moonOrbitRadius * cos(animation.value * 6);
    final moonY = size.height / 2 +
        earthOrbitRadius * sin(animation.value) +
        moonOrbitRadius * sin(animation.value * 6);

    canvas.drawCircle(
        Offset(size.width / 2 + earthOrbitRadius * cos(animation.value),
            size.height / 2 + earthOrbitRadius * sin(animation.value)),
        moonOrbitRadius,
        orbitPaint);
    final moonPaint = Paint()..color = Colors.grey.shade200;
    canvas.drawCircle(Offset(moonX, moonY), moonRadius, moonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

