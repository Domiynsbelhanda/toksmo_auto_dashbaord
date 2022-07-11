import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../widget/alert.dart';
import '../vehicule/index.dart';

class Item extends StatefulWidget {

  final String type;
  final marque;

  Item({required this.type, this.marque});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Item();
  }
}

class _Item extends State<Item> {

  TextEditingController name = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController etatController = TextEditingController();
  TextEditingController prixController = TextEditingController();
  TextEditingController type_carrosserieController = TextEditingController();
  TextEditingController poignetController = TextEditingController();
  TextEditingController carburantController = TextEditingController();
  TextEditingController couleurController = TextEditingController();
  TextEditingController kilometrageController = TextEditingController();
  TextEditingController boite_vitesseController = TextEditingController();
  TextEditingController nombre_siegeController = TextEditingController();
  TextEditingController nombre_porteController = TextEditingController();
  TextEditingController anneeController = TextEditingController();
  TextEditingController cylindreController = TextEditingController();
  TextEditingController conduiteController = TextEditingController();
  String? marque;
  String? modele;
  BuildContext? contexte;

  FirebaseStorage storage =
      FirebaseStorage.instance;
  List<XFile>? _photo;
  final ImagePicker _picker = ImagePicker();
  List images = [];

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickMultiImage();

