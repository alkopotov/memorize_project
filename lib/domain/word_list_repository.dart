import '../data/data_source/word_list_lds.dart';
import '../data/models/word_item_model.dart';

class WordListRepository {
  WordListRepository( this.wordListLDS);
  final WordListLDS wordListLDS;
  Future <List<WordItemModel>> getWordList() async {
    return await wordListLDS.getWordList();
  }

  Future <void> writeWordList(List<WordItemModel> wordList) async {
    await wordListLDS.writeWordList(wordList);
  }

  Future <void> deleteWordList() async {
    await wordListLDS.deleteData();
  }
}