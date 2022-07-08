import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> showMyDialog(BuildContext context, titre, String content) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titre),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('Fermer'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> delete(BuildContext context, String titre, String content, String type, String obj, String key) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titre),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('Oui'),
            onPressed: () {
              FirebaseFirestore.instance.collection('donnees')
                  .doc(type).collection(obj)
                  .doc(key).delete();
              Navigator.pop(context);
            },
          ),

          TextButton(
            child: const Text('Non'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}