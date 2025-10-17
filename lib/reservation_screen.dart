import 'package:flutter/material.dart';
import 'package:parkeasy/parking_provider.dart';
import 'package:provider/provider.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reservations'),
        backgroundColor: Color(0xFF1976D2),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<ParkingProvider>(
        builder: (context, provider, child) {
          if (provider.reservations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No reservations yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.reservations.length,
            itemBuilder: (context, index) {
              final reservation = provider.reservations[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(Icons.local_parking, color: Color(0xFF1976D2)),
                  title: Text(reservation.spot.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${reservation.startTime.day}/${reservation.startTime.month} • ${TimeOfDay.fromDateTime(reservation.startTime).format(context)} - ${TimeOfDay.fromDateTime(reservation.endTime).format(context)}',
                      ),
                      Text('\$${reservation.totalPrice.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      reservation.status,
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
