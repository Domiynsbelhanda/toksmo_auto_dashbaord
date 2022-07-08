import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toksmo_auto_dashbaord/widget/alert.dart';
import 'package:uuid/uuid.dart';

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

  TextEditingController name = new TextEditingController();
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
      marques
          .set({
        'name': name.text,
        'image': widget.marque['image'],
        'key' : widget.marque['key']
      }).then((value) => Navigator.push(
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

          marques
              .set({
            'image': images,
            'name': name.text,
            'key' : keys
          }).then((value) => Navigator.push(
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
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          height: MediaQuery.of(context).
          size.height - 100,
          child: Padding
            (
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 16.0,
                ),
                Container(
                  child: TextField(
                    controller: name,decoration: InputDecoration(
                    border: OutlineInputBorder(
                    ),
                    labelText: 'Nom',),
                  ),
                ),
                SizedBox(
                  height: 32,
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

                SizedBox(height: 20.0),

                OutlinedButton(
                    onPressed: (){
                      if(name.text.length < 1){
                        showMyDialog(context, 'Marque', 'Entrez le nom de la marque');
                      }

                      if(widget.marque != null && _photo== null){
                        uploadFile(context);
                      } else if (_photo == null){
                        showMyDialog(context, 'Marque', 'Veuillez choisir une image.');
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