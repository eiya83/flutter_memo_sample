import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/top_page.dart';

void main() async{
  // メイン関数asyncのおまじない
  WidgetsFlutterBinding.ensureInitialized();
  // firebase初期化
  await Firebase.initializeApp();
  // app実行
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const TopPage(title: 'Flutter Demo Home Page'),
    );
  }
}

