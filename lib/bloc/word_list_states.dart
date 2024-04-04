
import 'package:memorize/data/models/word_item_model.dart';

abstract class WordListStates {}

class WordListInitialState extends WordListStates {}

class WordListLoadingState extends WordListStates {}

class WordListLoadedState extends WordListStates {
  WordListLoadedState(this.wordList);
  final List<WordItemModel> wordList;
}

class WordListErrorState extends WordListStates {
  WordListErrorState(this.message);
  final String message;
}

class WordListSavingState extends WordListStates {}

class WordListDeletingState extends WordListStates {}
