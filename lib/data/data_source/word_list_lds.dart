import 'dart:convert';

import 'package:memorize/data/models/word_item_model.dart';

import 'word_list_local_storage.dart';

class WordListLDS {
  Future <List<WordItemModel>> getWordList() async {
    final data = await WordListLocalStorage().readData();
    if (data == '') {
      return [ 
        WordItemModel(wordItemId: '1', wordItemTitle: 'hello', wordItemMeaning: 'привет', wordItemScore: 25),
        WordItemModel(wordItemId: '2', wordItemTitle: 'goodbye', wordItemMeaning: 'до свидания', wordItemScore: 25)
      ];
    }
    return (jsonDecode(data) as List).map((e) => WordItemModel.fromJson(e)).toList();
  }

  Future <void> writeWordList(List<WordItemModel> wordList) async {
    await WordListLocalStorage().writeData(jsonEncode(wordList));
  }

  Future <void> deleteData() async {
    await WordListLocalStorage().deleteData();
  }
}

