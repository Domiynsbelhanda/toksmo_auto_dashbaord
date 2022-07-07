import 'package:flutter/material.dart';
import 'package:toksmo_auto_dashbaord/packages/marque/marque.dart';

class vehiculeIndex extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _vehiculeIndex();
  }
}

class _vehiculeIndex extends State<vehiculeIndex>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GESTION DES VEHICULES'
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Marque('vehicule')),
                        );
                      },
                      child: Text('ADD MARQUE'),
                    ),

                    OutlinedButton(
                      onPressed: () { },
                      child: Text('ADD ITEM'),
                    )
                  ],
                ),

                SizedBox(height: 8.0),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              '150 MARQUES'
                            ),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      child: Card(
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                                '120 ITEMS'
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}