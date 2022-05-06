import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/memo.dart';

class MemoPage extends StatelessWidget{
  // const MemoPage({Key? key, required "test"}) : super(key: key);
  final QueryDocumentSnapshot memo;
  MemoPage(this.memo);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar (
        title: Text((memo.data() as Map)['title']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text((memo.data() as Map)['detail'],style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            Text((memo.data() as Map)['created'].toString(),style: TextStyle(fontSize: 25),),
          ],
        ),
      ),
    );
  }

}