import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parkeasy/model/models.dart';
import 'package:parkeasy/parking_provider.dart';
import 'package:provider/provider.dart';

class SpotDetailsSheet extends StatefulWidget {
  final ParkingSpot spot;

  const SpotDetailsSheet({super.key, required this.spot});

  @override
  State<SpotDetailsSheet> createState() => _SpotDetailsSheetState();
}

class _SpotDetailsSheetState extends State<SpotDetailsSheet> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay(hour: DateTime.now().hour + 2, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          // Spot Info
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.spot.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: widget.spot.isAvailable
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.spot.isAvailable ? 'Available' : 'Full',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    Text(' ${widget.spot.rating} • '),
                    Text(widget.spot.type),
                    Text(' • ${widget.spot.availableSpots} spots'),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  widget.spot.description,
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price: \$${widget.spot.pricePerHour}/hour',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1976D2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(),
          // Time Selection
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Time',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTimeSelector('Start', _startTime, (time) {
                      setState(() => _startTime = time);
                    }),
                    _buildTimeSelector('End', _endTime, (time) {
                      setState(() => _endTime = time);
                    }),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          // Book Button
          Padding(
            padding: EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: widget.spot.isAvailable ? _bookSpot : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  widget.spot.isAvailable ? 'Book Now' : 'Not Available',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelector(
    String label,
    TimeOfDay time,
    Function(TimeOfDay) onChanged,
  ) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        InkWell(
          onTap: () async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: time,
            );
            if (picked != null) onChanged(picked);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(time.format(context), style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  void _bookSpot() {
    final startDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _startTime.hour,
      _startTime.minute,
    );
    final endDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _endTime.hour,
      _endTime.minute,
    );

    final duration = endDateTime.difference(startDateTime).inHours;
    final totalPrice = duration * widget.spot.pricePerHour;

    final reservation = Reservation(
      id: Random().nextInt(10000).toString(),
      spot: widget.spot,
      startTime: startDateTime,
      endTime: endDateTime,
      totalPrice: totalPrice,
      status: 'Active',
    );

    Provider.of<ParkingProvider>(
      context,
      listen: false,
    ).addReservation(reservation);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Parking spot booked successfully!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
