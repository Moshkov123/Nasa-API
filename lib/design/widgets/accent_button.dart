import 'package:flutter/material.dart';
import 'package:satellite/design/colors.dart';
import 'package:satellite/design/dimensions.dart';

import '../styles.dart';


class AccentButton extends StatelessWidget {
  final String title;
  final Function() onTap;

  const AccentButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 40),
            maximumSize: const Size.fromHeight(40),
            backgroundColor: PrimaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius20)),
            padding: const EdgeInsets.only(left: padding16,right: padding16)),
        child: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          title,
          style:accentButtonTextStyle,
        ));
  }
}
