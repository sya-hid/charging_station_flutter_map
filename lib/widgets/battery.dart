import 'package:charging_station/consts.dart';
import 'package:charging_station/widgets/wave_progress.dart';
import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class Battery extends StatelessWidget {
  const Battery({
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Battery',
                    style: roboto.copyWith(
                        fontSize: 9.f,
                        color: black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Last charge 2w ago',
                    style: roboto.copyWith(
                        fontSize: 5.f, color: black.withOpacity(.4)),
                  )
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 8.f,
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(children: [
            Column(
              children: [
                Container(
                  width: 30,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: grey.shade200),
                ),
                const SizedBox(height: 3),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Container(
                    width: 50,
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: grey.shade200),
                    child: const WaveProgress(waveColor: blue, progress: 40),
                  ),
                ),
              ],
            ),
            SizedBox(width: 2.5.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          style: roboto.copyWith(
                              color: black, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: '212',
                            style: roboto.copyWith(fontSize: 12.f)),
                        TextSpan(
                            text: ' km', style: roboto.copyWith(fontSize: 7.f)),
                      ])),
                  const Divider(),
                  RichText(
                      text: TextSpan(
                          style: roboto.copyWith(
                              color: black, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: '14', style: roboto.copyWith(fontSize: 8.f)),
                        TextSpan(
                            text: '%', style: roboto.copyWith(fontSize: 6.f)),
                        TextSpan(
                            text: ' 120 kv',
                            style: roboto.copyWith(
                                fontSize: 5.f, color: black.withOpacity(.4))),
                      ])),
                ],
              ),
            )
          ]),
          const SizedBox(height: 15),
          Text(
            'Saving Mode Battery',
            style: roboto.copyWith(fontSize: 5.f, color: black.withOpacity(.4)),
          )
        ],
      ),
    );
  }
}
