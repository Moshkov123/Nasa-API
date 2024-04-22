import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:satellite/design/colors.dart';
import 'package:satellite/design/dimensions.dart';
import 'package:satellite/design/images.dart';
import 'package:satellite/design/styles.dart';

class VehicleItem extends StatelessWidget {
  final Function() onTap;
  const VehicleItem({super.key, required this.onTap});

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
            child: Row(children: <Widget>[MotorcycleImage, _title(), _state()]),
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
              const Text('BMW GS-7638',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: hint1TextStyle),
              false
                  ? Text(
                      'Нет водителя',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: body2TextStyle
                    )
                  : RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Водитель ',
                                style:  body2TextStyle),
                            TextSpan(
                                text: 'Tom',
                                style: hint1TextStyle),
                          ]))
            ]),
      ),
    );
  }

  Widget _state() {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          statePickupImage,
          Text(
            'pickup',
            style: pickupTextStyle,
          )
        ],
      ),
    );
  }
}
