import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:owlbot_dart/owlbot_dart.dart';
import 'package:sabdakosh/widget/DictionaryListItem.dart';
import 'package:sabdakosh/widget/constant.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<OwlBotResponse>(favoritebox).listenable(),
      builder: (context, box, child) {
        final favs = box.values;
        return ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            ...favs.map(
              (fav) {
                final res = fav;
                return DictionaryList(fav);
              },
            ),
          ],
        );
      },
    );
  }
}
