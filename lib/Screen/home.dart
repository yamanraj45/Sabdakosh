import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:hive/hive.dart';
import 'package:owlbot_dart/owlbot_dart.dart';
import 'package:sabdakosh/widget/DictionaryListItem.dart';
import 'package:sabdakosh/widget/constant.dart';
import 'package:sabdakosh/widget/state.dart';

_search(BuildContext context) async {
  FocusScope.of(context).requestFocus(FocusNode());
  final word = context.read(searchTextProvider).state.text;
  final box = Hive.box<OwlBotResponse>(historybox);
  context.read(loadingProvider).state = true;
  final res = await OwlBot(token: '46f8c4a77bc03fb6f9f1aae7995011c41932f5b4')
      .define(word: word);
  if (res == null) {
    context.read(errorProvider).state = '404 Not Found';
  } else {
    box.put(res.word, res);
  }
  context.read(errorProvider).state = null;
  context.read(searchResultProvider).state = res;
  context.read(loadingProvider).state = false;
}

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final searchResult = watch(searchResultProvider).state;
    final loading = watch(loadingProvider).state;
    final errorText = watch(errorProvider).state;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: watch(searchTextProvider).state,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                hintText: 'Search For Words',
                contentPadding: EdgeInsets.all(8.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onEditingComplete: () {
                _search(context);
              },
            ),
          ),
          if (errorText != null && errorText.isNotEmpty) ...[
            Card(
              child: ListTile(
                title: Text(watch(searchTextProvider).state.text),
                subtitle: Text(errorText),
                trailing: Icon(Icons.error),
              ),
            )
          ],
          if (searchResult != null) ...[DictionaryList(searchResult)],
        ],
      ),
    );
  }
}
