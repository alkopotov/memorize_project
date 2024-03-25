import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorize/domain/users_repository.dart';

import 'user_events.dart';
import 'user_states.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  UserBloc(this.usersRepository,
  ) : super(UserInitialState()) {
    on<GetUserEvent>(_getUsers);
  }

  final UsersRepository usersRepository;

  Future<void> _getUsers(GetUserEvent event, Emitter<UserStates> emit) async {
    emit(UserLoadingState());

    try {
      final users = await usersRepository.getUsers();
      emit(UserLoadedState(users));
    } on Exception catch (e) {
      emit(UserErrorState(e.toString()));
    }
}
}