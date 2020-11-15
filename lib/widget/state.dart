import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:owlbot_dart/owlbot_dart.dart';

final searchTextProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

final searchResultProvider = StateProvider<OwlBotResponse>((ref) => null);
final loadingProvider = StateProvider<bool>((ref) => false);
final errorProvider = StateProvider<String>((ref) => '');
