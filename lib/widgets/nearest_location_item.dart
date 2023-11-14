import 'package:charging_station/consts.dart';
import 'package:charging_station/models/gas_station.dart';
import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class NearestLocationItem extends StatelessWidget {
  final GasStation gasStation;
  const NearestLocationItem({
    super.key,
    required this.gasStation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(2.5.w)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 30.w,
                  height: 17.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.5.w),
                      image: DecorationImage(
                          image: AssetImage(gasStation.image),
                          fit: BoxFit.cover)),
                ),
                SizedBox(width: 2.5.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        gasStation.name,
                        style: roboto.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 7.f),
                      ),
                      Row(
                        children: [
                          RichText(
                              text: TextSpan(
                                  style: roboto.copyWith(
                                    color: blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                TextSpan(
                                    text:
                                        '\$${gasStation.price.toStringAsFixed(0)}',
                                    style: roboto.copyWith(fontSize: 8.f)),
                                TextSpan(
                                    text: '/100v',
                                    style: roboto.copyWith(fontSize: 6.f))
                              ])),
                          SizedBox(width: 1.w),
                          Icon(
                            Icons.circle,
                            size: 2.f,
                            color: grey,
                          ),
                          SizedBox(width: 1.w),
                          RichText(
                              text: TextSpan(
                                  style: roboto.copyWith(
                                    color: blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                TextSpan(
                                    text: '8',
                                    style: roboto.copyWith(fontSize: 8.f)),
                                TextSpan(
                                    text: '/10 plug',
                                    style: roboto.copyWith(fontSize: 6.f))
                              ]))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 8.f,
                ),
                SizedBox(width: 2.5.w),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: roboto.copyWith(
                          color: black.withOpacity(.5), fontSize: 6.f),
                    ),
                    Text(
                      gasStation.address,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: roboto.copyWith(
                        fontSize: 6.f,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: white,
                      shape: BoxShape.circle,
                      border: Border.all(color: black.withOpacity(.5))),
                  child: Icon(
                    Icons.share,
                    color: black,
                    size: 8.f,
                  ),
                ),
                SizedBox(width: 2.5.w),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: blue,
                      shape: BoxShape.circle,
                      border: Border.all(color: blue)),
                  child: Icon(
                    Icons.directions,
                    color: white,
                    size: 8.f,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
