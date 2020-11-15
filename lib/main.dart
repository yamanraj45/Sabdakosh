import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:owlbot_dart/owlbot_dart.dart';
import 'package:sabdakosh/Screen/favorite.dart';
import 'package:sabdakosh/Screen/history.dart';
import 'package:sabdakosh/Screen/home.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:sabdakosh/widget/adapter_word.dart';
import 'package:sabdakosh/widget/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(OwlBotResAdapter());
  Hive.registerAdapter(OwlBotDefinitionAdapter());
  await Hive.openBox<OwlBotResponse>(favoritebox);
  await Hive.openBox<OwlBotResponse>(historybox);
  runApp(
    ProviderScope(
      child: DictionaryMain(),
    ),
  );
}

class DictionaryMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DictionaryHome(),
    );
  }
}

class DictionaryHome extends StatefulWidget {
  @override
  _DictionaryHomeState createState() => _DictionaryHomeState();
}

class _DictionaryHomeState extends State<DictionaryHome> {
  int _bottomNavigationBar = 1;
  List bodyPlace = [History(), Home(), Favorites()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SabdaKosh'),
        centerTitle: true,
      ),
      body: bodyPlace[_bottomNavigationBar],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.red,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.shifting,
          onTap: (value) {
            setState(() {
              _bottomNavigationBar = value;
            });
          },
          currentIndex: _bottomNavigationBar,
          elevation: 2,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('History'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favorite'),
            ),
          ]),
    );
  }
}
