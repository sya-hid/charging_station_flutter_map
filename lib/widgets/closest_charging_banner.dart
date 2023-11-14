import 'package:charging_station/consts.dart';
import 'package:charging_station/near_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sizer_pro/sizer.dart';

class ClosestChargingBanner extends StatelessWidget {
  const ClosestChargingBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: Container(
        width: 90.w,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(2.5.w)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2.5.w),
          child: Stack(
            alignment: Alignment.centerRight,
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: 50.w,
                child: FlutterMap(
                    options: MapOptions(initialCenter: currentLocation),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      ),
                      MarkerLayer(markers: [
                        Marker(
                            point: currentLocation,
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: blue),
                                child: Icon(Icons.near_me,
                                    size: 8.f, color: white)))
                      ])
                    ]),
              ),
              Positioned(
                top: -50,
                left: -50,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration:
                      const BoxDecoration(color: white, shape: BoxShape.circle),
                ),
              ),
              Positioned(
                left: 5.w,
                top: 5.w,
                bottom: 5.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Find closest\ncharging station',
                      style: roboto.copyWith(
                        fontSize: 8.f,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NearLocationPage()));
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(5.w)),
                          child: Text(
                            'Get Direction',
                            style: roboto.copyWith(fontSize: 6.f, color: white),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
