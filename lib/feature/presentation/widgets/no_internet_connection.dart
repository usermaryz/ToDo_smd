import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Нет сети'),
      ),
      body: const Center(
        child: Text('Пожалуйста, проверьте ваше интернет-соединение.'),
      ),
    );
  }
}
