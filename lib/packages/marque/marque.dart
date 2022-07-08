import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toksmo_auto_dashbaord/widget/alert.dart';

class Marque extends StatefulWidget {

  final String type;

  Marque(this.type);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Marque();
  }
}

class _Marque extends State<Marque> {

  TextEditingController name = new TextEditingController();
  BuildContext? contexte;

  FirebaseStorage storage =
      FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile(BuildContext context) async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = '${widget.type}/marque/$fileName';

    try {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child("images")
          .child(destination);
      String downloadURL;

      UploadTask uploadTask = storageReference.putFile(_photo!);
      downloadURL = await (await uploadTask).ref.getDownloadURL();
      CollectionReference marques = FirebaseFirestore.instance
          .collection('donnees')
          .doc('${widget.type}')
          .collection('marque');
      marques
          .add({
            'name': name.text,
            'image': downloadURL,
          });
      Navigator.pop(context);
    } catch (e) {
      print('error occured');
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Marqe : ${widget.type}'
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
                SizedBox
                  (
                  height: 32
                  ,
                )
                ,
                Center
                  (
                  child: GestureDetector
                    (
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar
                      (
                      radius: 55
                      ,
                      backgroundColor: Color
                        (0xffFDCF09)
                      ,
                      child: _photo != null
                          ?
                      ClipRRect
                        (
                        borderRadius: BorderRadius.circular(50
                        )
                        ,
                        child: Image.file(_photo!,
                          width: 100
                          ,
                          height: 100
                          ,
                          fit: BoxFit.fitHeight,)
                        ,
                      )
                          :
                      Container
                        (
                        decoration: BoxDecoration
                          (
                            color: Colors.grey[200
                            ]
                            ,
                            borderRadius: BorderRadius.circular(50
                            )
                        )
                        ,
                        width: 100
                        ,
                        height: 100
                        ,
                        child: Icon
                          (
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

                      if (_photo == null){
                        showMyDialog(context, 'Marque', 'Veuillez choisir une image.');
                      }
                      uploadFile(context);
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