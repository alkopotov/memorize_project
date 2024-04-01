import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memorize/data/models/user_model.dart';
import 'package:memorize/domain/auth_repository.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc(this.authRepository,
  ) : super(AuthInitialState()) {
    on<GetAuthEvent>(_getUser);
    on<SetAuthEvent>(_setUser);
    on<RemoveAuthEvent>(_removeUser);
  }

  final AuthRepository authRepository;

  Future<void> _getUser(GetAuthEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoadingState());

    try {
      final user = await authRepository.getUser();
      print(user.userName);
      emit(AuthLoadedState(user));
    } on Exception catch (e) {
      print ('Ошибка на _getUser'+e.toString());
      // emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _setUser(SetAuthEvent event, Emitter<AuthStates> emit) async {
    emit(AuthLoadedState(event.user));
    print('0');
    try {
      await authRepository.setUser(event.user);

      // print('1');
      // final user = await authRepository.getUser();
      print('2');
      // emit(AuthLoadedState(event.user));
      
    } catch (e) {
      print ('Ошибка на _setUser'+ e.toString());
      // emit(AuthErrorState(e.toString()));
    }
  }

  Future <void> _removeUser(RemoveAuthEvent event, Emitter<AuthStates> emit) async {
     emit(AuthInitialState());
    try {
      await authRepository.deleteUser();
      final user = await authRepository.getUser();
      emit (AuthLoadedState(user));
    } catch (e) {
      print ('Ошибка на _removeUser'+e.toString());
      // emit(AuthErrorState(e.toString()));
    }
  }
 
}
