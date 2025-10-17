import 'package:flutter/material.dart';
import 'package:parkeasy/parking_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Parking'),
        backgroundColor: Color(0xFF1976D2),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for parking spots...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<ParkingProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.parkingSpots.length,
                  itemBuilder: (context, index) {
                    final spot = provider.parkingSpots[index];
                    return ListTile(
                      leading: Icon(
                        Icons.local_parking,
                        color: spot.isAvailable ? Colors.green : Colors.red,
                      ),
                      title: Text(spot.name),
                      subtitle: Text(
                        '\$${spot.pricePerHour}/hr • ${spot.availableSpots} spots',
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.pop(context);
                        // Show spot details
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