    setState(() {
      if (pickedFile != null) {
        _photo = pickedFile;
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile(BuildContext context) async {
    if(widget.marque != null && _photo == null){
      DocumentReference marques = FirebaseFirestore.instance
          .collection('donnees')
          .doc('${widget.type}')
          .collection('item')
          .doc('${widget.marque['key']}');

      var datas;

      if(widget.type == 'vehicule') {
        datas = {
          'name': name.text,
          'image': widget.marque['image'],
          'key' : widget.marque['key'],
          'code': codeController.text,
          'etat': etatController.text,
          'prix': prixController.text,
          'marque': marque,
          'carrosserie': type_carrosserieController.text,
          'modele': modele,
          'poignet': poignetController.text,
          'carburant': carburantController.text,
          'couleur': couleurController.text,
          'kilometrage': kilometrageController.text,
          'boite_vitesse': boite_vitesseController.text,
          'nombre_siege': nombre_siegeController.text,
          'nombre_porte': nombre_porteController.text,
          'annee': anneeController.text,
          'cylindre': cylindreController.text,
          "timestamp": FieldValue.serverTimestamp(),
        };
      } else if(widget.type == 'engin'){
        datas = {
          'image': widget.marque['image'],
          'key' : widget.marque['key'],
          'name': name.text,
          'code': codeController.text,
          'etat': etatController.text,
          'prix': prixController.text,
          'marque': marque,
          'lieu': modele,
          'carrosserie': type_carrosserieController.text,
          'modele': modele,
          'poignet': poignetController.text,
          'carburant': carburantController.text,
          'couleur': couleurController.text,
          'kilometrage': kilometrageController.text,
          'boite_vitesse': boite_vitesseController.text,
          'annee': anneeController.text,
          'cylindre': cylindreController.text,
          "timestamp": FieldValue.serverTimestamp(),
        };
      } else if(widget.type == 'camion'){
        datas = {
          'image': widget.marque['image'],
          'key' : widget.marque['key'],
          'name': name.text,
          'code': codeController.text,
          'etat': etatController.text,
          'prix': prixController.text,
          'marque': marque,
          'lieu': modele,
          'carrosserie': type_carrosserieController.text,
          'modele': modele,
          'poignet': poignetController.text,
          'carburant': carburantController.text,
          'couleur': couleurController.text,
          'kilometrage': kilometrageController.text,
          'boite_vitesse': boite_vitesseController.text,
          'nombre_roue': nombre_siegeController.text,
          'annee': anneeController.text,
          'cylindre': cylindreController.text,
          "timestamp": FieldValue.serverTimestamp(),
        };
      } else if (widget.type == 'track'){
        datas = {
          'image': widget.marque['image'],
          'key' : widget.marque['key'],
          'name': name.text,
          'code': codeController.text,
          'etat': etatController.text,
          'prix': prixController.text,
          'marque': marque,
          'lieu': modele,
          'carrosserie': type_carrosserieController.text,
          'modele': modele,
          'poignet': poignetController.text,
          'carburant': carburantController.text,
          'couleur': couleurController.text,
          'kilometrage': kilometrageController.text,
          'boite_vitesse': boite_vitesseController.text,
          'nombre_roue': nombre_siegeController.text,
          'annee': anneeController.text,
          'cylindre': cylindreController.text,
          "timestamp": FieldValue.serverTimestamp(),
        };
      } else if (widget.type == 'location'){
        datas = {
          'image': widget.marque['image'],
          'key' : widget.marque['key'],
          'name': name.text,
          'code': codeController.text,
          'etat': etatController.text,
          'prix': prixController.text,
          'marque': marque,
          'lieu': modele,
          'carrosserie': type_carrosserieController.text,
          'modele': modele,
          'poignet': poignetController.text,
          'carburant': carburantController.text,
          'couleur': couleurController.text,
          'kilometrage': kilometrageController.text,
          'boite_vitesse': boite_vitesseController.text,
          'nombre_roue': nombre_siegeController.text,
          'annee': anneeController.text,
          'cylindre': cylindreController.text,
          "timestamp": FieldValue.serverTimestamp(),
        };
      } else if (widget.type == 'piece'){
        datas = {
          'image': widget.marque['image'],
          'key' : widget.marque['key'],
          'name': name.text,
          'code': codeController.text,
          'etat': etatController.text,
          'prix': prixController.text,
          'modele': modele,
          'image': images,
          "timestamp": FieldValue.serverTimestamp(),
        };
      } else if (widget.type == 'accessoire'){
        datas = {
          'image': widget.marque['image'],
          'key' : widget.marque['key'],
          'name': name.text,
          'code': codeController.text,
          'etat': etatController.text,
          'prix': prixController.text,
          'modele': modele,
          'couleur': couleurController.text,
          'image': images,
          "timestamp": FieldValue.serverTimestamp(),
        };
      }
      marques
          .set(datas).then((value) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => vehiculeIndex(
            '${widget.type}'
        )),
      ));
    } else
    {
      if (_photo == null) return;

      var uuid = Uuid();
      String keys;
      if(widget.marque != null){
        keys = widget.marque['key'];
      }
      else {
        keys = uuid.v1().toString();
      }

      DocumentReference marques = FirebaseFirestore.instance
          .collection('donnees')
          .doc('${widget.type}')
          .collection('item')
          .doc('$keys');

      for(var i = 0; i < _photo!.length; i++){
        final fileName = basename(_photo![i].path);
        final destination = '${widget.type}/item/$fileName';

        try {
          final Reference storageReference = FirebaseStorage.instance
              .ref()
              .child("images")
              .child(destination);
          String downloadURL;

          UploadTask uploadTask = storageReference.putFile(File(_photo![i].path));
          downloadURL = await (await uploadTask).ref.getDownloadURL();

          images.add(downloadURL);

          var datas;

          if(widget.type == 'vehicule') {
            datas = {
              'image': images,
              'name': name.text,
              'key': keys,
              'code': codeController.text,
              'etat': etatController.text,
              'prix': prixController.text,
              'marque': marque,
              'lieu': modele,
              'carrosserie': type_carrosserieController.text,
              'modele': modele,
              'poignet': poignetController.text,
              'carburant': carburantController.text,
              'couleur': couleurController.text,
              'kilometrage': kilometrageController.text,
              'boite_vitesse': boite_vitesseController.text,
              'nombre_siege': nombre_siegeController.text,
              'nombre_porte': nombre_porteController.text,
              'annee': anneeController.text,
              'cylindre': cylindreController.text,
              "timestamp": FieldValue.serverTimestamp(),
            };
          } else if(widget.type == 'engin'){
            datas = {
              'image': images,
              'name': name.text,
              'key': keys,
              'code': codeController.text,
              'etat': etatController.text,
              'prix': prixController.text,
              'marque': marque,
              'lieu': modele,
              'carrosserie': type_carrosserieController.text,
              'modele': modele,
              'poignet': poignetController.text,
              'carburant': carburantController.text,
              'couleur': couleurController.text,
              'kilometrage': kilometrageController.text,
              'boite_vitesse': boite_vitesseController.text,
              'annee': anneeController.text,
              'cylindre': cylindreController.text,
              "timestamp": FieldValue.serverTimestamp(),
            };
          } else if(widget.type == 'camion'){
            datas = {
              'image': images,
              'name': name.text,
              'key': keys,
              'code': codeController.text,
              'etat': etatController.text,
              'prix': prixController.text,
              'marque': marque,
              'lieu': modele,
              'carrosserie': type_carrosserieController.text,
              'modele': modele,
              'poignet': poignetController.text,
              'carburant': carburantController.text,
              'couleur': couleurController.text,
              'kilometrage': kilometrageController.text,
              'boite_vitesse': boite_vitesseController.text,
              'nombre_roue': nombre_siegeController.text,
              'annee': anneeController.text,
              'cylindre': cylindreController.text,
              "timestamp": FieldValue.serverTimestamp(),
            };
          } else if (widget.type == 'track'){
            datas = {
              'image': images,
              'name': name.text,
              'key': keys,
              'code': codeController.text,
              'etat': etatController.text,
              'prix': prixController.text,
              'marque': marque,
              'lieu': modele,
              'carrosserie': type_carrosserieController.text,
              'modele': modele,
              'poignet': poignetController.text,
              'carburant': carburantController.text,
              'couleur': couleurController.text,
              'kilometrage': kilometrageController.text,
              'boite_vitesse': boite_vitesseController.text,
              'nombre_roue': nombre_siegeController.text,
              'annee': anneeController.text,
              'cylindre': cylindreController.text,
              "timestamp": FieldValue.serverTimestamp(),
            };
          } else if (widget.type == 'location'){
            datas = {
              'image': images,
              'name': name.text,
              'key': keys,
              'code': codeController.text,
              'etat': etatController.text,
              'prix': prixController.text,
              'marque': marque,
              'lieu': modele,
              'carrosserie': type_carrosserieController.text,
              'modele': modele,
              'poignet': poignetController.text,
              'carburant': carburantController.text,
              'couleur': couleurController.text,
              'kilometrage': kilometrageController.text,
              'boite_vitesse': boite_vitesseController.text,
              'nombre_roue': nombre_siegeController.text,
              'annee': anneeController.text,
              'cylindre': cylindreController.text,
              "timestamp": FieldValue.serverTimestamp(),
            };
          } else if (widget.type == 'piece'){
            datas = {
              'name': name.text,
              'key': keys,
              'code': codeController.text,
              'etat': etatController.text,
              'prix': prixController.text,
              'modele': modele,
              'image': images,
              "timestamp": FieldValue.serverTimestamp(),
            };
          } else if (widget.type == 'accessoire'){
            datas = {
              'name': name.text,
              'key': keys,
              'code': codeController.text,
              'etat': etatController.text,
              'prix': prixController.text,
              'modele': modele,
              'couleur': couleurController.text,
              'image': images,
              "timestamp": FieldValue.serverTimestamp(),
            };
          }

          marques
              .set(datas).then((value) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => vehiculeIndex(
                '${widget.type}'
            )),
          ));
        } catch (e) {
          print('error occured');
        }
      }
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }


