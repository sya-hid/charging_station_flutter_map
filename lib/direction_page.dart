import 'package:charging_station/api_osrm.dart';
import 'package:charging_station/consts.dart';
import 'package:charging_station/models/gas_station.dart';
import 'package:charging_station/widgets/custom_marker.dart';
import 'package:charging_station/widgets/zoom_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sizer_pro/sizer.dart';

class DirectionPage extends StatefulWidget {
  final LatLng sourceLocation;
  final GasStation gasStation;
  const DirectionPage(
      {super.key, required this.sourceLocation, required this.gasStation});

  @override
  State<DirectionPage> createState() => _DirectionPageState();
}

class _DirectionPageState extends State<DirectionPage>
    with TickerProviderStateMixin {
  List<Polyline> polylineCoordinate = [];
  LatLng? currentPosition = const LatLng(0, 0);
  late final MapController _mapController;

  void getPolyPoint() async {
    List<LatLng>? polylines = await ApiOSRM().getRoutes(
      widget.sourceLocation.longitude.toString(),
      widget.sourceLocation.latitude.toString(),
      widget.gasStation.location.longitude.toString(),
      widget.gasStation.location.latitude.toString(),
    );
    if (mounted) {
      setState(() {
        if (polylines!.isNotEmpty) {
          polylineCoordinate.add(
              Polyline(points: polylines, strokeWidth: 6, color: Colors.blue));
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    getPolyPoint();
  }

  @override
  dispose() {
    super.dispose();
    _mapController.dispose();
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  getPosition() async {
    final hasPermission = await handleLocationPermission();
    if (hasPermission) {
      Geolocator.getPositionStream().listen((event) {
        if (!mounted) return;
        setState(() {
          currentPosition = LatLng(event.latitude, event.longitude);
        });
        _animatedMapMove(currentPosition!, _mapController.camera.zoom);
      });
    }
  }

  setBound() async {
    final bounds = LatLngBounds.fromPoints(
        [widget.sourceLocation, widget.gasStation.location]);
    _mapController.fitCamera(CameraFit.bounds(
        bounds: bounds,
        padding:
            EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.w, top: 20.w)));
  }

  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _inProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';
  void _animatedMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween(
        begin: _mapController.camera.center.latitude,
        end: destLocation.latitude);
    final lngTween = Tween(
        begin: _mapController.camera.center.longitude,
        end: destLocation.longitude);
    final zoomTween = Tween(begin: _mapController.camera.zoom, end: destZoom);
    final controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},$destZoom';
    bool hasTriggeredMove = false;
    controller.addListener(() {
      final String id;
      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = startIdWithTarget;
      } else {
        id = _inProgressId;
      }
      hasTriggeredMove |= _mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation),
          id: id);
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            onMapReady: () {
              setBound();
              getPosition();
            },
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            PolylineLayer(
              polylines: polylineCoordinate,
            ),
            ZoomButton(
                alignment: const Alignment(1, .85),
                maxZoom: 19,
                minZoom: 5,
                padding: 5.w),
            MarkerLayer(markers: [
              Marker(
                  height: 3.w,
                  width: 3.w,
                  alignment: Alignment.center,
                  point: widget.sourceLocation,
                  child: Icon(Icons.circle, color: blue, size: 3.w)),
              Marker(
                  height: 3.w,
                  width: 3.w,
                  alignment: Alignment.center,
                  point: widget.gasStation.location,
                  child: Icon(Icons.circle, color: blue, size: 3.w)),
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
                ),
              ),
              Marker(
                width: 25.sp,
                height: 28.sp,
                point: currentPosition!,
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
            ])
          ]),
    );
  }
}
