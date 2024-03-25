
import 'package:memorize/data/models/word_item_model.dart';


class WordListModel {
  WordListModel({
    required this.userId,
    required this.items
  });

  final String userId;
  List<WordItemModel> items;


  bool includesWord(String title, String meaning) {
    for (var e in items) {
      if (e.wordItemTitle == title && e.wordItemMeaning == meaning) {
        return true;
      }
    }
    return false;
  }

  void addWordItem(WordItemModel wordItem) {
    if (!includesWord(wordItem.wordItemTitle, wordItem.wordItemMeaning)) {
      items.add(wordItem);
    }
  }

 Map<String, dynamic> toJson() => {
    'userId': userId,
    'items': items
  };

  factory WordListModel.fromJson(Map<String, dynamic> json) => WordListModel(
    userId: json['userId'],
    items: (json['items'] as List).map((e) => WordItemModel.fromJson(e)).toList(),
  );
}
