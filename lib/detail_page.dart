import 'package:charging_station/api_osrm.dart';
import 'package:charging_station/consts.dart';
import 'package:charging_station/models/gas_station.dart';
import 'package:charging_station/models/overviews.dart';
import 'package:charging_station/widgets/custom_marker.dart';
import 'package:charging_station/widgets/overview_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer_pro/sizer.dart';

class DetailPage extends StatefulWidget {
  final GasStation gasStation;
  const DetailPage({super.key, required this.gasStation});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  late final MapController mapController;
  List<Polyline> polylinesCoordinate = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mapController;
  }

  @override
  Widget build(BuildContext context) {
    final distance = const Distance()
        .as(LengthUnit.Meter, currentLocation, widget.gasStation.location);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 165,
        leading: Row(
          children: [
            SizedBox(width: 5.w),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(5.w)),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 8.f,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      'Detail',
                      style: roboto.copyWith(fontSize: 5.5.f),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: white,
                shape: BoxShape.circle,
                border: Border.all(color: white)),
            child: Icon(
              Icons.favorite_outline_rounded,
              color: black,
              size: 8.f,
            ),
          ),
          SizedBox(width: 2.5.w),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: white,
                shape: BoxShape.circle,
                border: Border.all(color: white)),
            child: Icon(
              Icons.more_horiz_rounded,
              color: black,
              size: 8.f,
            ),
          ),
          SizedBox(width: 5.w)
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            SizedBox(
              height: 40.h,
              child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: currentLocation,
                    onMapReady: () {
                      setBound();
                      getRoutes();
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    PolylineLayer(polylines: polylinesCoordinate),
                    MarkerLayer(markers: [
                      Marker(
                          height: 3.w,
                          width: 3.w,
                          alignment: Alignment.center,
                          point: currentLocation,
                          child: Icon(Icons.circle, color: blue, size: 3.w)),
                      Marker(
                          height: 3.w,
                          width: 3.w,
                          alignment: Alignment.center,
                          point: widget.gasStation.location,
                          child: Icon(Icons.circle, color: blue, size: 3.w)),
                      Marker(
                        width: 25.sp,
                        height: 28.sp,
                        point: currentLocation,
                        alignment: Alignment.topCenter,
                        child: CustomMarker(
                            color: white,
                            widget1: Positioned(
                                right: 0,
                                child: Image.asset(
                                  'assets/bmw_i8.png',
                                  width: 28.sp,
                                  height: 28.sp,
                                )),
                            widget2: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Icon(
                                Icons.radar_rounded,
                                color: blue,
                                size: 7.f,
                              ),
                            )),
                      ),
                      Marker(
                          alignment: Alignment.topCenter,
                          point: widget.gasStation.location,
                          width: 25.sp,
                          height: 28.sp,
                          child: CustomMarker(
                            widget1: ClipOval(
                              child: Image.asset(
                                widget.gasStation.image,
                                width: 23.sp,
                                height: 23.sp,
                                fit: BoxFit.cover,
                              ),
                            ),
                            widget2: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Icon(
                                Icons.location_on,
                                color: blue,
                                size: 7.f,
                              ),
                            ),
                            color: Colors.white,
                          ))
                    ])
                  ]),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 61.h,
                width: 100.w,
                decoration: BoxDecoration(
                    color: black,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(5.w))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.local_gas_station,
                                color: white,
                                size: 6.f,
                              ),
                              SizedBox(width: 1.w),
                              Expanded(
                                child: Text(
                                  widget.gasStation.name,
                                  style: roboto.copyWith(
                                      fontSize: 6.f, color: white),
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.battery_25,
                                        color: blue,
                                        size: 10.f,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        '14.4%',
                                        style: roboto.copyWith(
                                            fontSize: 9.f, color: white),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '20 Km left',
                                    style: roboto.copyWith(
                                        fontSize: 5.f, color: grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '${(distance / 1000).toStringAsFixed(1)} Km',
                                    style: roboto.copyWith(
                                        fontSize: 8.f, color: white),
                                  ),
                                  Text(
                                    'Distance',
                                    style: roboto.copyWith(
                                        fontSize: 6.f, color: grey),
                                  )
                                ],
                              ),
                              SizedBox(width: 5.w),
                              Column(
                                children: [
                                  Text(
                                    '25 Mins',
                                    style: roboto.copyWith(
                                        fontSize: 8.f, color: white),
                                  ),
                                  Text(
                                    'Avg Time',
                                    style: roboto.copyWith(
                                        fontSize: 6.f, color: grey),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100.w,
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(5.w))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Overviews',
                                style: roboto.copyWith(
                                  fontSize: 10.f,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 2.w, horizontal: 2.5.w),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: black.withOpacity(.5)),
                                    borderRadius: BorderRadius.circular(2.5.w)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: black,
                                      size: 5.f,
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.gasStation.address,
                                        style: roboto.copyWith(
                                          height: 1,
                                          fontSize: 5.5.f,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 2.h),
                              SingleChildScrollView(
                                clipBehavior: Clip.none,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...List.generate(
                                        overviews.length,
                                        (index) => Padding(
                                              padding: index == 0
                                                  ? const EdgeInsets.only()
                                                  : index == 2
                                                      ? EdgeInsets.only(
                                                          right: 5.w,
                                                          left: 2.5.w)
                                                      : EdgeInsets.only(
                                                          left: 2.5.w),
                                              child: OverviewItem(
                                                icon: overviews[index]['icon'],
                                                text1: overviews[index]
                                                    ['text1'],
                                                text2: overviews[index]
                                                    ['text2'],
                                              ),
                                            ))
                                  ],
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Container(
                                width: double.infinity,
                                height: 15.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.5.w),
                                    image: DecorationImage(
                                        image:
                                            AssetImage(widget.gasStation.image),
                                        fit: BoxFit.cover)),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 2.5.w,
                          top: -6.h,
                          child: Image.asset(
                            'assets/bmw_i8.png',
                            width: 50.w,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.w),
        decoration: const BoxDecoration(color: white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(
                    style: roboto.copyWith(
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                  TextSpan(
                      text: '\$${widget.gasStation.price.toStringAsFixed(1)}',
                      style: roboto.copyWith(fontSize: 13.f)),
                  TextSpan(
                      text: '/100v',
                      style: roboto.copyWith(
                          fontSize: 6.f, color: black.withOpacity(.5)))
                ])),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                  color: blue, borderRadius: BorderRadius.circular(5.w)),
              child: Row(
                children: [
                  Text(
                    'Direction',
                    style: roboto.copyWith(fontSize: 6.f, color: white),
                  ),
                  SizedBox(width: 2.w),
                  const Icon(
                    Icons.directions,
                    color: white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getRoutes() async {
    List<LatLng>? polylines = await ApiOSRM().getRoutes(
        currentLocation.longitude.toString(),
        currentLocation.latitude.toString(),
        widget.gasStation.location.longitude.toString(),
        widget.gasStation.location.latitude.toString());
    setState(() {
      if (polylines!.isNotEmpty) {
        polylinesCoordinate
            .add(Polyline(points: polylines, strokeWidth: 3, color: blue));
      }
    });
  }

  setBound() async {
    final bounds =
        LatLngBounds.fromPoints([currentLocation, widget.gasStation.location]);
    mapController.fitCamera(CameraFit.bounds(
        bounds: bounds,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.w, top: 20.w)));
  }
}
