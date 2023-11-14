import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class CustomMarker extends StatelessWidget {
  final Color color;
  final Widget widget1, widget2;
  const CustomMarker(
      {super.key,
      required this.color,
      required this.widget1,
      required this.widget2});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -5,
            child: Container(
              width: 4,
              height: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.white),
            ),
          ),
          Container(
            height: 25.sp,
            width: 25.sp,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
          ),
          widget1,
          Positioned(
            right: -5,
            bottom: 5,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: widget2),
          )
        ],
      ),
    );
  }
}
