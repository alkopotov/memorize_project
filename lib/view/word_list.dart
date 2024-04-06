import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../bloc/word_list_bloc.dart';
import '../bloc/word_list_events.dart';
import '../bloc/word_list_states.dart';
import '../data/models/word_item_model.dart';
import '../main.dart';

var uuid = const Uuid();

class WordListPage extends StatefulWidget {
  const WordListPage({super.key});

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  late List<WordItemModel> wordList;

  final worldItemTitleController = TextEditingController();
  final worldItemMeaningController = TextEditingController();

  bool isNewWord() {
    for (var word in wordList) {
      if (word.wordItemTitle == worldItemTitleController.text &&
          word.wordItemMeaning == worldItemMeaningController.text) {
        return false;
      }
    }
    return true;
  }

  handleAddWord() {
    setState(() {
      if (isNewWord() &&
          (worldItemTitleController.text != '') &&
          (worldItemMeaningController.text != '')) {
        getIt<WordListBloc>().add(SetWordListEvent(wordList: [
          ...wordList,
          WordItemModel(
              wordItemId: uuid.v4(),
              wordItemTitle: worldItemTitleController.text,
              wordItemMeaning: worldItemMeaningController.text,
              wordItemScore: 0)
        ]));
        wordList = getIt<WordListBloc>().state is WordListLoadedState
            ? (getIt<WordListBloc>().state as WordListLoadedState).wordList
            : [];
        worldItemTitleController.clear();
        worldItemMeaningController.clear();
      }
    });
  }

  handleDeleteWordList() {
    setState(() {
      getIt<WordListBloc>().add(SetWordListEvent(wordList: []));
      wordList = getIt<WordListBloc>().state is WordListLoadedState
          ? (getIt<WordListBloc>().state as WordListLoadedState).wordList
          : [];
    });
  }

  handleDeleteWordItem(String wordItemId) {
    getIt<WordListBloc>().add(DeleteWordEvent(wordId: wordItemId));
    wordList = getIt<WordListBloc>().state is WordListLoadedState
        ? (getIt<WordListBloc>().state as WordListLoadedState).wordList
        : [];
  }

  @override
  void initState() {
    wordList = getIt<WordListBloc>().state is WordListLoadedState
        ? (getIt<WordListBloc>().state as WordListLoadedState).wordList
        : [];
    super.initState();
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WordListBloc, WordListStates>(
        bloc: getIt<WordListBloc>(),
        builder: (context, state) {
          if (state is WordListLoadedState) {
            wordList = state.wordList;
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Добавить слово'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  child: TextField(
                    controller: worldItemTitleController,
                    onChanged: (value) => worldItemTitleController.text = value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Слово',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
                  child: TextField(
                    controller: worldItemMeaningController,
                    onChanged: (value) => worldItemMeaningController.text = value,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Значение',
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 16, top: 0),
                  child: ElevatedButton(
                    onPressed: () {
                      handleAddWord();
                    },
                    child: const Text('Добавить слово'),
                  ),
                ),
                Center(
                  child: Text('Изучаемые слова: ${wordList.length}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                ElevatedButton(
                    onPressed: () {
                      handleDeleteWordList();
                    },
                    child: const Text('Очистить список')),
                Expanded(
                  child: ListView.builder(
                    itemCount: wordList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 1.0),
                        title: Text(
                            '${wordList[index].wordItemTitle}: ${wordList[index].wordItemMeaning}'),
                        subtitle:
                            Text('рейтинг: ${wordList[index].wordItemScore.toString()}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            handleDeleteWordItem(wordList[index].wordItemId);
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
