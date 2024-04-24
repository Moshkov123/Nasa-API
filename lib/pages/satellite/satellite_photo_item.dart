import 'package:flutter/material.dart';
import 'package:satellite/design/dimensions.dart';
import 'package:satellite/design/styles.dart';


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