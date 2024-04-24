import 'package:flutter/material.dart';
import 'package:satellite/pages/vehicle/vehicle_list.dart';
import '../../design/images.dart';
import '../../design/styles.dart';
import '../satellite/satellite_page.dart';
import "/design/colors.dart";

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [VehicleList(), SatellitePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Satelite',
          style: primaryTextStyle,
        ),
        centerTitle: true,
        backgroundColor: SurfacevColor,
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: roverImage, label: 'Марсоходы'),
          BottomNavigationBarItem(icon: cosmoImage, label: 'Спутник'),
        ],
        currentIndex: _currentPage,
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}