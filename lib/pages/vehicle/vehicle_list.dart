import 'package:flutter/material.dart';
import 'package:satellite/pages/vehicle/vehicle_item.dart';
import '../../design/utils/size_utils.dart';
import '../driver/rover_page.dart';
import "/design/dimensions.dart";

class VehicleList extends StatelessWidget {
  const VehicleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      _list(context),

    ]);
  }

  Widget _list(BuildContext context) {
    List<String> vehicleNames = ['Curiosity', 'Perseverance']; // Массив названий марсоходов

    return ListView.separated(
      itemCount: vehicleNames.length, // Получение количества элементов в массиве
      padding: EdgeInsets.only(
        left: padding16,
        top: padding16,
        right: padding16,
        bottom: getListBottomPadding(context),
      ),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: height8);
      },
      itemBuilder: (BuildContext context, int index) {
        return VehicleItem(
          onTap: () async {
            await _showDriverPage(context, vehicleNames[index]);
          },
          title: vehicleNames[index],
        );
      },
    );
  }



  Future<void> _showDriverPage(BuildContext context, String roverName) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoverPage(roverName: roverName), // Pass the roverName
      ),
    );
  }

}

