import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toksmo_auto_dashbaord/widget/alert.dart';
import 'package:uuid/uuid.dart';

import '../vehicule/index.dart';

class Modele extends StatefulWidget {

  final String type;
  final modele;

  Modele({required this.type, this.modele});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Modele();
  }
}

class _Modele extends State<Modele> {

  TextEditingController name = new TextEditingController();
  BuildContext? contexte;

  Future uploadFile(BuildContext context) async {
    if(widget.modele != null){
      DocumentReference modeles = FirebaseFirestore.instance
          .collection('donnees')
          .doc('${widget.type}')
          .collection('modele')
          .doc('${widget.modele['key']}');
      modeles
          .set({
        'name': name.text,
        'key' : widget.modele['key']
      }).then((value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => vehiculeIndex(
            '${widget.type}'
        )),
      ));
    } else
    {

      try {
        var uuid = Uuid();
        String keys;
        if(widget.modele != null){
          keys = widget.modele['key'];
        }
          else {
            keys = uuid.v1().toString();
        }
        DocumentReference marques = FirebaseFirestore.instance
            .collection('donnees')
            .doc('${widget.type}')
            .collection('modele')
            .doc('$keys');
        marques
            .set({
          'name': name.text,
          'key' : keys
        }).then((value) => Navigator.pop(context));
      } catch (e) {
        print('error occured');
      }
    }
  }


  @override
  void initState() {
    if(widget.modele != null){
      name.text = widget.modele['name'];
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.modele != null ?
              'Update ${widget.modele['name']}' :
          'Add Modele : ${widget.type}'
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).
          size.height - 100,
          child: Padding
            (
            padding: EdgeInsets.all(8.0
            )
            ,
            child: Column
              (
              children: <
                  Widget>[
                SizedBox
                  (
                  height: 16.0
                  ,
                )
                ,
                Container
                  (
                  child: TextField
                    (
                    controller: name,decoration: InputDecoration
                    (
                    border: OutlineInputBorder
                      (
                    ),labelText: 'Nom',
                  ),
                  ),
                ),

                SizedBox(height: 20.0),

                OutlinedButton(
                    onPressed: (){
                      if(name.text.length < 1){
                        showMyDialog(context, 'Modele', 'Entrez le nom du modele');
                      }

                      if(widget.modele != null){
                        uploadFile(context);
                      } else {
                        uploadFile(context);
                      }
                    },
                    child: Text('SAVE MARQUE')
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}