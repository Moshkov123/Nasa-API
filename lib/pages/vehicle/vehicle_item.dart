import 'package:flutter/material.dart';
import 'package:satellite/design/colors.dart';
import 'package:satellite/design/dimensions.dart';
import 'package:satellite/design/images.dart';
import 'package:satellite/design/styles.dart';

import '../rover/rover_page.dart';

class VehicleItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final int index;
  final List<String> vehicleNames;

  const VehicleItem({
    Key? key,
    required this.onTap,
    required this.title,
    required this.index,
    required this.vehicleNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height64,
      child: Card(
        margin: EdgeInsets.zero,
        color: SurfacevColor,
        elevation: 0.06,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius8)),
        child: InkWell(
          borderRadius: BorderRadius.circular(radius8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(
                left: padding8, right: padding16, top: padding8),
            child: Row(children: <Widget>[
              roverImage,
              _title(),
              _state(context, index, vehicleNames),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: padding6, right: padding6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: hint1TextStyle),
          ],
        ),
      ),
    );
  }

  Widget _state(BuildContext context, int index, List<String> vehicleNames) {
    return InkWell(
      onTap: () async {
        await _showDriverPage(context, vehicleNames[index]);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          cameraImage,
          const Text(
            'смотреть',
            style: pickupTextStyle,
          ),
        ],
      ),
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