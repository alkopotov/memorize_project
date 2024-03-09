
import 'package:memorize/data/models/word_item_model.dart';

class WordListModel {
  WordListModel({
    required this.userId
  });

  final String userId;
  List<WordItemModel> _items = [];

  int get itemsNumber {
    return _items.length;
  }

  List<WordItemModel> get items {
    return _items;
  }

  bool includesWord(String title, String meaning) {
    for (var e in _items) {
      if (e.wordItemTitle == title && e.wordItemMeaning == meaning) {
        return true;
      }
    }
    return false;
  }

  // Будем ли мы проверять уникальность слова (значение - перевод) ?
  void addWordItem(WordItemModel wordItem) {
    if (!includesWord(wordItem.wordItemTitle, wordItem.wordItemMeaning)) {
      _items.add(wordItem);
    }
  }
}