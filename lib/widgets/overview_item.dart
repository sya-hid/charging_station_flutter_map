import 'package:charging_station/consts.dart';
import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class OverviewItem extends StatelessWidget {
  final IconData icon;
  final String text1, text2;
  const OverviewItem({
    super.key,
    required this.icon,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 35.w,
        padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.5.w),
        decoration: BoxDecoration(
            border: Border.all(color: black.withOpacity(.5)),
            borderRadius: BorderRadius.circular(2.5.w)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 8.f,
            ),
            SizedBox(height: 1.h),
            Text(text1,
                style: roboto.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 7.f,
                )),
            Text(text2,
                style: roboto.copyWith(
                    color: black.withOpacity(.5), fontSize: 6.f)),
          ],
        ));
  }
}
