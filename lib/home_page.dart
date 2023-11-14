import 'package:charging_station/consts.dart';
import 'package:charging_station/models/bottom_nav.dart';
import 'package:charging_station/widgets/battery.dart';
import 'package:charging_station/widgets/closest_charging_banner.dart';
import 'package:charging_station/widgets/total_distance.dart';
import 'package:charging_station/widgets/weather.dart';
import 'package:flutter/material.dart';
import 'package:sizer_pro/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white.withOpacity(.9),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 30.h,
                width: 100.w,
                color: black,
                padding: EdgeInsets.fromLTRB(5.w, 10.w, 5.w, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,\nAli Husni',
                          style: roboto.copyWith(
                              fontSize: 13.f, color: white, height: 1),
                        ),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: white.withOpacity(.5),
                                  )),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: white,
                                size: 8.f,
                              ),
                            ),
                            Positioned(
                              right: -5,
                              top: -5,
                              child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                      color: red, shape: BoxShape.circle),
                                  child: Text(
                                    '2',
                                    style: roboto.copyWith(color: white),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'BMW i8',
                      style: roboto.copyWith(fontSize: 6.f, color: white),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: -7.h,
                right: 0,
                child: Image.asset(
                  'assets/bmw_i8.png',
                  width: 80.w,
                ),
              )
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 50.w,
                  child: const Battery(),
                ),
                SizedBox(
                  width: 37.w,
                  child: Column(
                    children: [
                      const TotalDistance(),
                      SizedBox(height: 3.w),
                      const Weather(),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: const ClosestChargingBanner(),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 5.w, bottom: 5.w, right: 5.w),
        child: Container(
          padding: EdgeInsets.all(5.w),
          decoration: BoxDecoration(
              color: black, borderRadius: BorderRadius.circular(10.w)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                  bottomNavIcons.length,
                  (index) => Icon(
                        bottomNavIcons[index],
                        color: index == 0 ? white : grey,
                        size: 10.f,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
