import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Нет сети'),
      ),
      body: Center(
        child: Text('Пожалуйста, проверьте ваше интернет-соединение.'),
      ),
    );
  }
}
