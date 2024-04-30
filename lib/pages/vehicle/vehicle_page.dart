import 'package:flutter/material.dart';
import 'package:satellite/pages/vehicle/vehicle_list.dart';
import '../../design/images.dart';
import '../../design/styles.dart';
import '../favourites/favourites_page.dart';
import '../satellite/satellite_page.dart';
import "/design/colors.dart";

class VehiclePage extends StatefulWidget {
  const VehiclePage({super.key});

  @override
  _VehiclePageState createState() => _VehiclePageState();
}

class _VehiclePageState extends State<VehiclePage> {
  int _currentPage = 0;
  final List<Widget> _pages = [VehicleList(), SatellitePage(),FavouritesPage()];
  final List<String> _appBarTitles = ['Марсоходы', 'Cтатьи','Избранное'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitles[_currentPage], // Set the title based on the current navigation item
          style: primaryTextStyle,
        ),
        centerTitle: true,
        backgroundColor: SurfacevColor,
      ),
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: body2TextStyle,
          selectedLabelStyle: body2TextStyle,
        items: [
          BottomNavigationBarItem(icon: roverImage, label: 'Марсоходы'),
          BottomNavigationBarItem(icon: ArticlesImage, label: 'Cтатьи' ),
          BottomNavigationBarItem(icon: starImage, label: 'Избранное' ),
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