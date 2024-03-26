import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorize/domain/auth_repository.dart';

import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc(this.authRepository,
  ) : super(AuthInitialState()) {
    on<GetAuthEvent>(_getUser);
  }

  final AuthRepository authRepository;

  Future<void> _getUser(GetAuthEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoadingState());

    try {
      final user = await authRepository.getUser();
      emit(AuthLoadedState(user));
    } on Exception catch (e) {
      emit(AuthErrorState(e.toString()));
    }
}
}