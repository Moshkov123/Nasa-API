import 'package:flutter/material.dart';
import 'package:satellite/design/dimensions.dart';
import 'package:satellite/design/styles.dart';

import '../../design/logic/imageLogic.dart';


class SatellitePhotoItem extends StatelessWidget {
  final String imageUrl;
  final String  title;
  final String explanation;

  const SatellitePhotoItem({
    Key? key,
    required this.imageUrl,
    required this. title,
    required this.explanation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size adjustedScreenSize = ScreenUtil.calculateAdjustedScreenSize(context);
    return Card(
      child: Column(
        children: [
          Image.network(
            imageUrl,
            width: adjustedScreenSize.width,
            height: adjustedScreenSize.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(padding8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: primaryTextStyle,
                ),
                Text(
                  explanation,
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