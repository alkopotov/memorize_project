import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/word_item_model.dart';
import '../domain/word_list_repository.dart';
import 'word_list_events.dart';
import 'word_list_states.dart';

class WordListBloc extends Bloc<WordListEvents, WordListStates> {
  WordListBloc(this.wordListRepository,
  ) : super(WordListInitialState()) {
    on<GetWordListEvent>(_getWordList);
    on<SetWordListEvent>(_setWordList);
    on<RemoveWordListEvent>(_removeWordList);
    on<DeleteWordEvent>(_deleteWord);
  }

  final WordListRepository wordListRepository;

  List<WordItemModel> wordList = [];
  
  Future<void> _getWordList(GetWordListEvent event, Emitter<WordListStates> emit) async {
    emit(WordListLoadingState());
    try {
      wordList = await wordListRepository.getWordList();
      emit(WordListLoadedState(wordList));
    } catch (e) {
      emit(WordListErrorState(e.toString()));
    }
  }

  Future<void> _setWordList(SetWordListEvent event, Emitter<WordListStates> emit) async {
    emit(WordListLoadedState(event.wordList));
    try {
      await wordListRepository.writeWordList(event.wordList);
      wordList = await wordListRepository.getWordList();
      emit(WordListLoadedState(wordList));
    } catch (e) {
      emit(WordListErrorState(e.toString()));
    }
  }

  
  Future<void> _deleteWord(DeleteWordEvent event, Emitter<WordListStates> emit) async {
    final newWordList = wordList.where((element) => element.wordItemId != event.wordId).toList();
    emit(WordListLoadingState());
    try {
      await wordListRepository.writeWordList(newWordList);
      wordList = await wordListRepository.getWordList();
      emit(WordListLoadedState(wordList));
    } catch (e) {
      emit(WordListErrorState(e.toString()));
    }
  }

  Future<void> _removeWordList(RemoveWordListEvent event, Emitter<WordListStates> emit) async {
    emit(WordListLoadingState());
    try {
      await wordListRepository.deleteWordList();
      wordList = await wordListRepository.getWordList();
      emit(WordListLoadedState(wordList));
    } catch (e) {
      emit(WordListErrorState(e.toString()));
    }
  }
}   