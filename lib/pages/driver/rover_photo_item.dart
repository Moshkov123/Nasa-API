import 'package:flutter/material.dart';
import 'package:satellite/design/dimensions.dart';
import 'package:satellite/design/styles.dart';


class RoverPhotoItem extends StatelessWidget {
  final String imageUrl;
  final String roverName;
  final String earthDate;

  const RoverPhotoItem({
    Key? key,
    required this.imageUrl,
    required this.roverName,
    required this.earthDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            imageUrl,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(padding8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roverName,
                  style: primaryTextStyle,
                ),
                Text(
                  earthDate,
                  style: hint1TextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}