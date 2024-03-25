class WordItemModel {
  WordItemModel({
    required this.wordItemId,
    required this.wordItemTitle,
    required this.wordItemMeaning,
    required this.wordItemScore
  });

  final String wordItemId;
  final String wordItemTitle;
  final String wordItemMeaning;
  late int wordItemScore;

 
  Map<String, dynamic> toJson() => {
    'wordItemId': wordItemId,
    'wordItemTitle': wordItemTitle,
    'wordItemMeaning': wordItemMeaning,
    'wordItemScore': wordItemScore
  };

  factory WordItemModel.fromJson(Map<String, dynamic> json) => WordItemModel(
    wordItemId: json['wordItemId'],
    wordItemTitle: json['wordItemTitle'],
    wordItemMeaning: json['wordItemMeaning'],
    wordItemScore: json['wordItemScore'],
  );
}