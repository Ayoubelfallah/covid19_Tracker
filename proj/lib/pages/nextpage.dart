import 'package:flutter/material.dart';
class NextPage extends StatelessWidget {
  final String data;

  NextPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Données du code QR'),
      ),
      body: Center(
        child: Text(data),
      ),
    );
  }
}

