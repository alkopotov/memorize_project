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

  late String wordItemTitle = '';
  late String wordItemMeaning = '';


  handleAddWord() {
    setState(() {
      getIt<WordListBloc>().add(SetWordListEvent(wordList: [...wordList, WordItemModel(wordItemId: uuid.v4(), wordItemTitle: wordItemTitle, wordItemMeaning: wordItemMeaning, wordItemScore: 0)]));
      wordList = getIt<WordListBloc>().state is WordListLoadedState ? (getIt<WordListBloc>().state as WordListLoadedState).wordList : [];
      wordItemTitle = '';
      wordItemMeaning = '';
    });
  }

  handleDeleteWordList(){
    setState(() {
      getIt<WordListBloc>().add(SetWordListEvent(wordList: []));
      wordList = getIt<WordListBloc>().state is WordListLoadedState ? (getIt<WordListBloc>().state as WordListLoadedState).wordList : [];
    });
  }

  @override
  void initState() {
    wordList = getIt<WordListBloc>().state is WordListLoadedState ? (getIt<WordListBloc>().state as WordListLoadedState).wordList : [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Добавить слово'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => wordItemTitle = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Слово',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => wordItemMeaning = value,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Значение',
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                handleAddWord();
              },
              child: const Text('Добавить'),
            ),
            Center(
              child: Text(
                'Изучаемые слова: ${wordList.length}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                )
              ),
            ),
            ElevatedButton(onPressed:() {
              handleDeleteWordList();
            }, child: const Text('Очистить')),
            BlocBuilder<WordListBloc, WordListStates>(
              bloc: getIt<WordListBloc>(),
              builder: (context, state) {
                if (state is WordListLoadedState) {
                  wordList = state.wordList;
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: wordList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('${wordList[index].wordItemTitle}: ${wordList[index].wordItemMeaning}'), 
                        subtitle: Text(wordList[index].wordItemScore.toString()),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      )
    );
  }
}