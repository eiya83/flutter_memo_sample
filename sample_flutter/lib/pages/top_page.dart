import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sample_flutter/model/memo.dart';
import 'package:sample_flutter/pages/memo_page.dart';

import 'add_memo_edit_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning

  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  //List<Memo> memoList=[];
  CollectionReference? memos;

  Future<void> deleteMemo(String docId) async{
    var document = FirebaseFirestore.instance.collection('memo').doc(docId);
    document.delete();
  }

  @override
  void initState(){
    super.initState();
    memos = FirebaseFirestore.instance.collection('memo');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(

      appBar: AppBar(
        title: const Text('Firebase × Flutter'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: memos!.snapshots(),
        builder: (context,snapshots){
          return ListView.builder(
            itemCount: snapshots.data!.docs.length,
            itemBuilder: (context,index){
              var objMap = snapshots.data!.docs[index].data() as Map;
              return ListTile(
                title: Text(objMap['title']),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: (){
                    showModalBottomSheet(context: context, builder: (context){
                      return SafeArea(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.edit,color: Colors.blueAccent,),
                                title: const Text('編集'),
                                onTap: (){
                                  Navigator.pop(context);
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditMemoPage(snapshots.data!.docs[index])));
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.delete,color: Colors.redAccent),
                                title: const Text('削除'),
                                onTap: () async{
                                  await deleteMemo(snapshots.data!.docs[index].id);
                                  Navigator.pop(context);
                                },
                              )
                            ],
                        ),
                      );
                    });
                  },
                ),
                onTap: () {
                  // 確認画面に遷移
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MemoPage(snapshots.data!.docs[index])));
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditMemoPage(null)));

        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
