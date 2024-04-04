import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/word_list_repository.dart';
import 'word_list_events.dart';
import 'word_list_states.dart';

class WordListBloc extends Bloc<WordListEvents, WordListStates> {
  WordListBloc(this.wordListRepository,
  ) : super(WordListInitialState()) {
    on<GetWordListEvent>(_getWordList);
    on<SetWordListEvent>(_setWordList);
    on<RemoveWordListEvent>(_removeWordList);
  }

  final WordListRepository wordListRepository;

  Future<void> _getWordList(GetWordListEvent event, Emitter<WordListStates> emit) async {
    emit(WordListLoadingState());
    try {
      final wordList = await wordListRepository.getWordList();
      emit(WordListLoadedState(wordList));
    } on Exception catch (e) {
      emit(WordListErrorState(e.toString()));
    }
  }

  Future<void> _setWordList(SetWordListEvent event, Emitter<WordListStates> emit) async {
    emit(WordListLoadingState());
    try {
      await wordListRepository.writeWordList(event.wordList);
      final wordList = await wordListRepository.getWordList();
      emit(WordListLoadedState(wordList));
    } on Exception catch (e) {
      emit(WordListErrorState(e.toString()));
    }
  }

  Future<void> _removeWordList(RemoveWordListEvent event, Emitter<WordListStates> emit) async {
    emit(WordListLoadingState());
    try {
      await wordListRepository.deleteWordList();
      final wordList = await wordListRepository.getWordList();
      emit(WordListLoadedState(wordList));
    } on Exception catch (e) {
      emit(WordListErrorState(e.toString()));
    }
  }
}   