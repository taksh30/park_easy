import 'package:flutter/material.dart';
import 'package:parkeasy/parking_provider.dart';
import 'package:parkeasy/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ParkingProvider(),
      child: MaterialApp(
        title: 'ParkEasy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xFF1976D2),
          // accentColor: Color(0xFF4CAF50),
          fontFamily: 'Roboto',
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
