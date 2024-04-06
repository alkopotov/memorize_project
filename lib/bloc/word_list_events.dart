import '../data/models/word_item_model.dart';

abstract class WordListEvents {}

class GetWordListEvent extends WordListEvents {}

class SetWordListEvent extends WordListEvents {
  SetWordListEvent({required this.wordList});
  final List<WordItemModel> wordList;
}

class DeleteWordEvent extends WordListEvents {
  DeleteWordEvent({required this.wordId});
  final String wordId;
}
class RemoveWordListEvent extends WordListEvents {}

