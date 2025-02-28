import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/components/custom_button.dart';
import 'package:suitmedia_test/provider/selected_user_provider.dart';
import 'package:suitmedia_test/routes/navigation.dart';

class SecondScreen extends StatelessWidget {
  final String name;
  const SecondScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    final selectedUserName =
        context.watch<SelectedUserProvider>().selectedUserName;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Second Screen',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: Text(
              selectedUserName ?? 'Selected User Name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: CustomButton(
              onTap: () {
                Navigator.pushNamed(context, Navigation.thirdScreen.name);
              },
              text: 'Choose a User',
            ),
          ),
        ],
      ),
    );
  }
}
