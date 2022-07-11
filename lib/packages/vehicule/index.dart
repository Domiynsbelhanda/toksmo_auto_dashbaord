import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toksmo_auto_dashbaord/packages/marque/marque.dart';
import 'package:toksmo_auto_dashbaord/packages/marque/modele.dart';
import 'package:toksmo_auto_dashbaord/widget/itemTable.dart';
import 'package:toksmo_auto_dashbaord/widget/marqueTable.dart';

import '../../widget/modeleTable.dart';
import '../marque/item.dart';

class vehiculeIndex extends StatefulWidget{
  String type;
  vehiculeIndex(this.type);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _vehiculeIndex();
  }
}

class _vehiculeIndex extends State<vehiculeIndex>{

  String datas = 'marque';

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _marqueStream = FirebaseFirestore.instance
        .collection('donnees').doc('${widget.type}').collection('marque').snapshots();
    final Stream<QuerySnapshot> _itemStream = FirebaseFirestore.instance
        .collection('donnees').doc('${widget.type}').collection('item').snapshots();
    final Stream<QuerySnapshot> _modeleStream = FirebaseFirestore.instance
        .collection('donnees').doc('${widget.type}').collection('modele').snapshots();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GESTION ${widget.type.toUpperCase()}'
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
                          MaterialPageRoute(builder: (context) => Marque(type: '${widget.type}')),
                        );
                      },
                      child: Text('ADD MARQUE'),
                    ),

                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Modele(type: '${widget.type}')),
                        );
                      },
                      child: Text('ADD MODELE'),
                    ),

                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Item(type: '${widget.type}')),
                        );
                      },
                      child: Text('ADD ITEM'),
                    )
                  ],
                ),

                SizedBox(height: 8.0),

                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          datas = 'marque';
                        });
                      },
                      child: Container(
                        child: Card(
                          elevation: 5.0,
                          color: datas == 'marque' ? Colors.lightBlueAccent : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: _marqueStream,
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error');
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Text("Loading");
                                  }

                                  return Text(
                                      '${snapshot.data!.docs.length.toString()} Marque(s)'
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          datas = 'modele';
                        });
                      },
                      child: Container(
                        child: Card(
                          elevation: 5.0,
                          color: datas == 'modele' ? Colors.lightBlueAccent : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: _marqueStream,
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error');
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Text("Loading");
                                  }

                                  return Text(
                                      '${snapshot.data!.docs.length.toString()} Modele(s)'
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        setState(() {
                          datas = 'item';
                        });
                      },
                      child: Container(
                        child: Card(
                          elevation: 5.0,
                          color: datas == 'item' ? Colors.lightBlueAccent : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: StreamBuilder<QuerySnapshot>(
                                stream: _itemStream,
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Error');
                                  }

                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Text("Loading");
                                  }

                                  return Text(
                                      '${snapshot.data!.docs.length.toString()} Item (s)'
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.0,),

                Container(
                  child: datas == 'marque' ?
                  marqueTable(context, widget.type, _marqueStream) :
                      datas == 'item' ?
                  itemTable(context, widget.type, _itemStream) :
                  modeleTable(context, widget.type, _modeleStream),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}