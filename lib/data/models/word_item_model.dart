class WordItemModel {
  WordItemModel({
    required this.wordItemId,
    required this.wordItemTitle,
    required this.wordItemMeaning,
  });

  final String wordItemId;
  final String wordItemTitle;
  final String wordItemMeaning;
  late int _wordItemScore = 0;

  int get wordItemScore {
    return _wordItemScore;
  }

   set wordItemScore(number) {
    _wordItemScore = number;
  } 

}