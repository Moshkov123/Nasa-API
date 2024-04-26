import 'package:flutter/material.dart';
import 'dart:math';
import 'package:satellite/design/styles.dart';

import '../../design/logic/imageLogic.dart';

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
    Size adjustedScreenSize = ScreenUtil.calculateAdjustedScreenSize(context);
    return Card(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _showImageDialog(context, imageUrl),
            child: Image.network(
              imageUrl,
              width: adjustedScreenSize.width,
              height: adjustedScreenSize.height,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
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
  void _showImageDialog(BuildContext context, String imageUrl) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    double adjustedScreenWidth;
    double adjustedScreenHeight;

    if (screenWidth < screenHeight) {
      // Device is in portrait mode, make the image take up the full width
      adjustedScreenWidth = screenWidth;
      adjustedScreenHeight = screenHeight * 0.35; // 35% of the screen height
    } else {
      // Device is in landscape mode, make the image 35% of the screen width
      adjustedScreenWidth = screenWidth*0.95;
      adjustedScreenHeight = screenHeight*0.75; // Full screen height
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero, // Remove the default padding
          child: Container(
            width: adjustedScreenWidth, // Set the width of the container to match the adjusted screen width
            child: Image.network(
              imageUrl,
              width: adjustedScreenWidth, // Set the width of the image to match the adjusted screen width
              height: adjustedScreenHeight, // Set the height of the image to the adjusted screen height
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}