  @override
  void initState() {
    if(widget.marque != null){
      name.text = widget.marque['name'];
      codeController.text = widget.marque['code'].toString();
      etatController.text = widget.marque['etat'].toString();
      modele = widget.marque['modele'].toString();
      marque = widget.marque['marque'].toString();
      prixController.text = widget.marque['prix'].toString();
      type_carrosserieController.text = widget.marque['carrosserie'].toString();
      poignetController.text = widget.marque['poignet'].toString();
      carburantController.text = widget.marque['carburant'].toString();
      couleurController.text = widget.marque['couleur'].toString();
      kilometrageController.text = widget.marque['kilometrage'].toString();
      boite_vitesseController.text = widget.marque['boite_vitesse'].toString();
      nombre_siegeController.text = widget.marque['nombre_siege'].toString();
      nombre_porteController.text = widget.marque['nombre_porte'].toString();
      anneeController.text = widget.marque['annee'].toString();
      cylindreController.text = widget.marque['cylindre'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Stream<QuerySnapshot> _marqueStream = FirebaseFirestore.instance
        .collection('donnees').doc('${widget.type}').collection('marque').snapshots();
    final Stream<QuerySnapshot> _modeleStream = FirebaseFirestore.instance
        .collection('donnees').doc('${widget.type}').collection('modele').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.marque != null ?
              'Update ${widget.marque['name']}' :
          'Add Item : ${widget.type}'
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding
            (
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xffFDCF09),
                      child: _photo != null
                          ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(File(_photo![0].path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,),
                      )
                          :
                      widget.marque != null ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(widget.marque['image'][0],
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,),
                      )
                          : Container(
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
                  ),
                ),
                SizedBox(
                  height: 32,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                          'Marque : ',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _marqueStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return DropdownButton(
                              value: marque,
                              items: snapshot.data!.docs.map((DocumentSnapshot document) {
                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                return DropdownMenuItem
                                  (child: Text('${data['name']}'),value: '${data['name']}');
                              }).toList(),
                            onChanged: (String? newValue){
                              setState(() {
                                marque = newValue!;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 8.0),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Modele : ',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _modeleStream,
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Something went wrong');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return
                            DropdownButton(
                            value: modele,
                            items: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                              return DropdownMenuItem
                                (child: Text('${data['name']}'),value: '${data['name']}');
                            }).toList(),
                            onChanged: (String? newValue){
                              setState(() {
                                modele = newValue!;
                              });
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 16.0),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Nom',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: codeController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Code Produit',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: etatController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: widget.type == "piece" || widget.type == "accessoire" ? 'Description' : 'Etat',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: prixController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Prix',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "piece" ? Container() :
                widget.type == "accessoire" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: type_carrosserieController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Type Carrosserie',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "piece" ? Container() :
                widget.type == "accessoire" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: poignetController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Poignet',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "piece" ? Container() :
                widget.type == "accessoire" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: carburantController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Carburant',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "location" ?
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: conduiteController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Conduite',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ) : SizedBox(),

                widget.type == "piece" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: couleurController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Couleur',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "piece" ? Container() :
                widget.type == "accessoire" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: kilometrageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Kilometrage',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "piece" ? Container() :
                widget.type == "accessoire" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: boite_vitesseController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Boite de vitesse',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "piece" ? Container() :
                widget.type == "accessoire" ? Container() :
                widget.type =="engin" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: nombre_siegeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: widget.type =="track" ? 'Nombre de roues' : widget.type =="camion" ? 'Nombre de roues' : 'Nombre de siège',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "piece" ? Container() :
                widget.type == "accessoire" ? Container() :
                widget.type =="engin" ? Container() :
                widget.type =="track" ? Container() :
                widget.type =="camion" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: nombre_porteController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Nombre des portes',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "piece" ? Container() :
                widget.type == "accessoire" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: anneeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Année',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                widget.type == "piece" ? Container() :
                widget.type == "accessoire" ? Container() :
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    controller: cylindreController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Cylindre',
                        labelStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 23,
                          color: Colors.grey,
                        ),
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: MediaQuery.of(context).size.width / 25
                        )
                    ),
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width / 22),
                  ),
                ),

                SizedBox(height: 20.0),

                OutlinedButton(
                    onPressed: (){
                      if(name.text.length < 1 || codeController.text.length < 1){
                        showMyDialog(context, 'item', 'Entrez le nom et le code de la marque');
                      }

                      if(widget.marque != null && _photo== null){
                        uploadFile(context);
                      } else if (_photo == null){
                        showMyDialog(context, 'item', 'Veuillez choisir une image.');
                      } else {
                        //showMyDialog(context, 'Publication', "En cours de publication");
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