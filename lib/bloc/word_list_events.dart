import '../data/models/word_item_model.dart';

abstract class WordListEvents {}

class GetWordListEvent extends WordListEvents {}

class SetWordListEvent extends WordListEvents {
  SetWordListEvent({required this.wordList});
  final List<WordItemModel> wordList;
}

class RemoveWordListEvent extends WordListEvents {}

