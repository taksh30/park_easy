class ParkingSpot {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double pricePerHour;
  final String type;
  final bool isAvailable;
  final int availableSpots;
  final double rating;
  final String description;

  ParkingSpot({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.pricePerHour,
    required this.type,
    required this.isAvailable,
    required this.availableSpots,
    required this.rating,
    required this.description,
  });
}

class Reservation {
  final String id;
  final ParkingSpot spot;
  final DateTime startTime;
  final DateTime endTime;
  final double totalPrice;
  final String status;

  Reservation({
    required this.id,
    required this.spot,
    required this.startTime,
    required this.endTime,
    required this.totalPrice,
    required this.status,
  });
}
