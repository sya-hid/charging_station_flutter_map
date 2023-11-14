import 'package:charging_station/consts.dart';
import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class Weather extends StatelessWidget {
  const Weather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.5.w),
      decoration: BoxDecoration(
          color: white, borderRadius: BorderRadius.circular(2.5.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.cloud,
                size: 10.f,
              ),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 8.f,
              )
            ],
          ),
          const SizedBox(height: 10),
          Text('24C',
              style: roboto.copyWith(
                  fontSize: 9.f,
                  color: black,
                  height: 1,
                  fontWeight: FontWeight.bold)),
          Text(
            'Patchy Cloudy',
            style: roboto.copyWith(fontSize: 5.f, color: black.withOpacity(.4)),
          )
        ],
      ),
    );
  }
}
