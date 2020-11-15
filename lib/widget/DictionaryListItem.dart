import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:owlbot_dart/owlbot_dart.dart';
import 'package:sabdakosh/widget/constant.dart';
import 'package:sabdakosh/widget/state.dart';

class DictionaryList extends ConsumerWidget {
  final OwlBotResponse response;
  DictionaryList(this.response);

  @override
  Widget build(BuildContext context, watch) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        response.word,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable:
                            Hive.box<OwlBotResponse>(favoritebox).listenable(),
                        builder: (context, box, _) {
                          return IconButton(
                            icon: Icon(Icons.star),
                            color: box.containsKey(response.word)
                                ? Colors.orange
                                : null,
                            onPressed: () {
                              final box = Hive.box<OwlBotResponse>(favoritebox);
                              if (box.containsKey(response.word)) {
                                box.delete(response.word);
                              } else {
                                box.put(response.word, response);
                              }
                            },
                            iconSize: 30,
                          );
                        })
                  ],
                ),
                if (response.pronunciation != null) ...[
                  Text(response.pronunciation),
                ],
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ...response.definitions.map(
                              (e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    e.type,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(e.definition),
                                  if (e.example != null) ...[
                                    Text(
                                      '\n${e.example}',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ],
                                  if (e.imageUrl != null) ...[
                                    Image.network(e.imageUrl),
                                  ],
                                  Text('\n'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
