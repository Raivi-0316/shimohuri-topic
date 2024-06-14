import 'package:flutter/material.dart';
import 'package:shimohuri_topic/page 1.dart';
import 'package:shimohuri_topic/page 2.dart';
import 'package:shimohuri_topic/page 3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//void main() {
//  runApp(const MyApp());
//}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp ({Key? key}):super(key:key);

   static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) {
          Widget error = const Text('...rendering error...');
          if (widget is Scaffold || widget is Navigator) {
            error = Scaffold(body: Center(child: error));
          }
          ErrorWidget.builder = (errorDetails) => error;
          if (widget != null) return widget;
          throw StateError('widget is null');
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  const MyStatefulWidget1()

    );
  }
}



class MyStatefulWidget1 extends StatefulWidget {
  const MyStatefulWidget1({super.key});

  @override
  State<MyStatefulWidget1> createState() => _MyStatefulWidgetState1();
}

class _MyStatefulWidgetState1 extends State<MyStatefulWidget1> {
  static final _screens =[
    const MyHomePage(),
    const PageB(),
    const AccountPage(name: 'name', passward: 'passward'),
  ];


  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'ブック'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'アカウント'),
          ],
          type: BottomNavigationBarType.fixed,
        )
    );
  }
}






