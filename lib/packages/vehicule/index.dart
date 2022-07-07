import 'package:flutter/material.dart';

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
                        showModalBottomSheet<void>(
                          // context and builder are
                          // required properties in this widget
                          context: context,
                          builder: (BuildContext context) {
                            // we set up a container inside which
                            // we create center column and display text

                            // Returning SizedBox instead of a Container
                            return SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    children: const <Widget>[
                                      Text('GeeksforGeeks'),
                                    ],
                                ),
                              ),
                            );
                          }
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