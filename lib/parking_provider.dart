import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkeasy/model/models.dart';

class ParkingProvider with ChangeNotifier {
  List<ParkingSpot> _parkingSpots = [];
  List<Reservation> _reservations = [];
  ParkingSpot? _selectedSpot;
  Position? _currentPosition;

  List<ParkingSpot> get parkingSpots => _parkingSpots;
  List<Reservation> get reservations => _reservations;
  ParkingSpot? get selectedSpot => _selectedSpot;
  Position? get currentPosition => _currentPosition;

  void initializeDummyData() {
    _parkingSpots = [
      ParkingSpot(
        id: '1',
        name: 'City Mall Parking',
        latitude: 37.7749,
        longitude: -122.4194,
        pricePerHour: 5.0,
        type: 'Garage',
        isAvailable: true,
        availableSpots: 15,
        rating: 4.2,
        description: 'Covered parking with 24/7 security',
      ),
      ParkingSpot(
        id: '2',
        name: 'Street Parking - Main St',
        latitude: 37.7849,
        longitude: -122.4094,
        pricePerHour: 3.0,
        type: 'Street',
        isAvailable: true,
        availableSpots: 3,
        rating: 3.8,
        description: '2-hour limit, pay by meter',
      ),
      ParkingSpot(
        id: '3',
        name: 'Business Center Lot',
        latitude: 37.7649,
        longitude: -122.4294,
        pricePerHour: 4.5,
        type: 'Private',
        isAvailable: false,
        availableSpots: 0,
        rating: 4.5,
        description: 'Reserved for business visitors',
      ),
    ];
    notifyListeners();
  }

  void setSelectedSpot(ParkingSpot spot) {
    _selectedSpot = spot;
    notifyListeners();
  }

  void addReservation(Reservation reservation) {
    _reservations.add(reservation);
    notifyListeners();
  }

  void updateCurrentPosition(Position position) {
    _currentPosition = position;
    notifyListeners();
  }
}
