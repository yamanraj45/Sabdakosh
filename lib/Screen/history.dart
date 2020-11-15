import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:owlbot_dart/owlbot_dart.dart';
import 'package:sabdakosh/widget/DictionaryListItem.dart';
import 'package:sabdakosh/widget/constant.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<OwlBotResponse>(historybox).listenable(),
      builder: (context, box, child) {
        final historys = box.values;
        return ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            ...historys.map(
              (history) {
                final res = history;
                return DictionaryList(history);
              },
            ),
          ],
        );
      },
    );
  }
}
