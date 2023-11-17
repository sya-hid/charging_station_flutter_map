import 'package:latlong2/latlong.dart';

class GasStation {
  final LatLng location;
  final String address, image, name;
  final double price;

  GasStation(
      {required this.image,
      required this.name,
      required this.price,
      required this.address,
      required this.location});
}

List<GasStation> gasStations = [
  GasStation(
      name: 'EV Solom\'yans\'kyi district',
      location: const LatLng(50.403984, 30.48751),
      price: 55.5,
      image: 'assets/download.jpeg',
      address:
          'Kruhla St, Solom\'yans\'kyi district, Kyiv, Kyiv City, Kyiv 02000'),
  GasStation(
      name: 'EV Holosiivs\'kyi district',
      location: const LatLng(50.397693, 30.50766),
      image: 'assets/download (1).jpeg',
      price: 50.9,
      address:
          'Holosiivska, Holosiivs\'kyi district, Kyiv, Kyiv City, Kyiv 02000'),
  GasStation(
      name: 'EV Pechers\'kyi district',
      location: const LatLng(50.412434, 30.541364),
      image: 'assets/images.jpeg',
      price: 60.2,
      address: '17A, Pechers\'kyi district, Kyiv, Kyiv City, Kyiv 02000'),
  GasStation(
      name: 'EV Shovkovychna Pechers\'kyi district',
      location: const LatLng(50.438934, 30.530775),
      image: 'assets/images (1).jpeg',
      price: 62.1,
      address:
          'Shovkovychna St, Pechers\'kyi district, Kyiv, Kyiv City, Kyiv 02000'),
  GasStation(
      name: 'EV Pivdennyi Railway Station',
      location: const LatLng(50.439474, 30.485271),
      image: 'assets/images (2).jpeg',
      price: 58.6,
      address:
          'Pivdennyi Railway Station, Solom\'yans\'kyi district, Kyiv, Kyiv City, Kyiv 02000')
];
