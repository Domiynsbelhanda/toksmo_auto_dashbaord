import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Dashboard();
  }
}

class _Dashboard extends State<Dashboard>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('VEHICULE'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('ENGIN'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('CAMION'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('TRUCK'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('PIECE'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('ACCESSOIRE'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('LOCATION'),
              onTap: () {
              },
            ),
            ListTile(
              title: const Text('DECONNEXION'),
              onTap: () {
              },
            ),
          ],
        ),
      ),
      body: Container(
      ),
    );
  }
}