import 'package:flutter/material.dart';
import 'package:satellite/pages/vehicle/vehicle_page.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VehiclePage(),
    );
  }
}
