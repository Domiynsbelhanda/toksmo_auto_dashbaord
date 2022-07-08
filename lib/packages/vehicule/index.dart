import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toksmo_auto_dashbaord/packages/marque/marque.dart';
import 'package:toksmo_auto_dashbaord/widget/itemTable.dart';
import 'package:toksmo_auto_dashbaord/widget/marqueTable.dart';

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

  String? title;
  String datas = 'marque';

  @override
  void initState() {
    widget.type == 'vehicule' ?
        title = 'GESTION DES VEHICULES' :
        title = '';
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _marqueStream = FirebaseFirestore.instance
        .collection('donnees').doc('${widget.type}').collection('marque').snapshots();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$title'
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
                              child: Text(
                                  '120 ITEMS'
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.0,),

                datas == 'marque' ?
                    marqueTable(context, widget.type) :
                    itemTable(context, widget.type),
              ],
            ),
          ),
        ),
      ),
    );
  }
}