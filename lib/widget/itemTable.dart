import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toksmo_auto_dashbaord/packages/marque/item.dart';
import 'package:toksmo_auto_dashbaord/widget/alert.dart';

import '../packages/marque/marque.dart';

Widget itemTable (BuildContext context, String type, stream){
  return Container(
    child: Column(
      children: [
        Text('LISTE DES ITEMS'),

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: data['image'] != null ?
                            ClipRRect (
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(data['image']![0],
                                width: 60,
                                height: 60,
                                fit: BoxFit.fitHeight,
                              ),
                            ) : Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,color: Colors.grey[800],
                              ),
                            ),
                          ),

                          SizedBox(width: 16.0,),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${data['code']} / ${data['name']}',
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
                                        MaterialPageRoute(builder: (context) => Item(
                                          type: '$type',
                                          marque: {
                                            'name' : data['name'],
                                            'image' : data['image'],
                                            'key': data['key'],
                                            'code': data['code'],
                                            'etat': data['etat'],
                                            'prix': data['prix'],
                                            'marque': data['marque'],
                                            'carrosserie': data['carrosserie'],
                                            'modele': data['modele'],
                                            'poignet': data['poignet'],
                                            'carburant': data['carburant'],
                                            'couleur': data['couleur'],
                                            'kilometrage': data['kilometrage'],
                                            'boite_vitesse': data['boite_vitesse'],
                                            'nombre_siege': data['nombre_siege'],
                                            'nombre_porte': data['nombre_porte'],
                                            'annee': data['annee'],
                                            'cylindre': data['cylindre'],
                                          },
                                        )
                                        ),
                                      );
                                    },
                                    child: Text('MODIFIER'),
                                  ),

                                  OutlinedButton(
                                    onPressed: () {
                                      delete(context, '${data['name']}',
                                          'Voulez-vous supprimé?', type, 'item',
                                          '${data['key']}');
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