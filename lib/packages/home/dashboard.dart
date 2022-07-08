import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toksmo_auto_dashbaord/main.dart';
import 'package:toksmo_auto_dashbaord/packages/vehicule/index.dart';

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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => vehiculeIndex(
                    'vehicule'
                  )),
                );
              },
            ),
            ListTile(
              title: const Text('ENGIN'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => vehiculeIndex(
                      'engin'
                  )),
                );
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
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
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