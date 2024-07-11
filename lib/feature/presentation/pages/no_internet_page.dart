import '/feature/presentation/widgets/no_internet_connection.dart';
import 'package:flutter/material.dart';

class NoInternetApp extends StatelessWidget {
  const NoInternetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NoInternetScreen(),
    );
  }
}