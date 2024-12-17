import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: const Center(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 20),
            ),
             SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
