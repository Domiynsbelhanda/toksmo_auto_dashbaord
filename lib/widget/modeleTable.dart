import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toksmo_auto_dashbaord/packages/marque/modele.dart';
import 'package:toksmo_auto_dashbaord/widget/alert.dart';

import '../packages/marque/marque.dart';

Widget modeleTable (BuildContext context, String type, stream){
  return Container(
    child: Column(
      children: [
        Text('LISTE DES MODELES'),

        SizedBox(height: 16.0,),
          StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Column(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                  return Container(
                    child: Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${data['name']}',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 18
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Modele(
                                          type: '$type',
                                        modele: {
                                            'name' : data['name'],
                                          'key': data['key']
                                        },
                                      )
                                      ),
                                    );
                                  },
                                  child: Text('MODIFIER'),
                                ),

                                OutlinedButton(
                                  onPressed: () {
                                    delete(context, '${data['name']}', 'Voulez-vous supprimé?', type, 'modele', '${data['key']}');
                                  },
                                  child: Text(
                                      'SUPPRIMER',
                                    style: TextStyle(
                                      color: Colors.red
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          )
      ],
    ),
  );
}