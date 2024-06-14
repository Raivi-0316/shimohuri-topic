import 'package:flutter/material.dart';
import 'package:shimohuri_topic/app.dart';
import 'package:shimohuri_topic/page 3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(MyApp());
}

class MyHomePage1 extends StatefulWidget {
  static const roteName = '/myRoute';
  const MyHomePage1({super.key, required this.title,required this.url,});

  final String title;
  final String url;

  final AccountPage accountPage = const AccountPage(name:'name' ,passward:'passward',);

  static final FirebaseFirestore firestore = FirebaseFirestore.instance;


  @override
  State<MyHomePage1> createState() => MyHomePage2State();
}

const collectionKey = 'your_todo';

class MyHomePage2State extends State<MyHomePage1> {
  List<Item> items = [];
  late FirebaseFirestore firestore;
  late CollectionReference<Map<String, dynamic>> collection;
  final TextEditingController textEditingController = TextEditingController();

  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
    firestore = FirebaseFirestore.instance;
    collection =
        firestore.collection('rooms').doc(widget.title).collection('items');
    watch();
  }


  // データ更新監視
  Future<void> watch() async {
    collection.snapshots().listen((event) {
      if (mounted) {
        setState(() {
          items = event.docs.reversed
              .map(
                (document) => Item.fromSnapshot(
              document.id,
              document.data
                (),
            ),
          )
              .toList(growable: false);
        });
      }
    });
  }

  // 保存する
  Future<void> save() async {
    final now = DateTime.now();
    await collection.doc(now.millisecondsSinceEpoch.toString()).set({
      "date": Timestamp.fromDate(now),
      "name": widget.accountPage,
      "text": textEditingController.text,
    });
    textEditingController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

    );
  }
}



class Item {
  const Item({
    required this.id,
    required this.name,
    required this.text,
    required this.date,
  });

  final String id;
  final String name;
  final String text;
  final DateTime date;

  factory Item.fromSnapshot(String id, Map<String, dynamic> document) {
    return Item(
      id: id,
      name: document['name'].toString() ,
      text: document['text'].toString() ,
      date: (document['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
