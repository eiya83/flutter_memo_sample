import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddEditMemoPage extends StatefulWidget{

  final QueryDocumentSnapshot? memo;
  AddEditMemoPage(this.memo);

  @override
  _AddEditMemoPageState createState() => _AddEditMemoPageState();

}

class _AddEditMemoPageState extends State<AddEditMemoPage>{
  TextEditingController titleController = TextEditingController();
  TextEditingController detailController = TextEditingController();

  Future<void> addMemo() async{
    var collection = FirebaseFirestore.instance.collection('memo');
    collection.add({
      'title':titleController.text,
      'detail':detailController.text,
      'created':Timestamp.now(),
      'updated':Timestamp.now(),
    });
  }

  Future<void> updateMemo() async{
    var document = FirebaseFirestore.instance.collection('memo').doc(widget.memo!.id);
    document.update({
      'title':titleController.text,
      'detail':detailController.text,
      'updated':Timestamp.now(),
    });
  }

  @override
  void initState() {
    super.initState();
    if(widget.memo != null){
      var memoMap = widget.memo!.data() as Map;
      titleController.text = memoMap['title'];
      detailController.text = memoMap['detail'];
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title:Text(widget.memo == null ? 'メモ追加':'メモ編集'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top:40),
              child: Text('タイトル'),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
                ),
                width: MediaQuery.of(context).size.width*0.8,
                child: TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left:10)
                  ),
                )
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top:40),
              child:Text('メモ内容'),
            ),
            Padding(
              padding: const EdgeInsets.only(top:15),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: detailController,
                    decoration:const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left:10)
                    ),
                  )
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top:20) ,
              width: MediaQuery.of(context).size.width * 0.8,
              alignment: Alignment.center,
              child: ElevatedButton( onPressed: () async{
                if(widget.memo != null) {
                  await updateMemo();
                }else{
                  await addMemo();
                }
                Navigator.pop(context);
              },
              child: Text(widget.memo == null ? 'メモ追加':'メモ編集'),),
            )
          ],
        ),
      ),
    );
  }
}