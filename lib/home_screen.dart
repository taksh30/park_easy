import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkeasy/model/models.dart';
import 'package:parkeasy/parking_provider.dart';
import 'package:parkeasy/profile_screen.dart';
import 'package:parkeasy/reservation_screen.dart';
import 'package:parkeasy/search_screen.dart';
import 'package:parkeasy/spot_details_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _getCurrentLocation();
  }

  void _initializeData() {
    Provider.of<ParkingProvider>(context, listen: false).initializeDummyData();
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      Provider.of<ParkingProvider>(
        context,
        listen: false,
      ).updateCurrentPosition(position);
      _updateMarkers();
    } catch (e) {
      // Handle location permission errors
      print('Error getting location: $e');
    }
  }

  void _updateMarkers() {
    final provider = Provider.of<ParkingProvider>(context, listen: false);
    _markers.clear();

    for (ParkingSpot spot in provider.parkingSpots) {
      _markers.add(
        Marker(
          markerId: MarkerId(spot.id),
          position: LatLng(spot.latitude, spot.longitude),
          infoWindow: InfoWindow(
            title: spot.name,
            snippet: '\$${spot.pricePerHour}/hr - ${spot.availableSpots} spots',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            spot.isAvailable
                ? BitmapDescriptor.hueGreen
                : BitmapDescriptor.hueRed,
          ),
          onTap: () => _showSpotDetails(spot),
        ),
      );
    }
    setState(() {});
  }

  void _showSpotDetails(ParkingSpot spot) {
    Provider.of<ParkingProvider>(context, listen: false).setSelectedSpot(spot);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SpotDetailsSheet(spot: spot),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ParkEasy'),
        backgroundColor: Color(0xFF1976D2),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Map View
          Consumer<ParkingProvider>(
            builder: (context, provider, child) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.7749, -122.4194),
                  zoom: 14.0,
                ),
                markers: _markers,
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  _updateMarkers();
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              );
            },
          ),
          // Reservations
          ReservationsScreen(),
          // Profile
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Reservations',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
