
import 'package:animation/solar_system/1_solar_system_basic.dart';
import 'package:animation/waves/sine_wave_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: SolarSystemBasic(),
    );
  }
}
